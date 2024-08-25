import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';
import '../models/meta.dart';
import '../models/table.dart';
import '../models/vector.dart';

part 'event.mapper.dart';

part 'server.dart';
part 'client.dart';
part 'hybrid.dart';
part 'local.dart';

const kDefaultPort = 28006;

@MappableClass(discriminatorKey: 'type')
sealed class WorldEvent with WorldEventMappable {
  WorldEvent();
}

/// Events that can be processed by the event management system
/// This can be a ServerWorldEvent or a LocalWorldEvent
@MappableClass(discriminatorKey: 'type')
sealed class PlayableWorldEvent extends WorldEvent
    with PlayableWorldEventMappable {}