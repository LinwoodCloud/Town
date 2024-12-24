import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';

import '../models/chat.dart';
import '../models/data.dart';
import '../models/dialog.dart';
import '../models/info.dart';
import '../models/meta.dart';
import '../models/table.dart';
import '../models/vector.dart';

part 'state.mapper.dart';

@MappableEnum()
enum WorldOperationMode {
  figures,
  boards,
}

@MappableClass()
final class WorldState with WorldStateMappable {
  final GameTable table;
  final String tableName;
  final GameInfo info;
  final String? name;
  final Channel id;
  final Map<String, Set<Channel>> teamMembers;
  final FileMetadata metadata;
  final SetonixData data;
  final List<ChatMessage> messages;
  final List<GameDialog> dialogs;
  final Map<String, Uint8List> images;

  const WorldState({
    this.name,
    this.table = const GameTable(),
    this.tableName = '',
    this.info = const GameInfo(),
    this.metadata = const FileMetadata(),
    this.teamMembers = const {},
    this.messages = const [],
    this.id = kAuthorityChannel,
    this.dialogs = const [],
    this.images = const {},
    required this.data,
  });

  GlobalVectorDefinition toGlobal(VectorDefinition position) =>
      GlobalVectorDefinition.fromLocal(tableName, position);

  bool isCellVisible(GlobalVectorDefinition cell, [Channel? id]) {
    bool isClaimed = false, isMyTeam = false;
    for (final entry in info.teams.entries) {
      final name = entry.key;
      final team = entry.value;
      if (team.claimedCells.contains(cell)) {
        isClaimed = true;
        if (teamMembers[name]?.contains(id ?? this.id) ?? false) {
          isMyTeam = true;
          break;
        }
      }
    }
    return !isClaimed || isMyTeam;
  }

  Set<String> getTeams([Channel? id]) => teamMembers.entries
      .where((entry) => entry.value.contains(id ?? this.id))
      .map((entry) => entry.key)
      .toSet();

  TableCell protectCell(VectorDefinition cell, [Channel? id]) {
    final cellObject = table.getCell(cell);
    if (cellObject.isEmpty) return cellObject;
    final cellVisible = isCellVisible(toGlobal(cell), id);
    final objects = cellObject.objects
        .map((e) => e.copyWith(
              variation: cellVisible && !e.hidden ? e.variation : null,
            ))
        .toList();
    return cellObject.copyWith(objects: objects);
  }

  GameTable protectTable([Channel? id]) {
    final protectedCells =
        table.cells.map((key, value) => MapEntry(key, protectCell(key, id)));
    return table.copyWith.cellsBox(content: protectedCells);
  }

  SetonixData save() =>
      data.setTable(table, tableName).setInfo(info).setMetadata(metadata);

  GameTable? getTable(String name) =>
      name == tableName ? table : data.getTable(name);
  GameTable getTableOrDefault(String name) =>
      name == tableName ? table : data.getTableOrDefault(name);

  WorldState updateTable(String name, GameTable table) {
    if (name == tableName) return copyWith(table: table);
    return copyWith(
      data: data.setTable(table, name),
    );
  }

  WorldState mapTable(String name, GameTable Function(GameTable?) mapper) =>
      updateTable(name, mapper(getTable(name)));

  WorldState mapTableOrDefault(
          String name, GameTable Function(GameTable) mapper) =>
      updateTable(name, mapper(getTableOrDefault(name)));
}
