import 'package:collection/collection.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';

bool isValidServerEvent(ServerWorldEvent event, WorldState state) =>
    switch (event) {
      WorldInitialized() =>
        event.info?.packs.length == event.packsSignature?.length &&
            (event.info?.packs.every((e) =>
                    event.packsSignature?.any((p) => p.id == e) ?? false) ??
                true),
      TeamJoined() => state.info.teams.containsKey(event.team),
      TeamLeft() => state.info.teams.containsKey(event.team),
      CellShuffled() => event.positions.every((e) => e.inRange(
          0,
          state
                  .getTableOrDefault(event.cell.table)
                  .getCell(event.cell.position)
                  .objects
                  .length -
              1)),
      ObjectsMoved() => event.from != event.to &&
          event.objects.every((e) => e.inRange(
              0,
              state
                      .getTableOrDefault(event.table)
                      .getCell(event.from)
                      .objects
                      .length -
                  1)),
      CellHideChanged() => event.object?.inRange(
              0,
              state
                      .getTableOrDefault(event.cell.table)
                      .getCell(event.cell.position)
                      .objects
                      .length -
                  1) ??
          true,
      ObjectIndexChanged() => event.index.inRange(
          0,
          state
                  .getTableOrDefault(event.cell.table)
                  .getCell(event.cell.position)
                  .objects
                  .length -
              1),
      DialogOpened() => event.dialog.isValid(),
      _ => true,
    };

sealed class FatalServerEventError {}

final class InvalidPacksError extends FatalServerEventError {
  final List<SignatureMetadata> signature;

  InvalidPacksError({required this.signature});

  @override
  String toString() =>
      'Server requested packs, that are not available on the client (or is empty): $signature';
}

bool isServerSupported(List<SignatureMetadata> mySignature,
    List<SignatureMetadata> serverSignature) {
  for (final entry in serverSignature) {
    final current = mySignature.firstWhereOrNull((e) => e.id == entry.id);
    if (current == null || !current.supports(entry)) {
      return false;
    }
  }
  return true;
}

class ServerProcessed {
  final WorldState? state;
  final List<ClientWorldEvent> responses;

  ServerProcessed(this.state, [this.responses = const []]);
}

