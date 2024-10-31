import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';
import 'package:setonix_api/event.dart';

import 'dart:typed_data';

part 'event.mapper.dart';

part 'server.dart';
part 'client.dart';
part 'hybrid.dart';
part 'local.dart';

const kDefaultPort = 28006;
const kBroadcastPort = 28007;

@MappableClass(discriminatorKey: 'type')
sealed class WorldEvent with WorldEventMappable {
  WorldEvent();
}

/// Events that can be processed by the event management system
/// This can be a ServerWorldEvent or a LocalWorldEvent
@MappableClass(discriminatorKey: 'type')
sealed class PlayableWorldEvent extends WorldEvent
    with PlayableWorldEventMappable {}
