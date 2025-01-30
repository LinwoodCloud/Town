use std::{collections::{HashMap, HashSet}, pin::Pin, sync::{Arc, Mutex}};

use flutter_rust_bridge::{frb, DartFnFuture};
use futures::executor::block_on;
use serde::{Deserialize, Serialize};
use mlua::prelude::*;
pub(crate) use serde_json::{Map, Value};
use std::future::Future;

pub struct PluginCallback {
    on_print: Arc<dyn Fn(String) -> Pin<Box<dyn Future<Output = ()> + Send>> + Send + Sync>,
}

impl Default for PluginCallback {
    fn default() -> Self {
        Self {
            on_print: Arc::new(|s| {
                Box::pin(async move {
                    println!("{}", s);
                })
            }),
        }
    }
}

impl PluginCallback {
    pub fn change_on_print(&mut self, on_print: impl Fn(String) -> DartFnFuture<()> + 'static + Send + Sync) {
        self.on_print = Arc::new(Box::new(on_print)); // or sth like that
    }
}

impl PluginCallback {
    fn construct_on_print(&self, engine: &Lua) -> LuaResult<LuaFunction> {
        let on_print = self.on_print.clone();
        engine.create_function(move |_, s: String| {
            block_on(on_print(s));
            Ok(())
        })
    }

    fn construct_globals(&self, engine: &Lua) -> LuaResult<()> {
        engine.globals().set("print", self.construct_on_print(engine)?)?;
        Ok(())
    }
}

#[derive(Default)]
pub struct LuauEventSystem {
    event_handlers: Arc<Mutex<HashMap<String, Vec<LuaFunction>>>>
}

impl LuauEventSystem {
    fn construct_event_handler(&self, engine: &Lua) -> LuaResult<LuaFunction> {
        let event_handlers = Arc::clone(&self.event_handlers);
        engine.create_function(move |_, (event, handler)| {
            let mut handlers = event_handlers.lock().unwrap();
            handlers.entry(event).or_insert_with(Vec::new).push(handler);
            Ok(())
        })
    }
    
    fn run_event_handler(&self, event: String, args: impl IntoLuaMulti + Clone) {
        if let Some(handlers) = self.event_handlers.lock().unwrap().get(&event) {
            for handler in handlers {
                handler.call::<()>(args.clone()).unwrap();
            }
        }
    }

    fn construct_globals(&self, engine: &Lua) -> LuaResult<()> {
        engine.globals().set("onEvent", self.construct_event_handler(engine)?)?;
        Ok(())
    }
}

pub struct LuauPlugin {
    engine: Arc<Mutex<Lua>>,
    event_system: LuauEventSystem,
    code: String,
}

type JsonObject = Map<String, Value>;
type Channel = i16;


#[derive(Serialize, Deserialize)]
pub struct EventDetails {
    pub source: Channel,
    pub server_event: JsonObject,
    pub target: Channel,
    pub cancelled: bool,
    pub needs_update: Option<HashSet<Channel>>, // Option to handle nullable Set<Channel>?
}

impl EventDetails {
    // Constructor equivalent
    pub fn new(
        server_event: JsonObject,
        target: Channel,
        source: Channel,
        needs_update: Option<HashSet<Channel>>,
    ) -> Self {
        Self {
            server_event,
            target,
            source,
            cancelled: false,
            needs_update,
        }
    }

    pub fn cancel(&mut self) {
        self.cancelled = true;
        self.needs_update = None;
    }
}

#[frb(opaque)]
pub struct LuauEventRunner<'a> {
    event_system: &'a LuauEventSystem, 
    engine: Arc<Mutex<Lua>>
}

impl LuauEventRunner<'_> {
    pub fn run_join(&self, name: String) {
        let args = name.into_lua_multi(&self.engine.lock().unwrap()).unwrap();
        self.event_system.run_event_handler("join".to_string(), args);
    }

    pub fn run_event(&self, event_type: String, event: String, server_event: String,target: Channel) -> EventDetails {
        let server_event : JsonObject = serde_json::from_str(&server_event).unwrap();
        let details = EventDetails::new(server_event, target, 0, None);
        let lua_value = self.engine.lock().unwrap().to_value(&details).unwrap();
        self.event_system.run_event_handler(event_type, (event, &lua_value));
        let details : EventDetails = self.engine.lock().unwrap().from_value(lua_value).unwrap();
        details
    }
}

impl LuauPlugin {
    #[frb(sync)]
    pub fn new(code: String, callback: PluginCallback) -> LuauPlugin {
        let engine = Lua::new();
        engine.sandbox(true).unwrap();
        callback.construct_globals(&engine).unwrap();
        let event_system = LuauEventSystem::default();
        event_system.construct_globals(&engine).unwrap();
        let engine = Arc::new(Mutex::new(engine));
        Self { engine, code, event_system }
    }

    #[frb(sync)]
    pub fn event_system<'a>(&'a self) -> LuauEventRunner<'a> {
        LuauEventRunner {
            event_system: &self.event_system,
            engine: Arc::clone(&self.engine)
        }
    }


    pub fn run(&self) -> anyhow::Result<()> {
        Ok(self.engine.lock().unwrap().load(&self.code).exec().unwrap())
    }
}
