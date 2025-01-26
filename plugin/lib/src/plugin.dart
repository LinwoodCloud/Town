import 'dart:async';

import 'package:networker/networker.dart';
import 'package:setonix_api/event.dart';
import 'package:setonix_plugin/src/events/system.dart';

typedef PluginProcessCallback = void Function(String, WorldEvent, [bool force]);
typedef PluginSendEventCallback = void Function(
    String, NetworkerPacket<PlayableWorldEvent>);

final class PluginSystem {
  final Map<String, SetonixPlugin> _plugins = {};
  final PluginProcessCallback _onProcess;
  final PluginSendEventCallback _onSendEvent;

  PluginSystem(
      {required PluginProcessCallback onProcess,
      required PluginSendEventCallback onSendEvent})
      : _onProcess = onProcess,
        _onSendEvent = onSendEvent;

  SetonixPlugin registerPlugin(String name) {
    final plugin = SetonixPlugin._();
    _register(name, plugin);
    return plugin;
  }

  void _register(String name, SetonixPlugin plugin) {
    _plugins[name] = plugin;
    plugin.onProcess
        .listen((message) => _onProcess(name, message.event, message.force));
    plugin.onSendEvent.listen((event) => _onSendEvent(name, event));
  }

  void unregisterPlugin(String name) {
    _plugins.remove(name)?.dispose();
  }

  void dispose() {
    _plugins.values.forEach((plugin) => plugin.dispose());
    _plugins.clear();
  }
}

final class ProcessMessage {
  final WorldEvent event;
  final bool force;

  ProcessMessage(this.event, this.force);
}

final class SetonixPlugin {
  final EventSystem eventSystem = EventSystem();
  final StreamController<ProcessMessage> _onProcessController =
      StreamController.broadcast();
  final StreamController<NetworkerPacket<PlayableWorldEvent>>
      _onSendEventController = StreamController.broadcast();

  SetonixPlugin._();

  Stream<ProcessMessage> get onProcess => _onProcessController.stream;
  Stream<NetworkerPacket<PlayableWorldEvent>> get onSendEvent =>
      _onSendEventController.stream;

  void process(WorldEvent event, {bool force = false}) =>
      _onProcessController.add(ProcessMessage(event, force));

  void sendEvent(PlayableWorldEvent event, [Channel target = kAnyChannel]) =>
      _onSendEventController.add(NetworkerPacket(event, target));

  void dispose() {
    eventSystem.dispose();
    _onProcessController.close();
    _onSendEventController.close();
  }
}
