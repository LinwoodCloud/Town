use std::{pin::Pin, sync::{Arc, Mutex}, thread::Thread};

use flutter_rust_bridge::{frb, DartFnFuture};
use mlua::prelude::*;
use std::future::Future;
use futures::executor::block_on;

pub struct LuauPlugin {
    engine: Arc<Mutex<Lua>>,
    code: String,
}

pub struct PluginCallback {
    on_print: Arc<dyn Fn(String) -> Pin<Box<dyn Future<Output = ()> + Send>> + Send + Sync>,
}

impl Default for PluginCallback {
    fn default() -> Self {
        Self {
            on_print: Arc::new(|s| Box::pin(async move { println!("{}", s); })),
        }
    }
}

impl PluginCallback {
    pub fn change_on_print(&mut self, on_print: impl Fn(String) -> DartFnFuture<()> + 'static + Send + Sync) {
        let on_print = Arc::new(on_print);
        self.on_print = Arc::new(move |s| {
            let on_print = on_print.clone();
            Box::pin(async move { on_print(s).await; })
        });
    }
}

impl PluginCallback {
    fn construct_on_print(&self, engine: &Lua) -> LuaResult<LuaFunction> {
        let on_print = self.on_print.clone();
        engine.create_function(move |_, s : String| {
            block_on(on_print(s));
            Ok(())
        })
    }

    fn construct_globals(&self, engine: &Lua) -> LuaResult<()> {
        engine.globals().set("print", self.construct_on_print(engine)?)?;
        Ok(())
    }
}

impl LuauPlugin {
    #[frb(sync)]
    pub fn new(code: String, callback: PluginCallback) -> anyhow::Result<Self> {
        let engine = Lua::new();
        engine.sandbox(true).unwrap();
        callback.construct_globals(&engine).unwrap();
        let engine = Arc::new(Mutex::new(engine));
        Ok(Self { engine, code })
    }

    pub fn run(&self) -> anyhow::Result<()> {
        Ok(self.engine.lock().unwrap().load(&self.code).exec().unwrap())
    }
}
