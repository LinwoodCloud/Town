use std::{
    collections::HashMap,
    sync::{Arc, Mutex},
};

use flutter_rust_bridge::frb;
use futures::executor::block_on;
use mlua::prelude::*;

use super::plugin::*;

impl PluginCallback {
    fn construct_on_print(&self, engine: &Lua) -> LuaResult<LuaFunction> {
        let on_print = self.on_print.clone();
        engine.create_function(move |_, s: String| {
            block_on(on_print(s));
            Ok(())
        })
    }

    fn construct_globals(&self, engine: &Lua) -> LuaResult<()> {
        engine
            .globals()
            .set("print", self.construct_on_print(engine)?)?;
        Ok(())
    }
}

#[derive(Default)]
pub struct LuauEventSystem {
    event_handlers: Arc<Mutex<HashMap<String, Vec<LuaFunction>>>>,
}

impl LuauEventSystem {
    fn run_event_handler(&self, event: String, args: impl IntoLuaMulti + Clone) {
        if let Some(handlers) = self.event_handlers.lock().unwrap().get(&event) {
            for handler in handlers {
                handler.call::<()>(args.clone()).unwrap();
            }
        }
    }
}

struct LuauEventSystemUserData(Arc<Mutex<LuauEventSystem>>);

impl LuaUserData for LuauEventSystemUserData {
    fn add_methods<M: mlua::UserDataMethods<Self>>(methods: &mut M) {
        // Change to add a meta-method for __index
        methods.add_meta_method(LuaMetaMethod::Index, |lua, this, key: String| {
            let key_clone = key.clone();
            let event_system = Arc::clone(&this.0);
            // Create a function that will be returned to Lua.
            // This function now expects a tuple (self, handler) so that it works with colon syntax.
            let f = lua.create_function(
                move |_, (_, handler): (LuaAnyUserData, LuaFunction)| {
                    // Here, self_arg is the event userdata that we ignore.
                    // Lock the event system and register the handler under the event key.
                    let binding = event_system.lock().unwrap();
                    let mut event_handlers =
                        binding.event_handlers.lock().unwrap();
                    event_handlers
                        .entry(key_clone.clone())
                        .or_insert_with(Vec::new)
                        .push(handler);
                    Ok(())
                },
            )?;
            // Return the function to Lua so that event:schoo(handler) works.
            Ok(f)
        });
    }
}

pub struct LuauPlugin {
    engine: Arc<Mutex<Lua>>,
    code: String,
    event_system: Arc<Mutex<LuauEventSystem>>,
}

impl SetonixPlugin for LuauPlugin {
    fn run_event(
        &self,
        event_type: String,
        event: String,
        server_event: String,
        target: Channel,
    ) -> EventResult {
        let server_event: JsonObject = serde_json::from_str(&server_event).unwrap();
        let details = EventDetails::new(server_event, target, 0, None);
        let lua_value = self.engine.lock().unwrap().to_value(&details).unwrap();
        self.event_system
            .lock()
            .unwrap()
            .run_event_handler(event_type, (event, &lua_value));
        let details: EventDetails = self.engine.lock().unwrap().from_value(lua_value).unwrap();
        EventResult::from(details)
    }
}

impl LuauPlugin {
    #[frb(sync)]
    pub fn new(code: String, callback: PluginCallback) -> LuauPlugin {
        let engine = Lua::new();
        engine.sandbox(true).unwrap();
        callback.construct_globals(&engine).unwrap();
        let event_system = LuauEventSystem::default();
        let event_system = Arc::new(Mutex::new(event_system));
        engine
            .globals()
            .set("event", LuauEventSystemUserData(Arc::clone(&event_system)))
            .unwrap();

        let engine = Arc::new(Mutex::new(engine));
        Self {
            engine,
            code,
            event_system,
        }
    }

    pub fn run(&self) -> anyhow::Result<()> {
        let engine = self.engine.lock().unwrap();
        engine.load(&self.code).exec()?;
        Ok(())
    }
}
