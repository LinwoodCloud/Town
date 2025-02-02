use std::{collections::HashSet, future::Future, pin::Pin, sync::Arc};

use flutter_rust_bridge::{frb, DartFnFuture};
use serde::{Deserialize, Serialize};
use serde_json::{Map, Value};

pub struct PluginCallback {
    pub(crate) on_print: Arc<dyn Fn(String) -> Pin<Box<dyn Future<Output = ()> + Send>> + Send + Sync>,
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

pub type Channel = i16;
pub type JsonObject = Map<String, Value>;

pub trait SetonixPlugin {
    fn run_event(&self, event_type: String, event: String, server_event: String,target: Channel) -> EventResult;
}

#[derive(Serialize, Deserialize)]
#[frb(opaque)]
pub(crate) struct EventDetails {
    pub(crate) source: Channel,
    pub(crate) server_event: JsonObject,
    pub(crate) target: Channel,
    pub(crate) cancelled: bool,
    pub(crate) needs_update: Option<HashSet<Channel>>, // Option to handle nullable Set<Channel>?
}

impl EventDetails {
    // Constructor equivalent
    pub(crate) fn new(
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
}

#[derive(Serialize, Deserialize)]
pub struct EventResult {
    pub target: Channel,
    pub server_event: Option<String>,
    pub needs_update: Option<HashSet<Channel>>,
}

impl From<EventDetails> for EventResult {
    #[frb(ignore)]
    fn from(details: EventDetails) -> Self {
        Self {
            target: details.target,
            server_event: details.cancelled.then(|| serde_json::to_string(&details.server_event).unwrap()),
            needs_update: details.needs_update,
        }
    }
}
