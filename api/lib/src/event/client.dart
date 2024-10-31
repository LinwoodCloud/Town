part of 'event.dart';

/// Events that will be send by the client
/// Naming convention: present tense + Request
@MappableClass()
sealed class ClientWorldEvent extends WorldEvent
    with ClientWorldEventMappable {}

@MappableClass()
final class TeamJoinRequest extends ClientWorldEvent
    with TeamJoinRequestMappable {
  final String team;

  TeamJoinRequest(this.team);
}

@MappableClass()
final class TeamLeaveRequest extends ClientWorldEvent
    with TeamLeaveRequestMappable {
  final String team;

  TeamLeaveRequest(this.team);
}

@MappableClass()
final class CellRollRequest extends ClientWorldEvent
    with CellRollRequestMappable {
  final GlobalVectorDefinition cell;
  final int? object;

  CellRollRequest(this.cell, {this.object});

  GameObject? getObject(WorldState state) {
    if (object == null) return null;
    final table = state.getTableOrDefault(cell.table);
    final cellObjects = table.getCell(cell.position);
    return cellObjects.objects.elementAtOrNull(object!);
  }
}

@MappableClass()
final class ShuffleCellRequest extends ClientWorldEvent
    with ShuffleCellRequestMappable {
  final GlobalVectorDefinition cell;

  ShuffleCellRequest(this.cell);
}

@MappableClass()
final class PacksChangeRequest extends ClientWorldEvent
    with PacksChangeRequestMappable {
  final List<String> packs;

  PacksChangeRequest(this.packs);
}

@MappableClass()
final class MessageRequest extends ClientWorldEvent
    with MessageRequestMappable {
  final String message;

  MessageRequest(this.message);
}

@MappableClass()
final class BoardsSpawnRequest extends ClientWorldEvent
    with BoardsSpawnRequestMappable {
  final String table;
  final Map<VectorDefinition, List<ItemLocation>> assets;

  BoardsSpawnRequest(this.table, [this.assets = const {}]);
  BoardsSpawnRequest.single(GlobalVectorDefinition cell, ItemLocation asset)
      : table = cell.table,
        assets = {
          cell.position: [asset]
        };
  BoardsSpawnRequest.fromLocal(
      this.table, VectorDefinition cell, ItemLocation asset)
      : assets = {
          cell: [asset]
        };

  BoardsSpawnRequest boards(VectorDefinition cell, List<ItemLocation> assets) =>
      copyWith(
        assets: {
          ...this.assets,
          cell: [...this.assets[cell] ?? [], ...assets],
        },
      );

  BoardsSpawnRequest board(VectorDefinition cell, ItemLocation asset) =>
      boards(cell, [asset]);

  bool inBounds(VectorDefinition start, VectorDefinition end) {
    for (final entry in assets.entries) {
      if (!entry.key.inBounds(start, end)) return false;
    }
    return true;
  }
}

@MappableClass()
final class BoardRemoveRequest extends ClientWorldEvent
    with BoardRemoveRequestMappable {
  final GlobalVectorDefinition position;
  final int index;

  BoardRemoveRequest(this.position, this.index);

  BoardTile? getTile(WorldState state) {
    final table = state.getTableOrDefault(position.table);
    final cell = table.getCell(position.position);
    return cell.tiles.elementAtOrNull(index);
  }
}

@MappableClass()
final class BoardMoveRequest extends ClientWorldEvent
    with BoardMoveRequestMappable {
  final String table;
  final VectorDefinition from;
  final VectorDefinition to;
  final int index;

  BoardMoveRequest(this.table, this.from, this.to, this.index);

  BoardTile? getTile(WorldState state) {
    final table = state.getTableOrDefault(this.table);
    final cell = table.getCell(from);
    return cell.tiles.elementAtOrNull(index);
  }

  VectorDefinition delta() => to - from;
}

@MappableClass()
final class DialogCloseRequest extends ClientWorldEvent
    with DialogCloseRequestMappable {
  final String id;
  final GameDialogValue? value;

  DialogCloseRequest(this.id, this.value);
}

@MappableClass()
final class ImagesRequest extends ClientWorldEvent with ImagesRequestMappable {
  final List<String> ids;

  ImagesRequest(this.ids);
}