ServerProcessed processServerEvent(
  ServerWorldEvent event,
  WorldState state, {
  required Map<String, SignatureMetadata> signature,
}) {
  if (!isValidServerEvent(event, state)) return ServerProcessed(null);
  switch (event) {
    case WorldInitialized():
      final signature = event.packsSignature;
      final supported =
          signature == null ? true : isServerSupported(signature, signature);
      if (!supported) {
        throw InvalidPacksError(signature: signature);
      }
      return ServerProcessed(state.copyWith(
        table: event.table ?? state.table,
        id: event.id ?? state.id,
        teamMembers: event.teamMembers ?? state.teamMembers,
        info: event.info ?? state.info,
      ));
    case TeamJoined():
      return ServerProcessed(state.copyWith(
        teamMembers: {
          ...state.teamMembers,
          event.team: {
            ...?state.teamMembers[event.team],
            event.user,
          },
        },
      ));
    case TeamLeft():
      final members = Set<Channel>.from(state.teamMembers[event.team] ?? {});
      members.remove(event.user);
      final allMembers = Map<String, Set<int>>.from(state.teamMembers);
      if (members.isEmpty) {
        allMembers.remove(event.team);
      } else {
        allMembers[event.team] = members;
      }
      return ServerProcessed(state.copyWith(teamMembers: allMembers));
    case ObjectsChanged():
      return ServerProcessed(state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final newCell = cell.copyWith(objects: event.objects);
        if (newCell.isEmpty) {
          return table.copyWith.cellsBox(
              content: Map<VectorDefinition, TableCell>.from(table.cells)
                ..remove(event.cell.position));
        }
        return table.copyWith.cellsBox(
            content: Map<VectorDefinition, TableCell>.from(table.cells)
              ..[event.cell.position] = newCell);
      }));
    case CellShuffled(positions: final positions):
      return ServerProcessed(state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final objects = cell.objects;
        final newObjects = List<GameObject>.from(objects);
        for (var i = 0; i < positions.length; i++) {
          newObjects[positions[i]] = objects[i];
        }
        return table.copyWith.cellsBox(
            content: Map<VectorDefinition, TableCell>.from(table.cells)
              ..[event.cell.position] = cell.copyWith(objects: newObjects));
      }));
    case BackgroundChanged():
      return ServerProcessed(
          state.copyWith.table(background: event.background));
    case ObjectsSpawned():
      return ServerProcessed(state.mapTableOrDefault(event.table, (table) {
        var newTable = table;
        for (final entry in event.objects.entries) {
          final cell = newTable.cells[entry.key] ?? TableCell();
          newTable = newTable.copyWith.cellsBox(
              content: Map<VectorDefinition, TableCell>.from(newTable.cells)
                ..[entry.key] = cell.copyWith(objects: entry.value));
        }
        return newTable;
      }));
    case ObjectsMoved():
      return ServerProcessed(state.mapTableOrDefault(event.table, (table) {
        var from = table.cells[event.from] ?? TableCell();
        var to = table.cells[event.to] ?? TableCell();
        final toRemove = List<int>.from(event.objects)
          ..sort((a, b) => b.compareTo(a));
        final toAdd = toRemove.map((e) => from.objects[e]).toList();
        final newObjects = List<GameObject>.from(from.objects);
        for (final i in toRemove) {
          newObjects.removeAt(i);
        }
        from = from.copyWith(objects: newObjects);
        to = to.copyWith(objects: [
          ...to.objects,
          ...toAdd,
        ]);
        final cells = Map<VectorDefinition, TableCell>.from(table.cells)
          ..[event.to] = to;
        if (from.isEmpty) {
          cells.remove(event.from);
        } else {
          cells[event.from] = from;
        }

        return table.copyWith.cellsBox(content: cells);
      }));
    case CellHideChanged():
      return ServerProcessed(state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final objectIndex = event.object;
        if (objectIndex != null) {
          final object = cell.objects[objectIndex];
          return table.copyWith.cellsBox(
              content: Map<VectorDefinition, TableCell>.from(table.cells)
                ..[event.cell.position] = cell.copyWith.objects.replace(
                    objectIndex,
                    object.copyWith(hidden: event.hide ?? !object.hidden)));
        }
        final hidden =
            !(event.hide ?? cell.objects.firstOrNull?.hidden ?? false);
        return table.copyWith.cellsBox(
            content: Map<VectorDefinition, TableCell>.from(table.cells)
              ..[event.cell.position] = cell.copyWith(
                  objects: cell.objects
                      .map((e) => e.copyWith(hidden: hidden))
                      .toList()));
      }));
    case ObjectsRemoved():
      return ServerProcessed(state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final objectIndex = event.objects;
        var newCell = cell;
        if (objectIndex != null) {
          final objects = List<GameObject>.from(cell.objects);
          final indexes = objectIndex.toList()..sort((a, b) => b.compareTo(a));
          for (final index in indexes) {
            objects.removeAt(index);
          }
          newCell = cell.copyWith();
        } else {
          newCell = cell.copyWith(objects: []);
        }
        if (newCell.isEmpty) {
          return table.copyWith.cellsBox(
              content: Map<VectorDefinition, TableCell>.from(table.cells)
                ..remove(event.cell.position));
        }
        return table.copyWith.cellsBox(
            content: Map<VectorDefinition, TableCell>.from(table.cells)
              ..[event.cell.position] = newCell);
      }));
    case ObjectIndexChanged():
      return ServerProcessed(state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final object = cell.objects[event.object];
        final newObjects = List<GameObject>.from(cell.objects);
        newObjects.removeAt(event.object);
        newObjects.insert(event.index, object);
        return table.copyWith.cellsBox(
            content: Map<VectorDefinition, TableCell>.from(table.cells)
              ..[event.cell.position] = cell.copyWith(objects: newObjects));
      }));
    case TeamChanged():
      return ServerProcessed(
          state.copyWith.info.teams.put(event.name, event.team));
    case TeamRemoved():
      return ServerProcessed(state.copyWith(
        info: state.info.copyWith.teams.remove(event.team),
        teamMembers: Map.from(state.teamMembers)..remove(event.team),
      ));
    case MetadataChanged():
      return ServerProcessed(state.copyWith(metadata: event.metadata));
    case MessageSent():
      return ServerProcessed(state.copyWith.messages.add(ChatMessage(
        author: event.user,
        content: event.message,
        timestamp: DateTime.now(),
      )));
    case TableRenamed():
      final data = state.data.getTable(event.name);
      return ServerProcessed(state.copyWith(
          tableName:
              event.name == state.tableName ? event.newName : state.tableName,
          data: data == null
              ? state.data
              : state.data
                  .removeTable(event.name)
                  .setTable(data, event.newName)));
    case TableRemoved():
      return ServerProcessed(state.copyWith(
          tableName: state.tableName == event.name ? '' : state.tableName,
          data: state.data.removeTable(event.name)));
    case NoteChanged():
      return ServerProcessed(
          state.copyWith(data: state.data.setNote(event.name, event.content)));
    case NoteRemoved():
      return ServerProcessed(
          state.copyWith(data: state.data.removeNote(event.name)));
    case BoardTilesSpawned():
      return ServerProcessed(state.mapTableOrDefault(event.table, (table) {
        final cells = Map<VectorDefinition, TableCell>.from(table.cells);
        for (final entry in event.tiles.entries) {
          cells[entry.key] =
              table.getCell(entry.key).copyWith.tiles.addAll(entry.value);
        }
        return table.copyWith.cellsBox(content: cells);
      }));
    case BoardTilesChanged():
      return ServerProcessed(state.mapTableOrDefault(event.table, (table) {
        final cells = Map<VectorDefinition, TableCell>.from(table.cells);
        for (final entry in event.tiles.entries) {
          final newCell = table.getCell(entry.key).copyWith(tiles: entry.value);
          if (newCell.isEmpty) {
            cells.remove(entry.key);
          } else {
            cells[entry.key] = newCell;
          }
        }
        return table.copyWith.cellsBox(content: cells);
      }));
    case DialogOpened():
      final index = state.dialogs.indexWhere((e) => e.id == event.dialog.id);
      final image = event.dialog.image;
      final responses = <ClientWorldEvent>[];
      if (image != null && !state.images.containsKey(image)) {
        responses.add(ImagesRequest([image]));
      }
      if (index != -1) {
        return ServerProcessed(
            state.copyWith.dialogs.replace(index, event.dialog), responses);
      }
      return ServerProcessed(
          state.copyWith.dialogs.add(event.dialog), responses);
    case DialogsClosed():
      return ServerProcessed(state.copyWith.dialogs
          .where((e) => !(event.ids?.contains(e.id) ?? true)));
    case ImagesUpdated():
      return ServerProcessed(state.copyWith(
        images: {
          ...state.images,
          ...event.images,
        },
      ));
  }
}
