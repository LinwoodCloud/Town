import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';

part 'model.mapper.dart';

base class Event<T> {
  final T clientEvent;
  final Channel source;
  ServerWorldEvent serverEvent;
  Channel target;
  bool cancelled = false;
  Set<Channel>? needsUpdate;

  Event(this.serverEvent, this.target, this.clientEvent, this.source,
      this.needsUpdate);

  Event<C> castEvent<C extends WorldEvent>() {
    return _LinkedEvent<C>(this);
  }

  void cancel() {
    cancelled = true;
    needsUpdate = null;
  }
}

// Allows casting an event to another
final class _LinkedEvent<T extends WorldEvent?> implements Event<T> {
  final Event parent;

  _LinkedEvent(this.parent);

  @override
  bool get cancelled => parent.cancelled;
  @override
  set cancelled(bool value) => parent.cancelled = value;

  @override
  ServerWorldEvent get serverEvent => parent.serverEvent;
  @override
  set serverEvent(ServerWorldEvent value) => parent.serverEvent = value;

  @override
  Channel get target => parent.target;
  @override
  set target(Channel value) => parent.target = value;

  @override
  void cancel() => parent.cancel();

  @override
  Event<C> castEvent<C extends WorldEvent>() => parent.castEvent();

  @override
  T get clientEvent => parent.clientEvent as T;

  @override
  Channel get source => parent.source;

  @override
  Set<Channel>? get needsUpdate => parent.needsUpdate;

  @override
  set needsUpdate(Set<Channel>? value) => parent.needsUpdate = value;
}

final class ServerPing {
  final HttpRequest request;
  GameProperty response;

  ServerPing({
    required this.request,
    required this.response,
  });
}

final class UserLeaveCallback {
  final Channel channel;
  final ConnectionInfo info;

  UserLeaveCallback({
    required this.channel,
    required this.info,
  });
}

@MappableClass()
final class UserJoined extends LocalWorldEvent with UserJoinedMappable {
  final Channel channel;
  final ConnectionInfo info;

  UserJoined({required this.channel, required this.info});
}

@MappableClass()
final class ResetWorld extends LocalWorldEvent with ResetWorldMappable {
  ResetWorld();
}
