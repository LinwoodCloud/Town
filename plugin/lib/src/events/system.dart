import 'dart:async';
import 'dart:io';

import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/src/events/model.dart';

final class EventSystem {
  final StreamController<Event> _controller =
      StreamController.broadcast(sync: true);
  final StreamController<ServerPing> _pingController =
      StreamController.broadcast(sync: true);
  final StreamController<UserLeaveCallback> _leaveController =
      StreamController.broadcast(sync: true);

  Stream<Event<T>> event<T extends WorldEvent>() {
    if (T == dynamic) {
      return _controller.stream as Stream<Event<T>>;
    }
    return _controller.stream
        .where((event) => event.clientEvent is T)
        .map((event) => event.castEvent<T>());
  }

  void on<T extends WorldEvent>(void Function(Event<T>) callback) =>
      event<T>().listen(callback);

  Stream<ServerPing> get ping => _pingController.stream;
  Stream<UserLeaveCallback> get leave => _leaveController.stream;

  void fire(Event event) {
    _controller.add(event);
  }

  GameProperty runPing(HttpRequest request, GameProperty property) {
    final ping = ServerPing(request: request, response: property);
    _pingController.add(ping);
    return ping.response;
  }

  void runLeaveCallback(Channel channel, ConnectionInfo info) {
    final callback = UserLeaveCallback(channel: channel, info: info);
    _leaveController.add(callback);
  }

  void dispose() {
    _controller.close();
    _pingController.close();
    _leaveController.close();
  }
}
