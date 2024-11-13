part of 'event.dart';

/// Events that will be send by the client
/// Naming convention: present tense + Event
@MappableClass(discriminatorKey: 'type')
sealed class ServerWorldEvent extends PlayableWorldEvent
    with ServerWorldEventMappable {}

@MappableClass()
final class WorldInitialized extends ServerWorldEvent
    with WorldInitializedMappable {
  final GameTable? table;
  final GameInfo? info;
  final Map<String, Set<Channel>>? teamMembers;
  final Channel? id;
  final Map<String, SignatureMetadata>? packsSignature;

  WorldInitialized({
    this.table,
    this.info,
    this.teamMembers,
    this.id,
    this.packsSignature,
  });
}

@MappableClass()
final class TeamJoined extends ServerWorldEvent with TeamJoinedMappable {
  final Channel user;
  final String team;

  TeamJoined(this.user, this.team);
}

@MappableClass()
final class TeamLeft extends ServerWorldEvent with TeamLeftMappable {
  final Channel user;
  final String team;

  TeamLeft(this.user, this.team);
}

@MappableClass()
final class ObjectsChanged extends ServerWorldEvent
    with ObjectsChangedMappable {
  final GlobalVectorDefinition cell;
  final List<GameObject> objects;

  ObjectsChanged(this.cell, [this.objects = const []]);

  ObjectsChanged addObjects(List<GameObject> objects) =>
      copyWith.objects.addAll(objects);

  ObjectsChanged addObject(GameObject object) => addObjects([object]);

  ObjectsChanged object(ItemLocation asset,
          {String? variation, bool hidden = false}) =>
      addObject(GameObject(asset, variation: variation, hidden: hidden));
}

@MappableClass()
final class CellShuffled extends ServerWorldEvent with CellShuffledMappable {
  final GlobalVectorDefinition cell;
  final List<int> positions;

  CellShuffled(this.cell, [this.positions = const []]);

  CellShuffled addPositions(List<int> positions) =>
      copyWith(positions: [...this.positions, ...positions]);

  CellShuffled addPosition(int position) => addPositions([position]);

  Map<int, GameObject> getObjects(WorldState state) {
    final cellObject =
        state.getTableOrDefault(cell.table).getCell(cell.position);
    return Map.fromEntries(positions.map((e) {
      final object = cellObject.objects.elementAtOrNull(e);
      if (object == null) return null;
      return MapEntry(e, object);
    }).nonNulls);
  }
}

@MappableClass()
final class MessageSent extends ServerWorldEvent with MessageSentMappable {
  final Channel user;
  final String message;

  MessageSent(this.user, this.message);
}

@MappableClass()
final class BoardTilesSpawned extends ServerWorldEvent
    with BoardTilesSpawnedMappable {
  final String table;
  final Map<VectorDefinition, List<BoardTile>> tiles;

  BoardTilesSpawned(this.table, [this.tiles = const {}]);
  BoardTilesSpawned.single(
      GlobalVectorDefinition position, List<BoardTile> tiles)
      : table = position.table,
        tiles = {position.position: tiles};
  BoardTilesSpawned.singleTile(GlobalVectorDefinition position, BoardTile tile)
      : table = position.table,
        tiles = {
          position.position: [tile]
        };

  BoardTilesSpawned addTiles(int x, int y, List<BoardTile> tiles) =>
      copyWith(tiles: {
        ...this.tiles,
        VectorDefinition(x, y): [
          ...?this.tiles[VectorDefinition(x, y)],
          ...tiles
        ]
      });

  BoardTilesSpawned addTile(int x, int y, BoardTile tile) =>
      addTiles(x, y, [tile]);

  BoardTilesSpawned tile(
          int x, int y, ItemLocation asset, int tileX, int tileY) =>
      addTile(x, y, BoardTile(asset, VectorDefinition(tileX, tileY)));
}

@MappableClass()
final class BoardTilesChanged extends ServerWorldEvent
    with BoardTilesChangedMappable {
  final String table;
  final Map<VectorDefinition, List<BoardTile>> tiles;

  BoardTilesChanged(this.table, [this.tiles = const {}]);
  BoardTilesChanged.single(
      GlobalVectorDefinition position, List<BoardTile> tiles)
      : table = position.table,
        tiles = {position.position: tiles};
  BoardTilesChanged.singleTile(GlobalVectorDefinition position, BoardTile tile)
      : table = position.table,
        tiles = {
          position.position: [tile]
        };

  BoardTilesChanged addTiles(int x, int y, List<BoardTile> tiles) =>
      copyWith(tiles: {
        ...this.tiles,
        VectorDefinition(x, y): [
          ...?this.tiles[VectorDefinition(x, y)],
          ...tiles
        ]
      });

  BoardTilesChanged addTile(int x, int y, BoardTile tile) =>
      addTiles(x, y, [tile]);

  BoardTilesChanged tile(
          int x, int y, ItemLocation asset, int tileX, int tileY) =>
      addTile(x, y, BoardTile(asset, VectorDefinition(tileX, tileY)));
}

@MappableClass()
final class DialogOpened extends ServerWorldEvent with DialogOpenedMappable {
  final GameDialog dialog;
  final bool closeOthers;

  DialogOpened(this.dialog, {this.closeOthers = false});
}

@MappableClass()
final class DialogsClosed extends ServerWorldEvent with DialogsClosedMappable {
  final List<String>? ids;

  DialogsClosed(this.ids);
  DialogsClosed.single(String id) : ids = [id];
  DialogsClosed.all() : ids = null;
}

class Base64IdMapHook extends SimpleMapper<Map<String, Uint8List>> {
  const Base64IdMapHook();

  @override
  Map<String, Uint8List> decode(Object value) {
    if (value is Map<String, dynamic>) {
      return value.map((key, value) {
        if (value is String) {
          return MapEntry(key, base64Decode(value));
        }
        return MapEntry(key, value as Uint8List);
      });
    }
    return {};
  }

  @override
  Object? encode(Map<String, Uint8List> self) {
    return self.map((key, value) => MapEntry(key, base64Encode(value)));
  }
}

@MappableClass(includeCustomMappers: [Base64IdMapHook()])
final class ImagesUpdated extends ServerWorldEvent with ImagesUpdatedMappable {
  final Map<String, Uint8List> images;

  ImagesUpdated(this.images);
  ImagesUpdated.single(String id, Uint8List image) : images = {id: image};
}
