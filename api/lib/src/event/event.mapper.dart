// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event.dart';

class WorldEventMapper extends ClassMapperBase<WorldEvent> {
  WorldEventMapper._();

  static WorldEventMapper? _instance;
  static WorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldEventMapper._());
      PlayableWorldEventMapper.ensureInitialized();
      ClientWorldEventMapper.ensureInitialized();
      HybridWorldEventMapper.ensureInitialized();
      LocalWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorldEvent';

  @override
  final MappableFields<WorldEvent> fields = const {};

  static WorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'WorldEvent', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static WorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorldEvent>(map);
  }

  static WorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<WorldEvent>(json);
  }
}

mixin WorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  WorldEventCopyWith<WorldEvent, WorldEvent, WorldEvent> get copyWith;
}

abstract class WorldEventCopyWith<$R, $In extends WorldEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  WorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class PlayableWorldEventMapper extends SubClassMapperBase<PlayableWorldEvent> {
  PlayableWorldEventMapper._();

  static PlayableWorldEventMapper? _instance;
  static PlayableWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayableWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      ServerWorldEventMapper.ensureInitialized();
      LocalWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PlayableWorldEvent';

  @override
  final MappableFields<PlayableWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PlayableWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static PlayableWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'PlayableWorldEvent', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static PlayableWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlayableWorldEvent>(map);
  }

  static PlayableWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<PlayableWorldEvent>(json);
  }
}

mixin PlayableWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PlayableWorldEventCopyWith<PlayableWorldEvent, PlayableWorldEvent,
      PlayableWorldEvent> get copyWith;
}

abstract class PlayableWorldEventCopyWith<$R, $In extends PlayableWorldEvent,
    $Out> implements WorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  PlayableWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class ServerWorldEventMapper extends SubClassMapperBase<ServerWorldEvent> {
  ServerWorldEventMapper._();

  static ServerWorldEventMapper? _instance;
  static ServerWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerWorldEventMapper._());
      PlayableWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      WorldInitializedMapper.ensureInitialized();
      TeamJoinedMapper.ensureInitialized();
      TeamLeftMapper.ensureInitialized();
      ObjectsChangedMapper.ensureInitialized();
      CellShuffledMapper.ensureInitialized();
      MessageSentMapper.ensureInitialized();
      BoardTilesSpawnedMapper.ensureInitialized();
      BoardTilesChangedMapper.ensureInitialized();
      DialogOpenedMapper.ensureInitialized();
      DialogsClosedMapper.ensureInitialized();
      HybridWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerWorldEvent';

  @override
  final MappableFields<ServerWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ServerWorldEvent';
  @override
  late final ClassMapperBase superMapper =
      PlayableWorldEventMapper.ensureInitialized();

  static ServerWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'ServerWorldEvent', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static ServerWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerWorldEvent>(map);
  }

  static ServerWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<ServerWorldEvent>(json);
  }
}

mixin ServerWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ServerWorldEventCopyWith<ServerWorldEvent, ServerWorldEvent, ServerWorldEvent>
      get copyWith;
}

abstract class ServerWorldEventCopyWith<$R, $In extends ServerWorldEvent, $Out>
    implements PlayableWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ServerWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class WorldInitializedMapper extends SubClassMapperBase<WorldInitialized> {
  WorldInitializedMapper._();

  static WorldInitializedMapper? _instance;
  static WorldInitializedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldInitializedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameTableMapper.ensureInitialized();
      GameInfoMapper.ensureInitialized();
      FileMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorldInitialized';

  static GameTable? _$table(WorldInitialized v) => v.table;
  static const Field<WorldInitialized, GameTable> _f$table =
      Field('table', _$table, opt: true);
  static GameInfo? _$info(WorldInitialized v) => v.info;
  static const Field<WorldInitialized, GameInfo> _f$info =
      Field('info', _$info, opt: true);
  static Map<String, Set<int>>? _$teamMembers(WorldInitialized v) =>
      v.teamMembers;
  static const Field<WorldInitialized, Map<String, Set<int>>> _f$teamMembers =
      Field('teamMembers', _$teamMembers, opt: true);
  static int? _$id(WorldInitialized v) => v.id;
  static const Field<WorldInitialized, int> _f$id =
      Field('id', _$id, opt: true);
  static Map<String, FileMetadata>? _$packsSignature(WorldInitialized v) =>
      v.packsSignature;
  static const Field<WorldInitialized, Map<String, FileMetadata>>
      _f$packsSignature = Field('packsSignature', _$packsSignature, opt: true);

  @override
  final MappableFields<WorldInitialized> fields = const {
    #table: _f$table,
    #info: _f$info,
    #teamMembers: _f$teamMembers,
    #id: _f$id,
    #packsSignature: _f$packsSignature,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'WorldInitialized';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static WorldInitialized _instantiate(DecodingData data) {
    return WorldInitialized(
        table: data.dec(_f$table),
        info: data.dec(_f$info),
        teamMembers: data.dec(_f$teamMembers),
        id: data.dec(_f$id),
        packsSignature: data.dec(_f$packsSignature));
  }

  @override
  final Function instantiate = _instantiate;

  static WorldInitialized fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorldInitialized>(map);
  }

  static WorldInitialized fromJson(String json) {
    return ensureInitialized().decodeJson<WorldInitialized>(json);
  }
}

mixin WorldInitializedMappable {
  String toJson() {
    return WorldInitializedMapper.ensureInitialized()
        .encodeJson<WorldInitialized>(this as WorldInitialized);
  }

  Map<String, dynamic> toMap() {
    return WorldInitializedMapper.ensureInitialized()
        .encodeMap<WorldInitialized>(this as WorldInitialized);
  }

  WorldInitializedCopyWith<WorldInitialized, WorldInitialized, WorldInitialized>
      get copyWith => _WorldInitializedCopyWithImpl(
          this as WorldInitialized, $identity, $identity);
  @override
  String toString() {
    return WorldInitializedMapper.ensureInitialized()
        .stringifyValue(this as WorldInitialized);
  }

  @override
  bool operator ==(Object other) {
    return WorldInitializedMapper.ensureInitialized()
        .equalsValue(this as WorldInitialized, other);
  }

  @override
  int get hashCode {
    return WorldInitializedMapper.ensureInitialized()
        .hashValue(this as WorldInitialized);
  }
}

extension WorldInitializedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorldInitialized, $Out> {
  WorldInitializedCopyWith<$R, WorldInitialized, $Out>
      get $asWorldInitialized =>
          $base.as((v, t, t2) => _WorldInitializedCopyWithImpl(v, t, t2));
}

abstract class WorldInitializedCopyWith<$R, $In extends WorldInitialized, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GameTableCopyWith<$R, GameTable, GameTable>? get table;
  GameInfoCopyWith<$R, GameInfo, GameInfo>? get info;
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>?
      get teamMembers;
  MapCopyWith<$R, String, FileMetadata,
      FileMetadataCopyWith<$R, FileMetadata, FileMetadata>>? get packsSignature;
  @override
  $R call(
      {GameTable? table,
      GameInfo? info,
      Map<String, Set<int>>? teamMembers,
      int? id,
      Map<String, FileMetadata>? packsSignature});
  WorldInitializedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WorldInitializedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorldInitialized, $Out>
    implements WorldInitializedCopyWith<$R, WorldInitialized, $Out> {
  _WorldInitializedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorldInitialized> $mapper =
      WorldInitializedMapper.ensureInitialized();
  @override
  GameTableCopyWith<$R, GameTable, GameTable>? get table =>
      $value.table?.copyWith.$chain((v) => call(table: v));
  @override
  GameInfoCopyWith<$R, GameInfo, GameInfo>? get info =>
      $value.info?.copyWith.$chain((v) => call(info: v));
  @override
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>?
      get teamMembers => $value.teamMembers != null
          ? MapCopyWith(
              $value.teamMembers!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(teamMembers: v))
          : null;
  @override
  MapCopyWith<$R, String, FileMetadata,
          FileMetadataCopyWith<$R, FileMetadata, FileMetadata>>?
      get packsSignature => $value.packsSignature != null
          ? MapCopyWith($value.packsSignature!, (v, t) => v.copyWith.$chain(t),
              (v) => call(packsSignature: v))
          : null;
  @override
  $R call(
          {Object? table = $none,
          Object? info = $none,
          Object? teamMembers = $none,
          Object? id = $none,
          Object? packsSignature = $none}) =>
      $apply(FieldCopyWithData({
        if (table != $none) #table: table,
        if (info != $none) #info: info,
        if (teamMembers != $none) #teamMembers: teamMembers,
        if (id != $none) #id: id,
        if (packsSignature != $none) #packsSignature: packsSignature
      }));
  @override
  WorldInitialized $make(CopyWithData data) => WorldInitialized(
      table: data.get(#table, or: $value.table),
      info: data.get(#info, or: $value.info),
      teamMembers: data.get(#teamMembers, or: $value.teamMembers),
      id: data.get(#id, or: $value.id),
      packsSignature: data.get(#packsSignature, or: $value.packsSignature));

  @override
  WorldInitializedCopyWith<$R2, WorldInitialized, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WorldInitializedCopyWithImpl($value, $cast, t);
}

class TeamJoinedMapper extends SubClassMapperBase<TeamJoined> {
  TeamJoinedMapper._();

  static TeamJoinedMapper? _instance;
  static TeamJoinedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamJoinedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamJoined';

  static int _$user(TeamJoined v) => v.user;
  static const Field<TeamJoined, int> _f$user = Field('user', _$user);
  static String _$team(TeamJoined v) => v.team;
  static const Field<TeamJoined, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamJoined> fields = const {
    #user: _f$user,
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamJoined';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static TeamJoined _instantiate(DecodingData data) {
    return TeamJoined(data.dec(_f$user), data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamJoined fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamJoined>(map);
  }

  static TeamJoined fromJson(String json) {
    return ensureInitialized().decodeJson<TeamJoined>(json);
  }
}

mixin TeamJoinedMappable {
  String toJson() {
    return TeamJoinedMapper.ensureInitialized()
        .encodeJson<TeamJoined>(this as TeamJoined);
  }

  Map<String, dynamic> toMap() {
    return TeamJoinedMapper.ensureInitialized()
        .encodeMap<TeamJoined>(this as TeamJoined);
  }

  TeamJoinedCopyWith<TeamJoined, TeamJoined, TeamJoined> get copyWith =>
      _TeamJoinedCopyWithImpl(this as TeamJoined, $identity, $identity);
  @override
  String toString() {
    return TeamJoinedMapper.ensureInitialized()
        .stringifyValue(this as TeamJoined);
  }

  @override
  bool operator ==(Object other) {
    return TeamJoinedMapper.ensureInitialized()
        .equalsValue(this as TeamJoined, other);
  }

  @override
  int get hashCode {
    return TeamJoinedMapper.ensureInitialized().hashValue(this as TeamJoined);
  }
}

extension TeamJoinedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamJoined, $Out> {
  TeamJoinedCopyWith<$R, TeamJoined, $Out> get $asTeamJoined =>
      $base.as((v, t, t2) => _TeamJoinedCopyWithImpl(v, t, t2));
}

abstract class TeamJoinedCopyWith<$R, $In extends TeamJoined, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({int? user, String? team});
  TeamJoinedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TeamJoinedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamJoined, $Out>
    implements TeamJoinedCopyWith<$R, TeamJoined, $Out> {
  _TeamJoinedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamJoined> $mapper =
      TeamJoinedMapper.ensureInitialized();
  @override
  $R call({int? user, String? team}) => $apply(FieldCopyWithData(
      {if (user != null) #user: user, if (team != null) #team: team}));
  @override
  TeamJoined $make(CopyWithData data) => TeamJoined(
      data.get(#user, or: $value.user), data.get(#team, or: $value.team));

  @override
  TeamJoinedCopyWith<$R2, TeamJoined, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeamJoinedCopyWithImpl($value, $cast, t);
}

class TeamLeftMapper extends SubClassMapperBase<TeamLeft> {
  TeamLeftMapper._();

  static TeamLeftMapper? _instance;
  static TeamLeftMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamLeftMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamLeft';

  static int _$user(TeamLeft v) => v.user;
  static const Field<TeamLeft, int> _f$user = Field('user', _$user);
  static String _$team(TeamLeft v) => v.team;
  static const Field<TeamLeft, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamLeft> fields = const {
    #user: _f$user,
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamLeft';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static TeamLeft _instantiate(DecodingData data) {
    return TeamLeft(data.dec(_f$user), data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamLeft fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamLeft>(map);
  }

  static TeamLeft fromJson(String json) {
    return ensureInitialized().decodeJson<TeamLeft>(json);
  }
}

mixin TeamLeftMappable {
  String toJson() {
    return TeamLeftMapper.ensureInitialized()
        .encodeJson<TeamLeft>(this as TeamLeft);
  }

  Map<String, dynamic> toMap() {
    return TeamLeftMapper.ensureInitialized()
        .encodeMap<TeamLeft>(this as TeamLeft);
  }

  TeamLeftCopyWith<TeamLeft, TeamLeft, TeamLeft> get copyWith =>
      _TeamLeftCopyWithImpl(this as TeamLeft, $identity, $identity);
  @override
  String toString() {
    return TeamLeftMapper.ensureInitialized().stringifyValue(this as TeamLeft);
  }

  @override
  bool operator ==(Object other) {
    return TeamLeftMapper.ensureInitialized()
        .equalsValue(this as TeamLeft, other);
  }

  @override
  int get hashCode {
    return TeamLeftMapper.ensureInitialized().hashValue(this as TeamLeft);
  }
}

extension TeamLeftValueCopy<$R, $Out> on ObjectCopyWith<$R, TeamLeft, $Out> {
  TeamLeftCopyWith<$R, TeamLeft, $Out> get $asTeamLeft =>
      $base.as((v, t, t2) => _TeamLeftCopyWithImpl(v, t, t2));
}

abstract class TeamLeftCopyWith<$R, $In extends TeamLeft, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({int? user, String? team});
  TeamLeftCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TeamLeftCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamLeft, $Out>
    implements TeamLeftCopyWith<$R, TeamLeft, $Out> {
  _TeamLeftCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamLeft> $mapper =
      TeamLeftMapper.ensureInitialized();
  @override
  $R call({int? user, String? team}) => $apply(FieldCopyWithData(
      {if (user != null) #user: user, if (team != null) #team: team}));
  @override
  TeamLeft $make(CopyWithData data) => TeamLeft(
      data.get(#user, or: $value.user), data.get(#team, or: $value.team));

  @override
  TeamLeftCopyWith<$R2, TeamLeft, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeamLeftCopyWithImpl($value, $cast, t);
}

class ObjectsChangedMapper extends SubClassMapperBase<ObjectsChanged> {
  ObjectsChangedMapper._();

  static ObjectsChangedMapper? _instance;
  static ObjectsChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsChangedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
      GameObjectMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsChanged';

  static GlobalVectorDefinition _$cell(ObjectsChanged v) => v.cell;
  static const Field<ObjectsChanged, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static List<GameObject> _$objects(ObjectsChanged v) => v.objects;
  static const Field<ObjectsChanged, List<GameObject>> _f$objects =
      Field('objects', _$objects, opt: true, def: const []);

  @override
  final MappableFields<ObjectsChanged> fields = const {
    #cell: _f$cell,
    #objects: _f$objects,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsChanged';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static ObjectsChanged _instantiate(DecodingData data) {
    return ObjectsChanged(data.dec(_f$cell), data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsChanged>(map);
  }

  static ObjectsChanged fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsChanged>(json);
  }
}

mixin ObjectsChangedMappable {
  String toJson() {
    return ObjectsChangedMapper.ensureInitialized()
        .encodeJson<ObjectsChanged>(this as ObjectsChanged);
  }

  Map<String, dynamic> toMap() {
    return ObjectsChangedMapper.ensureInitialized()
        .encodeMap<ObjectsChanged>(this as ObjectsChanged);
  }

  ObjectsChangedCopyWith<ObjectsChanged, ObjectsChanged, ObjectsChanged>
      get copyWith => _ObjectsChangedCopyWithImpl(
          this as ObjectsChanged, $identity, $identity);
  @override
  String toString() {
    return ObjectsChangedMapper.ensureInitialized()
        .stringifyValue(this as ObjectsChanged);
  }

  @override
  bool operator ==(Object other) {
    return ObjectsChangedMapper.ensureInitialized()
        .equalsValue(this as ObjectsChanged, other);
  }

  @override
  int get hashCode {
    return ObjectsChangedMapper.ensureInitialized()
        .hashValue(this as ObjectsChanged);
  }
}

extension ObjectsChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsChanged, $Out> {
  ObjectsChangedCopyWith<$R, ObjectsChanged, $Out> get $asObjectsChanged =>
      $base.as((v, t, t2) => _ObjectsChangedCopyWithImpl(v, t, t2));
}

abstract class ObjectsChangedCopyWith<$R, $In extends ObjectsChanged, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get cell;
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects;
  @override
  $R call({GlobalVectorDefinition? cell, List<GameObject>? objects});
  ObjectsChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectsChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsChanged, $Out>
    implements ObjectsChangedCopyWith<$R, ObjectsChanged, $Out> {
  _ObjectsChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsChanged> $mapper =
      ObjectsChangedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects => ListCopyWith($value.objects,
          (v, t) => v.copyWith.$chain(t), (v) => call(objects: v));
  @override
  $R call({GlobalVectorDefinition? cell, List<GameObject>? objects}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (objects != null) #objects: objects
      }));
  @override
  ObjectsChanged $make(CopyWithData data) => ObjectsChanged(
      data.get(#cell, or: $value.cell), data.get(#objects, or: $value.objects));

  @override
  ObjectsChangedCopyWith<$R2, ObjectsChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectsChangedCopyWithImpl($value, $cast, t);
}

class CellShuffledMapper extends SubClassMapperBase<CellShuffled> {
  CellShuffledMapper._();

  static CellShuffledMapper? _instance;
  static CellShuffledMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellShuffledMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellShuffled';

  static GlobalVectorDefinition _$cell(CellShuffled v) => v.cell;
  static const Field<CellShuffled, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static List<int> _$positions(CellShuffled v) => v.positions;
  static const Field<CellShuffled, List<int>> _f$positions =
      Field('positions', _$positions, opt: true, def: const []);

  @override
  final MappableFields<CellShuffled> fields = const {
    #cell: _f$cell,
    #positions: _f$positions,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellShuffled';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static CellShuffled _instantiate(DecodingData data) {
    return CellShuffled(data.dec(_f$cell), data.dec(_f$positions));
  }

  @override
  final Function instantiate = _instantiate;

  static CellShuffled fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellShuffled>(map);
  }

  static CellShuffled fromJson(String json) {
    return ensureInitialized().decodeJson<CellShuffled>(json);
  }
}

mixin CellShuffledMappable {
  String toJson() {
    return CellShuffledMapper.ensureInitialized()
        .encodeJson<CellShuffled>(this as CellShuffled);
  }

  Map<String, dynamic> toMap() {
    return CellShuffledMapper.ensureInitialized()
        .encodeMap<CellShuffled>(this as CellShuffled);
  }

  CellShuffledCopyWith<CellShuffled, CellShuffled, CellShuffled> get copyWith =>
      _CellShuffledCopyWithImpl(this as CellShuffled, $identity, $identity);
  @override
  String toString() {
    return CellShuffledMapper.ensureInitialized()
        .stringifyValue(this as CellShuffled);
  }

  @override
  bool operator ==(Object other) {
    return CellShuffledMapper.ensureInitialized()
        .equalsValue(this as CellShuffled, other);
  }

  @override
  int get hashCode {
    return CellShuffledMapper.ensureInitialized()
        .hashValue(this as CellShuffled);
  }
}

extension CellShuffledValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellShuffled, $Out> {
  CellShuffledCopyWith<$R, CellShuffled, $Out> get $asCellShuffled =>
      $base.as((v, t, t2) => _CellShuffledCopyWithImpl(v, t, t2));
}

abstract class CellShuffledCopyWith<$R, $In extends CellShuffled, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get cell;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get positions;
  @override
  $R call({GlobalVectorDefinition? cell, List<int>? positions});
  CellShuffledCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CellShuffledCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellShuffled, $Out>
    implements CellShuffledCopyWith<$R, CellShuffled, $Out> {
  _CellShuffledCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellShuffled> $mapper =
      CellShuffledMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get positions =>
      ListCopyWith($value.positions, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(positions: v));
  @override
  $R call({GlobalVectorDefinition? cell, List<int>? positions}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (positions != null) #positions: positions
      }));
  @override
  CellShuffled $make(CopyWithData data) => CellShuffled(
      data.get(#cell, or: $value.cell),
      data.get(#positions, or: $value.positions));

  @override
  CellShuffledCopyWith<$R2, CellShuffled, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CellShuffledCopyWithImpl($value, $cast, t);
}

class MessageSentMapper extends SubClassMapperBase<MessageSent> {
  MessageSentMapper._();

  static MessageSentMapper? _instance;
  static MessageSentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageSentMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'MessageSent';

  static int _$user(MessageSent v) => v.user;
  static const Field<MessageSent, int> _f$user = Field('user', _$user);
  static String _$message(MessageSent v) => v.message;
  static const Field<MessageSent, String> _f$message =
      Field('message', _$message);

  @override
  final MappableFields<MessageSent> fields = const {
    #user: _f$user,
    #message: _f$message,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'MessageSent';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static MessageSent _instantiate(DecodingData data) {
    return MessageSent(data.dec(_f$user), data.dec(_f$message));
  }

  @override
  final Function instantiate = _instantiate;

  static MessageSent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MessageSent>(map);
  }

  static MessageSent fromJson(String json) {
    return ensureInitialized().decodeJson<MessageSent>(json);
  }
}

mixin MessageSentMappable {
  String toJson() {
    return MessageSentMapper.ensureInitialized()
        .encodeJson<MessageSent>(this as MessageSent);
  }

  Map<String, dynamic> toMap() {
    return MessageSentMapper.ensureInitialized()
        .encodeMap<MessageSent>(this as MessageSent);
  }

  MessageSentCopyWith<MessageSent, MessageSent, MessageSent> get copyWith =>
      _MessageSentCopyWithImpl(this as MessageSent, $identity, $identity);
  @override
  String toString() {
    return MessageSentMapper.ensureInitialized()
        .stringifyValue(this as MessageSent);
  }

  @override
  bool operator ==(Object other) {
    return MessageSentMapper.ensureInitialized()
        .equalsValue(this as MessageSent, other);
  }

  @override
  int get hashCode {
    return MessageSentMapper.ensureInitialized().hashValue(this as MessageSent);
  }
}

extension MessageSentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MessageSent, $Out> {
  MessageSentCopyWith<$R, MessageSent, $Out> get $asMessageSent =>
      $base.as((v, t, t2) => _MessageSentCopyWithImpl(v, t, t2));
}

abstract class MessageSentCopyWith<$R, $In extends MessageSent, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({int? user, String? message});
  MessageSentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MessageSentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MessageSent, $Out>
    implements MessageSentCopyWith<$R, MessageSent, $Out> {
  _MessageSentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MessageSent> $mapper =
      MessageSentMapper.ensureInitialized();
  @override
  $R call({int? user, String? message}) => $apply(FieldCopyWithData(
      {if (user != null) #user: user, if (message != null) #message: message}));
  @override
  MessageSent $make(CopyWithData data) => MessageSent(
      data.get(#user, or: $value.user), data.get(#message, or: $value.message));

  @override
  MessageSentCopyWith<$R2, MessageSent, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MessageSentCopyWithImpl($value, $cast, t);
}

class BoardTilesSpawnedMapper extends SubClassMapperBase<BoardTilesSpawned> {
  BoardTilesSpawnedMapper._();

  static BoardTilesSpawnedMapper? _instance;
  static BoardTilesSpawnedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardTilesSpawnedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      BoardTileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardTilesSpawned';

  static String _$table(BoardTilesSpawned v) => v.table;
  static const Field<BoardTilesSpawned, String> _f$table =
      Field('table', _$table);
  static Map<VectorDefinition, List<BoardTile>> _$tiles(BoardTilesSpawned v) =>
      v.tiles;
  static const Field<BoardTilesSpawned, Map<VectorDefinition, List<BoardTile>>>
      _f$tiles = Field('tiles', _$tiles, opt: true, def: const {});

  @override
  final MappableFields<BoardTilesSpawned> fields = const {
    #table: _f$table,
    #tiles: _f$tiles,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardTilesSpawned';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static BoardTilesSpawned _instantiate(DecodingData data) {
    return BoardTilesSpawned(data.dec(_f$table), data.dec(_f$tiles));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardTilesSpawned fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardTilesSpawned>(map);
  }

  static BoardTilesSpawned fromJson(String json) {
    return ensureInitialized().decodeJson<BoardTilesSpawned>(json);
  }
}

mixin BoardTilesSpawnedMappable {
  String toJson() {
    return BoardTilesSpawnedMapper.ensureInitialized()
        .encodeJson<BoardTilesSpawned>(this as BoardTilesSpawned);
  }

  Map<String, dynamic> toMap() {
    return BoardTilesSpawnedMapper.ensureInitialized()
        .encodeMap<BoardTilesSpawned>(this as BoardTilesSpawned);
  }

  BoardTilesSpawnedCopyWith<BoardTilesSpawned, BoardTilesSpawned,
          BoardTilesSpawned>
      get copyWith => _BoardTilesSpawnedCopyWithImpl(
          this as BoardTilesSpawned, $identity, $identity);
  @override
  String toString() {
    return BoardTilesSpawnedMapper.ensureInitialized()
        .stringifyValue(this as BoardTilesSpawned);
  }

  @override
  bool operator ==(Object other) {
    return BoardTilesSpawnedMapper.ensureInitialized()
        .equalsValue(this as BoardTilesSpawned, other);
  }

  @override
  int get hashCode {
    return BoardTilesSpawnedMapper.ensureInitialized()
        .hashValue(this as BoardTilesSpawned);
  }
}

extension BoardTilesSpawnedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardTilesSpawned, $Out> {
  BoardTilesSpawnedCopyWith<$R, BoardTilesSpawned, $Out>
      get $asBoardTilesSpawned =>
          $base.as((v, t, t2) => _BoardTilesSpawnedCopyWithImpl(v, t, t2));
}

abstract class BoardTilesSpawnedCopyWith<$R, $In extends BoardTilesSpawned,
    $Out> implements ServerWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, VectorDefinition, List<BoardTile>,
      ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>> get tiles;
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles});
  BoardTilesSpawnedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardTilesSpawnedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardTilesSpawned, $Out>
    implements BoardTilesSpawnedCopyWith<$R, BoardTilesSpawned, $Out> {
  _BoardTilesSpawnedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardTilesSpawned> $mapper =
      BoardTilesSpawnedMapper.ensureInitialized();
  @override
  MapCopyWith<$R, VectorDefinition, List<BoardTile>,
          ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>>
      get tiles => MapCopyWith($value.tiles,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(tiles: v));
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles}) =>
      $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (tiles != null) #tiles: tiles
      }));
  @override
  BoardTilesSpawned $make(CopyWithData data) => BoardTilesSpawned(
      data.get(#table, or: $value.table), data.get(#tiles, or: $value.tiles));

  @override
  BoardTilesSpawnedCopyWith<$R2, BoardTilesSpawned, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoardTilesSpawnedCopyWithImpl($value, $cast, t);
}

class BoardTilesChangedMapper extends SubClassMapperBase<BoardTilesChanged> {
  BoardTilesChangedMapper._();

  static BoardTilesChangedMapper? _instance;
  static BoardTilesChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardTilesChangedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      BoardTileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardTilesChanged';

  static String _$table(BoardTilesChanged v) => v.table;
  static const Field<BoardTilesChanged, String> _f$table =
      Field('table', _$table);
  static Map<VectorDefinition, List<BoardTile>> _$tiles(BoardTilesChanged v) =>
      v.tiles;
  static const Field<BoardTilesChanged, Map<VectorDefinition, List<BoardTile>>>
      _f$tiles = Field('tiles', _$tiles, opt: true, def: const {});

  @override
  final MappableFields<BoardTilesChanged> fields = const {
    #table: _f$table,
    #tiles: _f$tiles,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardTilesChanged';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static BoardTilesChanged _instantiate(DecodingData data) {
    return BoardTilesChanged(data.dec(_f$table), data.dec(_f$tiles));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardTilesChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardTilesChanged>(map);
  }

  static BoardTilesChanged fromJson(String json) {
    return ensureInitialized().decodeJson<BoardTilesChanged>(json);
  }
}

mixin BoardTilesChangedMappable {
  String toJson() {
    return BoardTilesChangedMapper.ensureInitialized()
        .encodeJson<BoardTilesChanged>(this as BoardTilesChanged);
  }

  Map<String, dynamic> toMap() {
    return BoardTilesChangedMapper.ensureInitialized()
        .encodeMap<BoardTilesChanged>(this as BoardTilesChanged);
  }

  BoardTilesChangedCopyWith<BoardTilesChanged, BoardTilesChanged,
          BoardTilesChanged>
      get copyWith => _BoardTilesChangedCopyWithImpl(
          this as BoardTilesChanged, $identity, $identity);
  @override
  String toString() {
    return BoardTilesChangedMapper.ensureInitialized()
        .stringifyValue(this as BoardTilesChanged);
  }

  @override
  bool operator ==(Object other) {
    return BoardTilesChangedMapper.ensureInitialized()
        .equalsValue(this as BoardTilesChanged, other);
  }

  @override
  int get hashCode {
    return BoardTilesChangedMapper.ensureInitialized()
        .hashValue(this as BoardTilesChanged);
  }
}

extension BoardTilesChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardTilesChanged, $Out> {
  BoardTilesChangedCopyWith<$R, BoardTilesChanged, $Out>
      get $asBoardTilesChanged =>
          $base.as((v, t, t2) => _BoardTilesChangedCopyWithImpl(v, t, t2));
}

abstract class BoardTilesChangedCopyWith<$R, $In extends BoardTilesChanged,
    $Out> implements ServerWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, VectorDefinition, List<BoardTile>,
      ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>> get tiles;
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles});
  BoardTilesChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardTilesChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardTilesChanged, $Out>
    implements BoardTilesChangedCopyWith<$R, BoardTilesChanged, $Out> {
  _BoardTilesChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardTilesChanged> $mapper =
      BoardTilesChangedMapper.ensureInitialized();
  @override
  MapCopyWith<$R, VectorDefinition, List<BoardTile>,
          ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>>
      get tiles => MapCopyWith($value.tiles,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(tiles: v));
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles}) =>
      $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (tiles != null) #tiles: tiles
      }));
  @override
  BoardTilesChanged $make(CopyWithData data) => BoardTilesChanged(
      data.get(#table, or: $value.table), data.get(#tiles, or: $value.tiles));

  @override
  BoardTilesChangedCopyWith<$R2, BoardTilesChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoardTilesChangedCopyWithImpl($value, $cast, t);
}

class DialogOpenedMapper extends SubClassMapperBase<DialogOpened> {
  DialogOpenedMapper._();

  static DialogOpenedMapper? _instance;
  static DialogOpenedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DialogOpenedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameDialogMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DialogOpened';

  static GameDialog _$dialog(DialogOpened v) => v.dialog;
  static const Field<DialogOpened, GameDialog> _f$dialog =
      Field('dialog', _$dialog);
  static bool _$closeOthers(DialogOpened v) => v.closeOthers;
  static const Field<DialogOpened, bool> _f$closeOthers =
      Field('closeOthers', _$closeOthers, opt: true, def: false);

  @override
  final MappableFields<DialogOpened> fields = const {
    #dialog: _f$dialog,
    #closeOthers: _f$closeOthers,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DialogOpened';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static DialogOpened _instantiate(DecodingData data) {
    return DialogOpened(data.dec(_f$dialog),
        closeOthers: data.dec(_f$closeOthers));
  }

  @override
  final Function instantiate = _instantiate;

  static DialogOpened fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DialogOpened>(map);
  }

  static DialogOpened fromJson(String json) {
    return ensureInitialized().decodeJson<DialogOpened>(json);
  }
}

mixin DialogOpenedMappable {
  String toJson() {
    return DialogOpenedMapper.ensureInitialized()
        .encodeJson<DialogOpened>(this as DialogOpened);
  }

  Map<String, dynamic> toMap() {
    return DialogOpenedMapper.ensureInitialized()
        .encodeMap<DialogOpened>(this as DialogOpened);
  }

  DialogOpenedCopyWith<DialogOpened, DialogOpened, DialogOpened> get copyWith =>
      _DialogOpenedCopyWithImpl(this as DialogOpened, $identity, $identity);
  @override
  String toString() {
    return DialogOpenedMapper.ensureInitialized()
        .stringifyValue(this as DialogOpened);
  }

  @override
  bool operator ==(Object other) {
    return DialogOpenedMapper.ensureInitialized()
        .equalsValue(this as DialogOpened, other);
  }

  @override
  int get hashCode {
    return DialogOpenedMapper.ensureInitialized()
        .hashValue(this as DialogOpened);
  }
}

extension DialogOpenedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DialogOpened, $Out> {
  DialogOpenedCopyWith<$R, DialogOpened, $Out> get $asDialogOpened =>
      $base.as((v, t, t2) => _DialogOpenedCopyWithImpl(v, t, t2));
}

abstract class DialogOpenedCopyWith<$R, $In extends DialogOpened, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GameDialogCopyWith<$R, GameDialog, GameDialog> get dialog;
  @override
  $R call({GameDialog? dialog, bool? closeOthers});
  DialogOpenedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DialogOpenedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DialogOpened, $Out>
    implements DialogOpenedCopyWith<$R, DialogOpened, $Out> {
  _DialogOpenedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DialogOpened> $mapper =
      DialogOpenedMapper.ensureInitialized();
  @override
  GameDialogCopyWith<$R, GameDialog, GameDialog> get dialog =>
      $value.dialog.copyWith.$chain((v) => call(dialog: v));
  @override
  $R call({GameDialog? dialog, bool? closeOthers}) => $apply(FieldCopyWithData({
        if (dialog != null) #dialog: dialog,
        if (closeOthers != null) #closeOthers: closeOthers
      }));
  @override
  DialogOpened $make(CopyWithData data) =>
      DialogOpened(data.get(#dialog, or: $value.dialog),
          closeOthers: data.get(#closeOthers, or: $value.closeOthers));

  @override
  DialogOpenedCopyWith<$R2, DialogOpened, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DialogOpenedCopyWithImpl($value, $cast, t);
}

class DialogsClosedMapper extends SubClassMapperBase<DialogsClosed> {
  DialogsClosedMapper._();

  static DialogsClosedMapper? _instance;
  static DialogsClosedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DialogsClosedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'DialogsClosed';

  static List<String>? _$ids(DialogsClosed v) => v.ids;
  static const Field<DialogsClosed, List<String>> _f$ids = Field('ids', _$ids);

  @override
  final MappableFields<DialogsClosed> fields = const {
    #ids: _f$ids,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DialogsClosed';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static DialogsClosed _instantiate(DecodingData data) {
    return DialogsClosed(data.dec(_f$ids));
  }

  @override
  final Function instantiate = _instantiate;

  static DialogsClosed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DialogsClosed>(map);
  }

  static DialogsClosed fromJson(String json) {
    return ensureInitialized().decodeJson<DialogsClosed>(json);
  }
}

mixin DialogsClosedMappable {
  String toJson() {
    return DialogsClosedMapper.ensureInitialized()
        .encodeJson<DialogsClosed>(this as DialogsClosed);
  }

  Map<String, dynamic> toMap() {
    return DialogsClosedMapper.ensureInitialized()
        .encodeMap<DialogsClosed>(this as DialogsClosed);
  }

  DialogsClosedCopyWith<DialogsClosed, DialogsClosed, DialogsClosed>
      get copyWith => _DialogsClosedCopyWithImpl(
          this as DialogsClosed, $identity, $identity);
  @override
  String toString() {
    return DialogsClosedMapper.ensureInitialized()
        .stringifyValue(this as DialogsClosed);
  }

  @override
  bool operator ==(Object other) {
    return DialogsClosedMapper.ensureInitialized()
        .equalsValue(this as DialogsClosed, other);
  }

  @override
  int get hashCode {
    return DialogsClosedMapper.ensureInitialized()
        .hashValue(this as DialogsClosed);
  }
}

extension DialogsClosedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DialogsClosed, $Out> {
  DialogsClosedCopyWith<$R, DialogsClosed, $Out> get $asDialogsClosed =>
      $base.as((v, t, t2) => _DialogsClosedCopyWithImpl(v, t, t2));
}

abstract class DialogsClosedCopyWith<$R, $In extends DialogsClosed, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get ids;
  @override
  $R call({List<String>? ids});
  DialogsClosedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DialogsClosedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DialogsClosed, $Out>
    implements DialogsClosedCopyWith<$R, DialogsClosed, $Out> {
  _DialogsClosedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DialogsClosed> $mapper =
      DialogsClosedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get ids =>
      $value.ids != null
          ? ListCopyWith($value.ids!, (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(ids: v))
          : null;
  @override
  $R call({Object? ids = $none}) =>
      $apply(FieldCopyWithData({if (ids != $none) #ids: ids}));
  @override
  DialogsClosed $make(CopyWithData data) =>
      DialogsClosed(data.get(#ids, or: $value.ids));

  @override
  DialogsClosedCopyWith<$R2, DialogsClosed, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DialogsClosedCopyWithImpl($value, $cast, t);
}

class ClientWorldEventMapper extends SubClassMapperBase<ClientWorldEvent> {
  ClientWorldEventMapper._();

  static ClientWorldEventMapper? _instance;
  static ClientWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      TeamJoinRequestMapper.ensureInitialized();
      TeamLeaveRequestMapper.ensureInitialized();
      CellRollRequestMapper.ensureInitialized();
      ShuffleCellRequestMapper.ensureInitialized();
      PacksChangeRequestMapper.ensureInitialized();
      MessageRequestMapper.ensureInitialized();
      BoardsSpawnRequestMapper.ensureInitialized();
      BoardRemoveRequestMapper.ensureInitialized();
      BoardMoveRequestMapper.ensureInitialized();
      DialogCloseRequestMapper.ensureInitialized();
      HybridWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClientWorldEvent';

  @override
  final MappableFields<ClientWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ClientWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static ClientWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'ClientWorldEvent', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static ClientWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClientWorldEvent>(map);
  }

  static ClientWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<ClientWorldEvent>(json);
  }
}

mixin ClientWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ClientWorldEventCopyWith<ClientWorldEvent, ClientWorldEvent, ClientWorldEvent>
      get copyWith;
}

abstract class ClientWorldEventCopyWith<$R, $In extends ClientWorldEvent, $Out>
    implements WorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ClientWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class TeamJoinRequestMapper extends SubClassMapperBase<TeamJoinRequest> {
  TeamJoinRequestMapper._();

  static TeamJoinRequestMapper? _instance;
  static TeamJoinRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamJoinRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamJoinRequest';

  static String _$team(TeamJoinRequest v) => v.team;
  static const Field<TeamJoinRequest, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamJoinRequest> fields = const {
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamJoinRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static TeamJoinRequest _instantiate(DecodingData data) {
    return TeamJoinRequest(data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamJoinRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamJoinRequest>(map);
  }

  static TeamJoinRequest fromJson(String json) {
    return ensureInitialized().decodeJson<TeamJoinRequest>(json);
  }
}

mixin TeamJoinRequestMappable {
  String toJson() {
    return TeamJoinRequestMapper.ensureInitialized()
        .encodeJson<TeamJoinRequest>(this as TeamJoinRequest);
  }

  Map<String, dynamic> toMap() {
    return TeamJoinRequestMapper.ensureInitialized()
        .encodeMap<TeamJoinRequest>(this as TeamJoinRequest);
  }

  TeamJoinRequestCopyWith<TeamJoinRequest, TeamJoinRequest, TeamJoinRequest>
      get copyWith => _TeamJoinRequestCopyWithImpl(
          this as TeamJoinRequest, $identity, $identity);
  @override
  String toString() {
    return TeamJoinRequestMapper.ensureInitialized()
        .stringifyValue(this as TeamJoinRequest);
  }

  @override
  bool operator ==(Object other) {
    return TeamJoinRequestMapper.ensureInitialized()
        .equalsValue(this as TeamJoinRequest, other);
  }

  @override
  int get hashCode {
    return TeamJoinRequestMapper.ensureInitialized()
        .hashValue(this as TeamJoinRequest);
  }
}

extension TeamJoinRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamJoinRequest, $Out> {
  TeamJoinRequestCopyWith<$R, TeamJoinRequest, $Out> get $asTeamJoinRequest =>
      $base.as((v, t, t2) => _TeamJoinRequestCopyWithImpl(v, t, t2));
}

abstract class TeamJoinRequestCopyWith<$R, $In extends TeamJoinRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? team});
  TeamJoinRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TeamJoinRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamJoinRequest, $Out>
    implements TeamJoinRequestCopyWith<$R, TeamJoinRequest, $Out> {
  _TeamJoinRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamJoinRequest> $mapper =
      TeamJoinRequestMapper.ensureInitialized();
  @override
  $R call({String? team}) =>
      $apply(FieldCopyWithData({if (team != null) #team: team}));
  @override
  TeamJoinRequest $make(CopyWithData data) =>
      TeamJoinRequest(data.get(#team, or: $value.team));

  @override
  TeamJoinRequestCopyWith<$R2, TeamJoinRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeamJoinRequestCopyWithImpl($value, $cast, t);
}

class TeamLeaveRequestMapper extends SubClassMapperBase<TeamLeaveRequest> {
  TeamLeaveRequestMapper._();

  static TeamLeaveRequestMapper? _instance;
  static TeamLeaveRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamLeaveRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamLeaveRequest';

  static String _$team(TeamLeaveRequest v) => v.team;
  static const Field<TeamLeaveRequest, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamLeaveRequest> fields = const {
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamLeaveRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static TeamLeaveRequest _instantiate(DecodingData data) {
    return TeamLeaveRequest(data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamLeaveRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamLeaveRequest>(map);
  }

  static TeamLeaveRequest fromJson(String json) {
    return ensureInitialized().decodeJson<TeamLeaveRequest>(json);
  }
}

mixin TeamLeaveRequestMappable {
  String toJson() {
    return TeamLeaveRequestMapper.ensureInitialized()
        .encodeJson<TeamLeaveRequest>(this as TeamLeaveRequest);
  }

  Map<String, dynamic> toMap() {
    return TeamLeaveRequestMapper.ensureInitialized()
        .encodeMap<TeamLeaveRequest>(this as TeamLeaveRequest);
  }

  TeamLeaveRequestCopyWith<TeamLeaveRequest, TeamLeaveRequest, TeamLeaveRequest>
      get copyWith => _TeamLeaveRequestCopyWithImpl(
          this as TeamLeaveRequest, $identity, $identity);
  @override
  String toString() {
    return TeamLeaveRequestMapper.ensureInitialized()
        .stringifyValue(this as TeamLeaveRequest);
  }

  @override
  bool operator ==(Object other) {
    return TeamLeaveRequestMapper.ensureInitialized()
        .equalsValue(this as TeamLeaveRequest, other);
  }

  @override
  int get hashCode {
    return TeamLeaveRequestMapper.ensureInitialized()
        .hashValue(this as TeamLeaveRequest);
  }
}

extension TeamLeaveRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamLeaveRequest, $Out> {
  TeamLeaveRequestCopyWith<$R, TeamLeaveRequest, $Out>
      get $asTeamLeaveRequest =>
          $base.as((v, t, t2) => _TeamLeaveRequestCopyWithImpl(v, t, t2));
}

abstract class TeamLeaveRequestCopyWith<$R, $In extends TeamLeaveRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? team});
  TeamLeaveRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TeamLeaveRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamLeaveRequest, $Out>
    implements TeamLeaveRequestCopyWith<$R, TeamLeaveRequest, $Out> {
  _TeamLeaveRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamLeaveRequest> $mapper =
      TeamLeaveRequestMapper.ensureInitialized();
  @override
  $R call({String? team}) =>
      $apply(FieldCopyWithData({if (team != null) #team: team}));
  @override
  TeamLeaveRequest $make(CopyWithData data) =>
      TeamLeaveRequest(data.get(#team, or: $value.team));

  @override
  TeamLeaveRequestCopyWith<$R2, TeamLeaveRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeamLeaveRequestCopyWithImpl($value, $cast, t);
}

class CellRollRequestMapper extends SubClassMapperBase<CellRollRequest> {
  CellRollRequestMapper._();

  static CellRollRequestMapper? _instance;
  static CellRollRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellRollRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellRollRequest';

  static GlobalVectorDefinition _$cell(CellRollRequest v) => v.cell;
  static const Field<CellRollRequest, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static int? _$object(CellRollRequest v) => v.object;
  static const Field<CellRollRequest, int> _f$object =
      Field('object', _$object, opt: true);

  @override
  final MappableFields<CellRollRequest> fields = const {
    #cell: _f$cell,
    #object: _f$object,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellRollRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static CellRollRequest _instantiate(DecodingData data) {
    return CellRollRequest(data.dec(_f$cell), object: data.dec(_f$object));
  }

  @override
  final Function instantiate = _instantiate;

  static CellRollRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellRollRequest>(map);
  }

  static CellRollRequest fromJson(String json) {
    return ensureInitialized().decodeJson<CellRollRequest>(json);
  }
}

mixin CellRollRequestMappable {
  String toJson() {
    return CellRollRequestMapper.ensureInitialized()
        .encodeJson<CellRollRequest>(this as CellRollRequest);
  }

  Map<String, dynamic> toMap() {
    return CellRollRequestMapper.ensureInitialized()
        .encodeMap<CellRollRequest>(this as CellRollRequest);
  }

  CellRollRequestCopyWith<CellRollRequest, CellRollRequest, CellRollRequest>
      get copyWith => _CellRollRequestCopyWithImpl(
          this as CellRollRequest, $identity, $identity);
  @override
  String toString() {
    return CellRollRequestMapper.ensureInitialized()
        .stringifyValue(this as CellRollRequest);
  }

  @override
  bool operator ==(Object other) {
    return CellRollRequestMapper.ensureInitialized()
        .equalsValue(this as CellRollRequest, other);
  }

  @override
  int get hashCode {
    return CellRollRequestMapper.ensureInitialized()
        .hashValue(this as CellRollRequest);
  }
}

extension CellRollRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellRollRequest, $Out> {
  CellRollRequestCopyWith<$R, CellRollRequest, $Out> get $asCellRollRequest =>
      $base.as((v, t, t2) => _CellRollRequestCopyWithImpl(v, t, t2));
}

abstract class CellRollRequestCopyWith<$R, $In extends CellRollRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get cell;
  @override
  $R call({GlobalVectorDefinition? cell, int? object});
  CellRollRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CellRollRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellRollRequest, $Out>
    implements CellRollRequestCopyWith<$R, CellRollRequest, $Out> {
  _CellRollRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellRollRequest> $mapper =
      CellRollRequestMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({GlobalVectorDefinition? cell, Object? object = $none}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (object != $none) #object: object
      }));
  @override
  CellRollRequest $make(CopyWithData data) =>
      CellRollRequest(data.get(#cell, or: $value.cell),
          object: data.get(#object, or: $value.object));

  @override
  CellRollRequestCopyWith<$R2, CellRollRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CellRollRequestCopyWithImpl($value, $cast, t);
}

class ShuffleCellRequestMapper extends SubClassMapperBase<ShuffleCellRequest> {
  ShuffleCellRequestMapper._();

  static ShuffleCellRequestMapper? _instance;
  static ShuffleCellRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShuffleCellRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ShuffleCellRequest';

  static GlobalVectorDefinition _$cell(ShuffleCellRequest v) => v.cell;
  static const Field<ShuffleCellRequest, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);

  @override
  final MappableFields<ShuffleCellRequest> fields = const {
    #cell: _f$cell,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ShuffleCellRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static ShuffleCellRequest _instantiate(DecodingData data) {
    return ShuffleCellRequest(data.dec(_f$cell));
  }

  @override
  final Function instantiate = _instantiate;

  static ShuffleCellRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShuffleCellRequest>(map);
  }

  static ShuffleCellRequest fromJson(String json) {
    return ensureInitialized().decodeJson<ShuffleCellRequest>(json);
  }
}

mixin ShuffleCellRequestMappable {
  String toJson() {
    return ShuffleCellRequestMapper.ensureInitialized()
        .encodeJson<ShuffleCellRequest>(this as ShuffleCellRequest);
  }

  Map<String, dynamic> toMap() {
    return ShuffleCellRequestMapper.ensureInitialized()
        .encodeMap<ShuffleCellRequest>(this as ShuffleCellRequest);
  }

  ShuffleCellRequestCopyWith<ShuffleCellRequest, ShuffleCellRequest,
          ShuffleCellRequest>
      get copyWith => _ShuffleCellRequestCopyWithImpl(
          this as ShuffleCellRequest, $identity, $identity);
  @override
  String toString() {
    return ShuffleCellRequestMapper.ensureInitialized()
        .stringifyValue(this as ShuffleCellRequest);
  }

  @override
  bool operator ==(Object other) {
    return ShuffleCellRequestMapper.ensureInitialized()
        .equalsValue(this as ShuffleCellRequest, other);
  }

  @override
  int get hashCode {
    return ShuffleCellRequestMapper.ensureInitialized()
        .hashValue(this as ShuffleCellRequest);
  }
}

extension ShuffleCellRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShuffleCellRequest, $Out> {
  ShuffleCellRequestCopyWith<$R, ShuffleCellRequest, $Out>
      get $asShuffleCellRequest =>
          $base.as((v, t, t2) => _ShuffleCellRequestCopyWithImpl(v, t, t2));
}

abstract class ShuffleCellRequestCopyWith<$R, $In extends ShuffleCellRequest,
    $Out> implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get cell;
  @override
  $R call({GlobalVectorDefinition? cell});
  ShuffleCellRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ShuffleCellRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShuffleCellRequest, $Out>
    implements ShuffleCellRequestCopyWith<$R, ShuffleCellRequest, $Out> {
  _ShuffleCellRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShuffleCellRequest> $mapper =
      ShuffleCellRequestMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({GlobalVectorDefinition? cell}) =>
      $apply(FieldCopyWithData({if (cell != null) #cell: cell}));
  @override
  ShuffleCellRequest $make(CopyWithData data) =>
      ShuffleCellRequest(data.get(#cell, or: $value.cell));

  @override
  ShuffleCellRequestCopyWith<$R2, ShuffleCellRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ShuffleCellRequestCopyWithImpl($value, $cast, t);
}

class PacksChangeRequestMapper extends SubClassMapperBase<PacksChangeRequest> {
  PacksChangeRequestMapper._();

  static PacksChangeRequestMapper? _instance;
  static PacksChangeRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PacksChangeRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PacksChangeRequest';

  static List<String> _$packs(PacksChangeRequest v) => v.packs;
  static const Field<PacksChangeRequest, List<String>> _f$packs =
      Field('packs', _$packs);

  @override
  final MappableFields<PacksChangeRequest> fields = const {
    #packs: _f$packs,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PacksChangeRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static PacksChangeRequest _instantiate(DecodingData data) {
    return PacksChangeRequest(data.dec(_f$packs));
  }

  @override
  final Function instantiate = _instantiate;

  static PacksChangeRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PacksChangeRequest>(map);
  }

  static PacksChangeRequest fromJson(String json) {
    return ensureInitialized().decodeJson<PacksChangeRequest>(json);
  }
}

mixin PacksChangeRequestMappable {
  String toJson() {
    return PacksChangeRequestMapper.ensureInitialized()
        .encodeJson<PacksChangeRequest>(this as PacksChangeRequest);
  }

  Map<String, dynamic> toMap() {
    return PacksChangeRequestMapper.ensureInitialized()
        .encodeMap<PacksChangeRequest>(this as PacksChangeRequest);
  }

  PacksChangeRequestCopyWith<PacksChangeRequest, PacksChangeRequest,
          PacksChangeRequest>
      get copyWith => _PacksChangeRequestCopyWithImpl(
          this as PacksChangeRequest, $identity, $identity);
  @override
  String toString() {
    return PacksChangeRequestMapper.ensureInitialized()
        .stringifyValue(this as PacksChangeRequest);
  }

  @override
  bool operator ==(Object other) {
    return PacksChangeRequestMapper.ensureInitialized()
        .equalsValue(this as PacksChangeRequest, other);
  }

  @override
  int get hashCode {
    return PacksChangeRequestMapper.ensureInitialized()
        .hashValue(this as PacksChangeRequest);
  }
}

extension PacksChangeRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PacksChangeRequest, $Out> {
  PacksChangeRequestCopyWith<$R, PacksChangeRequest, $Out>
      get $asPacksChangeRequest =>
          $base.as((v, t, t2) => _PacksChangeRequestCopyWithImpl(v, t, t2));
}

abstract class PacksChangeRequestCopyWith<$R, $In extends PacksChangeRequest,
    $Out> implements ClientWorldEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get packs;
  @override
  $R call({List<String>? packs});
  PacksChangeRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PacksChangeRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PacksChangeRequest, $Out>
    implements PacksChangeRequestCopyWith<$R, PacksChangeRequest, $Out> {
  _PacksChangeRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PacksChangeRequest> $mapper =
      PacksChangeRequestMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get packs =>
      ListCopyWith($value.packs, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(packs: v));
  @override
  $R call({List<String>? packs}) =>
      $apply(FieldCopyWithData({if (packs != null) #packs: packs}));
  @override
  PacksChangeRequest $make(CopyWithData data) =>
      PacksChangeRequest(data.get(#packs, or: $value.packs));

  @override
  PacksChangeRequestCopyWith<$R2, PacksChangeRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PacksChangeRequestCopyWithImpl($value, $cast, t);
}

class MessageRequestMapper extends SubClassMapperBase<MessageRequest> {
  MessageRequestMapper._();

  static MessageRequestMapper? _instance;
  static MessageRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'MessageRequest';

  static String _$message(MessageRequest v) => v.message;
  static const Field<MessageRequest, String> _f$message =
      Field('message', _$message);

  @override
  final MappableFields<MessageRequest> fields = const {
    #message: _f$message,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'MessageRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static MessageRequest _instantiate(DecodingData data) {
    return MessageRequest(data.dec(_f$message));
  }

  @override
  final Function instantiate = _instantiate;

  static MessageRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MessageRequest>(map);
  }

  static MessageRequest fromJson(String json) {
    return ensureInitialized().decodeJson<MessageRequest>(json);
  }
}

mixin MessageRequestMappable {
  String toJson() {
    return MessageRequestMapper.ensureInitialized()
        .encodeJson<MessageRequest>(this as MessageRequest);
  }

  Map<String, dynamic> toMap() {
    return MessageRequestMapper.ensureInitialized()
        .encodeMap<MessageRequest>(this as MessageRequest);
  }

  MessageRequestCopyWith<MessageRequest, MessageRequest, MessageRequest>
      get copyWith => _MessageRequestCopyWithImpl(
          this as MessageRequest, $identity, $identity);
  @override
  String toString() {
    return MessageRequestMapper.ensureInitialized()
        .stringifyValue(this as MessageRequest);
  }

  @override
  bool operator ==(Object other) {
    return MessageRequestMapper.ensureInitialized()
        .equalsValue(this as MessageRequest, other);
  }

  @override
  int get hashCode {
    return MessageRequestMapper.ensureInitialized()
        .hashValue(this as MessageRequest);
  }
}

extension MessageRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MessageRequest, $Out> {
  MessageRequestCopyWith<$R, MessageRequest, $Out> get $asMessageRequest =>
      $base.as((v, t, t2) => _MessageRequestCopyWithImpl(v, t, t2));
}

abstract class MessageRequestCopyWith<$R, $In extends MessageRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? message});
  MessageRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MessageRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MessageRequest, $Out>
    implements MessageRequestCopyWith<$R, MessageRequest, $Out> {
  _MessageRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MessageRequest> $mapper =
      MessageRequestMapper.ensureInitialized();
  @override
  $R call({String? message}) =>
      $apply(FieldCopyWithData({if (message != null) #message: message}));
  @override
  MessageRequest $make(CopyWithData data) =>
      MessageRequest(data.get(#message, or: $value.message));

  @override
  MessageRequestCopyWith<$R2, MessageRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MessageRequestCopyWithImpl($value, $cast, t);
}

class BoardsSpawnRequestMapper extends SubClassMapperBase<BoardsSpawnRequest> {
  BoardsSpawnRequestMapper._();

  static BoardsSpawnRequestMapper? _instance;
  static BoardsSpawnRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardsSpawnRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardsSpawnRequest';

  static String _$table(BoardsSpawnRequest v) => v.table;
  static const Field<BoardsSpawnRequest, String> _f$table =
      Field('table', _$table);
  static Map<VectorDefinition, List<ItemLocation>> _$assets(
          BoardsSpawnRequest v) =>
      v.assets;
  static const Field<BoardsSpawnRequest,
          Map<VectorDefinition, List<ItemLocation>>> _f$assets =
      Field('assets', _$assets, opt: true, def: const {});

  @override
  final MappableFields<BoardsSpawnRequest> fields = const {
    #table: _f$table,
    #assets: _f$assets,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardsSpawnRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static BoardsSpawnRequest _instantiate(DecodingData data) {
    return BoardsSpawnRequest(data.dec(_f$table), data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardsSpawnRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardsSpawnRequest>(map);
  }

  static BoardsSpawnRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BoardsSpawnRequest>(json);
  }
}

mixin BoardsSpawnRequestMappable {
  String toJson() {
    return BoardsSpawnRequestMapper.ensureInitialized()
        .encodeJson<BoardsSpawnRequest>(this as BoardsSpawnRequest);
  }

  Map<String, dynamic> toMap() {
    return BoardsSpawnRequestMapper.ensureInitialized()
        .encodeMap<BoardsSpawnRequest>(this as BoardsSpawnRequest);
  }

  BoardsSpawnRequestCopyWith<BoardsSpawnRequest, BoardsSpawnRequest,
          BoardsSpawnRequest>
      get copyWith => _BoardsSpawnRequestCopyWithImpl(
          this as BoardsSpawnRequest, $identity, $identity);
  @override
  String toString() {
    return BoardsSpawnRequestMapper.ensureInitialized()
        .stringifyValue(this as BoardsSpawnRequest);
  }

  @override
  bool operator ==(Object other) {
    return BoardsSpawnRequestMapper.ensureInitialized()
        .equalsValue(this as BoardsSpawnRequest, other);
  }

  @override
  int get hashCode {
    return BoardsSpawnRequestMapper.ensureInitialized()
        .hashValue(this as BoardsSpawnRequest);
  }
}

extension BoardsSpawnRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardsSpawnRequest, $Out> {
  BoardsSpawnRequestCopyWith<$R, BoardsSpawnRequest, $Out>
      get $asBoardsSpawnRequest =>
          $base.as((v, t, t2) => _BoardsSpawnRequestCopyWithImpl(v, t, t2));
}

abstract class BoardsSpawnRequestCopyWith<$R, $In extends BoardsSpawnRequest,
    $Out> implements ClientWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, VectorDefinition, List<ItemLocation>,
      ObjectCopyWith<$R, List<ItemLocation>, List<ItemLocation>>> get assets;
  @override
  $R call({String? table, Map<VectorDefinition, List<ItemLocation>>? assets});
  BoardsSpawnRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardsSpawnRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardsSpawnRequest, $Out>
    implements BoardsSpawnRequestCopyWith<$R, BoardsSpawnRequest, $Out> {
  _BoardsSpawnRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardsSpawnRequest> $mapper =
      BoardsSpawnRequestMapper.ensureInitialized();
  @override
  MapCopyWith<$R, VectorDefinition, List<ItemLocation>,
          ObjectCopyWith<$R, List<ItemLocation>, List<ItemLocation>>>
      get assets => MapCopyWith($value.assets,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(assets: v));
  @override
  $R call({String? table, Map<VectorDefinition, List<ItemLocation>>? assets}) =>
      $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (assets != null) #assets: assets
      }));
  @override
  BoardsSpawnRequest $make(CopyWithData data) => BoardsSpawnRequest(
      data.get(#table, or: $value.table), data.get(#assets, or: $value.assets));

  @override
  BoardsSpawnRequestCopyWith<$R2, BoardsSpawnRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoardsSpawnRequestCopyWithImpl($value, $cast, t);
}

class BoardRemoveRequestMapper extends SubClassMapperBase<BoardRemoveRequest> {
  BoardRemoveRequestMapper._();

  static BoardRemoveRequestMapper? _instance;
  static BoardRemoveRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardRemoveRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardRemoveRequest';

  static GlobalVectorDefinition _$position(BoardRemoveRequest v) => v.position;
  static const Field<BoardRemoveRequest, GlobalVectorDefinition> _f$position =
      Field('position', _$position);
  static int _$index(BoardRemoveRequest v) => v.index;
  static const Field<BoardRemoveRequest, int> _f$index =
      Field('index', _$index);

  @override
  final MappableFields<BoardRemoveRequest> fields = const {
    #position: _f$position,
    #index: _f$index,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardRemoveRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static BoardRemoveRequest _instantiate(DecodingData data) {
    return BoardRemoveRequest(data.dec(_f$position), data.dec(_f$index));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardRemoveRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardRemoveRequest>(map);
  }

  static BoardRemoveRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BoardRemoveRequest>(json);
  }
}

mixin BoardRemoveRequestMappable {
  String toJson() {
    return BoardRemoveRequestMapper.ensureInitialized()
        .encodeJson<BoardRemoveRequest>(this as BoardRemoveRequest);
  }

  Map<String, dynamic> toMap() {
    return BoardRemoveRequestMapper.ensureInitialized()
        .encodeMap<BoardRemoveRequest>(this as BoardRemoveRequest);
  }

  BoardRemoveRequestCopyWith<BoardRemoveRequest, BoardRemoveRequest,
          BoardRemoveRequest>
      get copyWith => _BoardRemoveRequestCopyWithImpl(
          this as BoardRemoveRequest, $identity, $identity);
  @override
  String toString() {
    return BoardRemoveRequestMapper.ensureInitialized()
        .stringifyValue(this as BoardRemoveRequest);
  }

  @override
  bool operator ==(Object other) {
    return BoardRemoveRequestMapper.ensureInitialized()
        .equalsValue(this as BoardRemoveRequest, other);
  }

  @override
  int get hashCode {
    return BoardRemoveRequestMapper.ensureInitialized()
        .hashValue(this as BoardRemoveRequest);
  }
}

extension BoardRemoveRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardRemoveRequest, $Out> {
  BoardRemoveRequestCopyWith<$R, BoardRemoveRequest, $Out>
      get $asBoardRemoveRequest =>
          $base.as((v, t, t2) => _BoardRemoveRequestCopyWithImpl(v, t, t2));
}

abstract class BoardRemoveRequestCopyWith<$R, $In extends BoardRemoveRequest,
    $Out> implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get position;
  @override
  $R call({GlobalVectorDefinition? position, int? index});
  BoardRemoveRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardRemoveRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardRemoveRequest, $Out>
    implements BoardRemoveRequestCopyWith<$R, BoardRemoveRequest, $Out> {
  _BoardRemoveRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardRemoveRequest> $mapper =
      BoardRemoveRequestMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get position => $value.position.copyWith.$chain((v) => call(position: v));
  @override
  $R call({GlobalVectorDefinition? position, int? index}) =>
      $apply(FieldCopyWithData({
        if (position != null) #position: position,
        if (index != null) #index: index
      }));
  @override
  BoardRemoveRequest $make(CopyWithData data) => BoardRemoveRequest(
      data.get(#position, or: $value.position),
      data.get(#index, or: $value.index));

  @override
  BoardRemoveRequestCopyWith<$R2, BoardRemoveRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoardRemoveRequestCopyWithImpl($value, $cast, t);
}

class BoardMoveRequestMapper extends SubClassMapperBase<BoardMoveRequest> {
  BoardMoveRequestMapper._();

  static BoardMoveRequestMapper? _instance;
  static BoardMoveRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardMoveRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardMoveRequest';

  static String _$table(BoardMoveRequest v) => v.table;
  static const Field<BoardMoveRequest, String> _f$table =
      Field('table', _$table);
  static VectorDefinition _$from(BoardMoveRequest v) => v.from;
  static const Field<BoardMoveRequest, VectorDefinition> _f$from =
      Field('from', _$from);
  static VectorDefinition _$to(BoardMoveRequest v) => v.to;
  static const Field<BoardMoveRequest, VectorDefinition> _f$to =
      Field('to', _$to);
  static int _$index(BoardMoveRequest v) => v.index;
  static const Field<BoardMoveRequest, int> _f$index = Field('index', _$index);

  @override
  final MappableFields<BoardMoveRequest> fields = const {
    #table: _f$table,
    #from: _f$from,
    #to: _f$to,
    #index: _f$index,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardMoveRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static BoardMoveRequest _instantiate(DecodingData data) {
    return BoardMoveRequest(data.dec(_f$table), data.dec(_f$from),
        data.dec(_f$to), data.dec(_f$index));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardMoveRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardMoveRequest>(map);
  }

  static BoardMoveRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BoardMoveRequest>(json);
  }
}

mixin BoardMoveRequestMappable {
  String toJson() {
    return BoardMoveRequestMapper.ensureInitialized()
        .encodeJson<BoardMoveRequest>(this as BoardMoveRequest);
  }

  Map<String, dynamic> toMap() {
    return BoardMoveRequestMapper.ensureInitialized()
        .encodeMap<BoardMoveRequest>(this as BoardMoveRequest);
  }

  BoardMoveRequestCopyWith<BoardMoveRequest, BoardMoveRequest, BoardMoveRequest>
      get copyWith => _BoardMoveRequestCopyWithImpl(
          this as BoardMoveRequest, $identity, $identity);
  @override
  String toString() {
    return BoardMoveRequestMapper.ensureInitialized()
        .stringifyValue(this as BoardMoveRequest);
  }

  @override
  bool operator ==(Object other) {
    return BoardMoveRequestMapper.ensureInitialized()
        .equalsValue(this as BoardMoveRequest, other);
  }

  @override
  int get hashCode {
    return BoardMoveRequestMapper.ensureInitialized()
        .hashValue(this as BoardMoveRequest);
  }
}

extension BoardMoveRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardMoveRequest, $Out> {
  BoardMoveRequestCopyWith<$R, BoardMoveRequest, $Out>
      get $asBoardMoveRequest =>
          $base.as((v, t, t2) => _BoardMoveRequestCopyWithImpl(v, t, t2));
}

abstract class BoardMoveRequestCopyWith<$R, $In extends BoardMoveRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to;
  @override
  $R call(
      {String? table,
      VectorDefinition? from,
      VectorDefinition? to,
      int? index});
  BoardMoveRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardMoveRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardMoveRequest, $Out>
    implements BoardMoveRequestCopyWith<$R, BoardMoveRequest, $Out> {
  _BoardMoveRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardMoveRequest> $mapper =
      BoardMoveRequestMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from =>
      $value.from.copyWith.$chain((v) => call(from: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to =>
      $value.to.copyWith.$chain((v) => call(to: v));
  @override
  $R call(
          {String? table,
          VectorDefinition? from,
          VectorDefinition? to,
          int? index}) =>
      $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (from != null) #from: from,
        if (to != null) #to: to,
        if (index != null) #index: index
      }));
  @override
  BoardMoveRequest $make(CopyWithData data) => BoardMoveRequest(
      data.get(#table, or: $value.table),
      data.get(#from, or: $value.from),
      data.get(#to, or: $value.to),
      data.get(#index, or: $value.index));

  @override
  BoardMoveRequestCopyWith<$R2, BoardMoveRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoardMoveRequestCopyWithImpl($value, $cast, t);
}

class DialogCloseRequestMapper extends SubClassMapperBase<DialogCloseRequest> {
  DialogCloseRequestMapper._();

  static DialogCloseRequestMapper? _instance;
  static DialogCloseRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DialogCloseRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameDialogValueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DialogCloseRequest';

  static String _$id(DialogCloseRequest v) => v.id;
  static const Field<DialogCloseRequest, String> _f$id = Field('id', _$id);
  static GameDialogValue? _$value(DialogCloseRequest v) => v.value;
  static const Field<DialogCloseRequest, GameDialogValue> _f$value =
      Field('value', _$value);

  @override
  final MappableFields<DialogCloseRequest> fields = const {
    #id: _f$id,
    #value: _f$value,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DialogCloseRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static DialogCloseRequest _instantiate(DecodingData data) {
    return DialogCloseRequest(data.dec(_f$id), data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static DialogCloseRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DialogCloseRequest>(map);
  }

  static DialogCloseRequest fromJson(String json) {
    return ensureInitialized().decodeJson<DialogCloseRequest>(json);
  }
}

mixin DialogCloseRequestMappable {
  String toJson() {
    return DialogCloseRequestMapper.ensureInitialized()
        .encodeJson<DialogCloseRequest>(this as DialogCloseRequest);
  }

  Map<String, dynamic> toMap() {
    return DialogCloseRequestMapper.ensureInitialized()
        .encodeMap<DialogCloseRequest>(this as DialogCloseRequest);
  }

  DialogCloseRequestCopyWith<DialogCloseRequest, DialogCloseRequest,
          DialogCloseRequest>
      get copyWith => _DialogCloseRequestCopyWithImpl(
          this as DialogCloseRequest, $identity, $identity);
  @override
  String toString() {
    return DialogCloseRequestMapper.ensureInitialized()
        .stringifyValue(this as DialogCloseRequest);
  }

  @override
  bool operator ==(Object other) {
    return DialogCloseRequestMapper.ensureInitialized()
        .equalsValue(this as DialogCloseRequest, other);
  }

  @override
  int get hashCode {
    return DialogCloseRequestMapper.ensureInitialized()
        .hashValue(this as DialogCloseRequest);
  }
}

extension DialogCloseRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DialogCloseRequest, $Out> {
  DialogCloseRequestCopyWith<$R, DialogCloseRequest, $Out>
      get $asDialogCloseRequest =>
          $base.as((v, t, t2) => _DialogCloseRequestCopyWithImpl(v, t, t2));
}

abstract class DialogCloseRequestCopyWith<$R, $In extends DialogCloseRequest,
    $Out> implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GameDialogValueCopyWith<$R, GameDialogValue, GameDialogValue>? get value;
  @override
  $R call({String? id, GameDialogValue? value});
  DialogCloseRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DialogCloseRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DialogCloseRequest, $Out>
    implements DialogCloseRequestCopyWith<$R, DialogCloseRequest, $Out> {
  _DialogCloseRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DialogCloseRequest> $mapper =
      DialogCloseRequestMapper.ensureInitialized();
  @override
  GameDialogValueCopyWith<$R, GameDialogValue, GameDialogValue>? get value =>
      $value.value?.copyWith.$chain((v) => call(value: v));
  @override
  $R call({String? id, Object? value = $none}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (value != $none) #value: value}));
  @override
  DialogCloseRequest $make(CopyWithData data) => DialogCloseRequest(
      data.get(#id, or: $value.id), data.get(#value, or: $value.value));

  @override
  DialogCloseRequestCopyWith<$R2, DialogCloseRequest, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DialogCloseRequestCopyWithImpl($value, $cast, t);
}

class HybridWorldEventMapper extends SubClassMapperBase<HybridWorldEvent> {
  HybridWorldEventMapper._();

  static HybridWorldEventMapper? _instance;
  static HybridWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HybridWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      BackgroundChangedMapper.ensureInitialized();
      ObjectsSpawnedMapper.ensureInitialized();
      ObjectsMovedMapper.ensureInitialized();
      CellHideChangedMapper.ensureInitialized();
      ObjectIndexChangedMapper.ensureInitialized();
      TeamChangedMapper.ensureInitialized();
      TeamRemovedMapper.ensureInitialized();
      MetadataChangedMapper.ensureInitialized();
      ObjectsRemovedMapper.ensureInitialized();
      TableRenamedMapper.ensureInitialized();
      TableRemovedMapper.ensureInitialized();
      NoteChangedMapper.ensureInitialized();
      NoteRemovedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HybridWorldEvent';

  @override
  final MappableFields<HybridWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'HybridWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static HybridWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'HybridWorldEvent', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static HybridWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HybridWorldEvent>(map);
  }

  static HybridWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<HybridWorldEvent>(json);
  }
}

mixin HybridWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  HybridWorldEventCopyWith<HybridWorldEvent, HybridWorldEvent, HybridWorldEvent>
      get copyWith;
}

abstract class HybridWorldEventCopyWith<$R, $In extends HybridWorldEvent, $Out>
    implements
        WorldEventCopyWith<$R, $In, $Out>,
        ClientWorldEventCopyWith<$R, $In, $Out>,
        ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  HybridWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class BackgroundChangedMapper extends SubClassMapperBase<BackgroundChanged> {
  BackgroundChangedMapper._();

  static BackgroundChangedMapper? _instance;
  static BackgroundChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackgroundChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackgroundChanged';

  static ItemLocation _$background(BackgroundChanged v) => v.background;
  static const Field<BackgroundChanged, ItemLocation> _f$background =
      Field('background', _$background);

  @override
  final MappableFields<BackgroundChanged> fields = const {
    #background: _f$background,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BackgroundChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static BackgroundChanged _instantiate(DecodingData data) {
    return BackgroundChanged(data.dec(_f$background));
  }

  @override
  final Function instantiate = _instantiate;

  static BackgroundChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackgroundChanged>(map);
  }

  static BackgroundChanged fromJson(String json) {
    return ensureInitialized().decodeJson<BackgroundChanged>(json);
  }
}

mixin BackgroundChangedMappable {
  String toJson() {
    return BackgroundChangedMapper.ensureInitialized()
        .encodeJson<BackgroundChanged>(this as BackgroundChanged);
  }

  Map<String, dynamic> toMap() {
    return BackgroundChangedMapper.ensureInitialized()
        .encodeMap<BackgroundChanged>(this as BackgroundChanged);
  }

  BackgroundChangedCopyWith<BackgroundChanged, BackgroundChanged,
          BackgroundChanged>
      get copyWith => _BackgroundChangedCopyWithImpl(
          this as BackgroundChanged, $identity, $identity);
  @override
  String toString() {
    return BackgroundChangedMapper.ensureInitialized()
        .stringifyValue(this as BackgroundChanged);
  }

  @override
  bool operator ==(Object other) {
    return BackgroundChangedMapper.ensureInitialized()
        .equalsValue(this as BackgroundChanged, other);
  }

  @override
  int get hashCode {
    return BackgroundChangedMapper.ensureInitialized()
        .hashValue(this as BackgroundChanged);
  }
}

extension BackgroundChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BackgroundChanged, $Out> {
  BackgroundChangedCopyWith<$R, BackgroundChanged, $Out>
      get $asBackgroundChanged =>
          $base.as((v, t, t2) => _BackgroundChangedCopyWithImpl(v, t, t2));
}

abstract class BackgroundChangedCopyWith<$R, $In extends BackgroundChanged,
    $Out> implements HybridWorldEventCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get background;
  @override
  $R call({ItemLocation? background});
  BackgroundChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BackgroundChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BackgroundChanged, $Out>
    implements BackgroundChangedCopyWith<$R, BackgroundChanged, $Out> {
  _BackgroundChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BackgroundChanged> $mapper =
      BackgroundChangedMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get background =>
      $value.background.copyWith.$chain((v) => call(background: v));
  @override
  $R call({ItemLocation? background}) => $apply(
      FieldCopyWithData({if (background != null) #background: background}));
  @override
  BackgroundChanged $make(CopyWithData data) =>
      BackgroundChanged(data.get(#background, or: $value.background));

  @override
  BackgroundChangedCopyWith<$R2, BackgroundChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BackgroundChangedCopyWithImpl($value, $cast, t);
}

class ObjectsSpawnedMapper extends SubClassMapperBase<ObjectsSpawned> {
  ObjectsSpawnedMapper._();

  static ObjectsSpawnedMapper? _instance;
  static ObjectsSpawnedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsSpawnedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      GameObjectMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsSpawned';

  static String _$table(ObjectsSpawned v) => v.table;
  static const Field<ObjectsSpawned, String> _f$table = Field('table', _$table);
  static Map<VectorDefinition, List<GameObject>> _$objects(ObjectsSpawned v) =>
      v.objects;
  static const Field<ObjectsSpawned, Map<VectorDefinition, List<GameObject>>>
      _f$objects = Field('objects', _$objects, opt: true, def: const {});

  @override
  final MappableFields<ObjectsSpawned> fields = const {
    #table: _f$table,
    #objects: _f$objects,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsSpawned';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectsSpawned _instantiate(DecodingData data) {
    return ObjectsSpawned(data.dec(_f$table), data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsSpawned fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsSpawned>(map);
  }

  static ObjectsSpawned fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsSpawned>(json);
  }
}

mixin ObjectsSpawnedMappable {
  String toJson() {
    return ObjectsSpawnedMapper.ensureInitialized()
        .encodeJson<ObjectsSpawned>(this as ObjectsSpawned);
  }

  Map<String, dynamic> toMap() {
    return ObjectsSpawnedMapper.ensureInitialized()
        .encodeMap<ObjectsSpawned>(this as ObjectsSpawned);
  }

  ObjectsSpawnedCopyWith<ObjectsSpawned, ObjectsSpawned, ObjectsSpawned>
      get copyWith => _ObjectsSpawnedCopyWithImpl(
          this as ObjectsSpawned, $identity, $identity);
  @override
  String toString() {
    return ObjectsSpawnedMapper.ensureInitialized()
        .stringifyValue(this as ObjectsSpawned);
  }

  @override
  bool operator ==(Object other) {
    return ObjectsSpawnedMapper.ensureInitialized()
        .equalsValue(this as ObjectsSpawned, other);
  }

  @override
  int get hashCode {
    return ObjectsSpawnedMapper.ensureInitialized()
        .hashValue(this as ObjectsSpawned);
  }
}

extension ObjectsSpawnedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsSpawned, $Out> {
  ObjectsSpawnedCopyWith<$R, ObjectsSpawned, $Out> get $asObjectsSpawned =>
      $base.as((v, t, t2) => _ObjectsSpawnedCopyWithImpl(v, t, t2));
}

abstract class ObjectsSpawnedCopyWith<$R, $In extends ObjectsSpawned, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, VectorDefinition, List<GameObject>,
      ObjectCopyWith<$R, List<GameObject>, List<GameObject>>> get objects;
  @override
  $R call({String? table, Map<VectorDefinition, List<GameObject>>? objects});
  ObjectsSpawnedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectsSpawnedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsSpawned, $Out>
    implements ObjectsSpawnedCopyWith<$R, ObjectsSpawned, $Out> {
  _ObjectsSpawnedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsSpawned> $mapper =
      ObjectsSpawnedMapper.ensureInitialized();
  @override
  MapCopyWith<$R, VectorDefinition, List<GameObject>,
          ObjectCopyWith<$R, List<GameObject>, List<GameObject>>>
      get objects => MapCopyWith($value.objects,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(objects: v));
  @override
  $R call({String? table, Map<VectorDefinition, List<GameObject>>? objects}) =>
      $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (objects != null) #objects: objects
      }));
  @override
  ObjectsSpawned $make(CopyWithData data) => ObjectsSpawned(
      data.get(#table, or: $value.table),
      data.get(#objects, or: $value.objects));

  @override
  ObjectsSpawnedCopyWith<$R2, ObjectsSpawned, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectsSpawnedCopyWithImpl($value, $cast, t);
}

class ObjectsMovedMapper extends SubClassMapperBase<ObjectsMoved> {
  ObjectsMovedMapper._();

  static ObjectsMovedMapper? _instance;
  static ObjectsMovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsMovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsMoved';

  static String _$table(ObjectsMoved v) => v.table;
  static const Field<ObjectsMoved, String> _f$table = Field('table', _$table);
  static List<int> _$objects(ObjectsMoved v) => v.objects;
  static const Field<ObjectsMoved, List<int>> _f$objects =
      Field('objects', _$objects);
  static VectorDefinition _$from(ObjectsMoved v) => v.from;
  static const Field<ObjectsMoved, VectorDefinition> _f$from =
      Field('from', _$from);
  static VectorDefinition _$to(ObjectsMoved v) => v.to;
  static const Field<ObjectsMoved, VectorDefinition> _f$to = Field('to', _$to);

  @override
  final MappableFields<ObjectsMoved> fields = const {
    #table: _f$table,
    #objects: _f$objects,
    #from: _f$from,
    #to: _f$to,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsMoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectsMoved _instantiate(DecodingData data) {
    return ObjectsMoved(data.dec(_f$table), data.dec(_f$objects),
        data.dec(_f$from), data.dec(_f$to));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsMoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsMoved>(map);
  }

  static ObjectsMoved fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsMoved>(json);
  }
}

mixin ObjectsMovedMappable {
  String toJson() {
    return ObjectsMovedMapper.ensureInitialized()
        .encodeJson<ObjectsMoved>(this as ObjectsMoved);
  }

  Map<String, dynamic> toMap() {
    return ObjectsMovedMapper.ensureInitialized()
        .encodeMap<ObjectsMoved>(this as ObjectsMoved);
  }

  ObjectsMovedCopyWith<ObjectsMoved, ObjectsMoved, ObjectsMoved> get copyWith =>
      _ObjectsMovedCopyWithImpl(this as ObjectsMoved, $identity, $identity);
  @override
  String toString() {
    return ObjectsMovedMapper.ensureInitialized()
        .stringifyValue(this as ObjectsMoved);
  }

  @override
  bool operator ==(Object other) {
    return ObjectsMovedMapper.ensureInitialized()
        .equalsValue(this as ObjectsMoved, other);
  }

  @override
  int get hashCode {
    return ObjectsMovedMapper.ensureInitialized()
        .hashValue(this as ObjectsMoved);
  }
}

extension ObjectsMovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsMoved, $Out> {
  ObjectsMovedCopyWith<$R, ObjectsMoved, $Out> get $asObjectsMoved =>
      $base.as((v, t, t2) => _ObjectsMovedCopyWithImpl(v, t, t2));
}

abstract class ObjectsMovedCopyWith<$R, $In extends ObjectsMoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get objects;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to;
  @override
  $R call(
      {String? table,
      List<int>? objects,
      VectorDefinition? from,
      VectorDefinition? to});
  ObjectsMovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectsMovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsMoved, $Out>
    implements ObjectsMovedCopyWith<$R, ObjectsMoved, $Out> {
  _ObjectsMovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsMoved> $mapper =
      ObjectsMovedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get objects =>
      ListCopyWith($value.objects, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(objects: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from =>
      $value.from.copyWith.$chain((v) => call(from: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to =>
      $value.to.copyWith.$chain((v) => call(to: v));
  @override
  $R call(
          {String? table,
          List<int>? objects,
          VectorDefinition? from,
          VectorDefinition? to}) =>
      $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (objects != null) #objects: objects,
        if (from != null) #from: from,
        if (to != null) #to: to
      }));
  @override
  ObjectsMoved $make(CopyWithData data) => ObjectsMoved(
      data.get(#table, or: $value.table),
      data.get(#objects, or: $value.objects),
      data.get(#from, or: $value.from),
      data.get(#to, or: $value.to));

  @override
  ObjectsMovedCopyWith<$R2, ObjectsMoved, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectsMovedCopyWithImpl($value, $cast, t);
}

class CellHideChangedMapper extends SubClassMapperBase<CellHideChanged> {
  CellHideChangedMapper._();

  static CellHideChangedMapper? _instance;
  static CellHideChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellHideChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellHideChanged';

  static GlobalVectorDefinition _$cell(CellHideChanged v) => v.cell;
  static const Field<CellHideChanged, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static int? _$object(CellHideChanged v) => v.object;
  static const Field<CellHideChanged, int> _f$object =
      Field('object', _$object, opt: true);
  static bool? _$hide(CellHideChanged v) => v.hide;
  static const Field<CellHideChanged, bool> _f$hide =
      Field('hide', _$hide, opt: true);

  @override
  final MappableFields<CellHideChanged> fields = const {
    #cell: _f$cell,
    #object: _f$object,
    #hide: _f$hide,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellHideChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static CellHideChanged _instantiate(DecodingData data) {
    return CellHideChanged(data.dec(_f$cell),
        object: data.dec(_f$object), hide: data.dec(_f$hide));
  }

  @override
  final Function instantiate = _instantiate;

  static CellHideChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellHideChanged>(map);
  }

  static CellHideChanged fromJson(String json) {
    return ensureInitialized().decodeJson<CellHideChanged>(json);
  }
}

mixin CellHideChangedMappable {
  String toJson() {
    return CellHideChangedMapper.ensureInitialized()
        .encodeJson<CellHideChanged>(this as CellHideChanged);
  }

  Map<String, dynamic> toMap() {
    return CellHideChangedMapper.ensureInitialized()
        .encodeMap<CellHideChanged>(this as CellHideChanged);
  }

  CellHideChangedCopyWith<CellHideChanged, CellHideChanged, CellHideChanged>
      get copyWith => _CellHideChangedCopyWithImpl(
          this as CellHideChanged, $identity, $identity);
  @override
  String toString() {
    return CellHideChangedMapper.ensureInitialized()
        .stringifyValue(this as CellHideChanged);
  }

  @override
  bool operator ==(Object other) {
    return CellHideChangedMapper.ensureInitialized()
        .equalsValue(this as CellHideChanged, other);
  }

  @override
  int get hashCode {
    return CellHideChangedMapper.ensureInitialized()
        .hashValue(this as CellHideChanged);
  }
}

extension CellHideChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellHideChanged, $Out> {
  CellHideChangedCopyWith<$R, CellHideChanged, $Out> get $asCellHideChanged =>
      $base.as((v, t, t2) => _CellHideChangedCopyWithImpl(v, t, t2));
}

abstract class CellHideChangedCopyWith<$R, $In extends CellHideChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get cell;
  @override
  $R call({GlobalVectorDefinition? cell, int? object, bool? hide});
  CellHideChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CellHideChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellHideChanged, $Out>
    implements CellHideChangedCopyWith<$R, CellHideChanged, $Out> {
  _CellHideChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellHideChanged> $mapper =
      CellHideChangedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call(
          {GlobalVectorDefinition? cell,
          Object? object = $none,
          Object? hide = $none}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (object != $none) #object: object,
        if (hide != $none) #hide: hide
      }));
  @override
  CellHideChanged $make(CopyWithData data) =>
      CellHideChanged(data.get(#cell, or: $value.cell),
          object: data.get(#object, or: $value.object),
          hide: data.get(#hide, or: $value.hide));

  @override
  CellHideChangedCopyWith<$R2, CellHideChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CellHideChangedCopyWithImpl($value, $cast, t);
}

class ObjectIndexChangedMapper extends SubClassMapperBase<ObjectIndexChanged> {
  ObjectIndexChangedMapper._();

  static ObjectIndexChangedMapper? _instance;
  static ObjectIndexChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIndexChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIndexChanged';

  static GlobalVectorDefinition _$cell(ObjectIndexChanged v) => v.cell;
  static const Field<ObjectIndexChanged, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static int _$object(ObjectIndexChanged v) => v.object;
  static const Field<ObjectIndexChanged, int> _f$object =
      Field('object', _$object);
  static int _$index(ObjectIndexChanged v) => v.index;
  static const Field<ObjectIndexChanged, int> _f$index =
      Field('index', _$index);

  @override
  final MappableFields<ObjectIndexChanged> fields = const {
    #cell: _f$cell,
    #object: _f$object,
    #index: _f$index,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectIndexChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectIndexChanged _instantiate(DecodingData data) {
    return ObjectIndexChanged(
        data.dec(_f$cell), data.dec(_f$object), data.dec(_f$index));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIndexChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIndexChanged>(map);
  }

  static ObjectIndexChanged fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIndexChanged>(json);
  }
}

mixin ObjectIndexChangedMappable {
  String toJson() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .encodeJson<ObjectIndexChanged>(this as ObjectIndexChanged);
  }

  Map<String, dynamic> toMap() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .encodeMap<ObjectIndexChanged>(this as ObjectIndexChanged);
  }

  ObjectIndexChangedCopyWith<ObjectIndexChanged, ObjectIndexChanged,
          ObjectIndexChanged>
      get copyWith => _ObjectIndexChangedCopyWithImpl(
          this as ObjectIndexChanged, $identity, $identity);
  @override
  String toString() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .stringifyValue(this as ObjectIndexChanged);
  }

  @override
  bool operator ==(Object other) {
    return ObjectIndexChangedMapper.ensureInitialized()
        .equalsValue(this as ObjectIndexChanged, other);
  }

  @override
  int get hashCode {
    return ObjectIndexChangedMapper.ensureInitialized()
        .hashValue(this as ObjectIndexChanged);
  }
}

extension ObjectIndexChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIndexChanged, $Out> {
  ObjectIndexChangedCopyWith<$R, ObjectIndexChanged, $Out>
      get $asObjectIndexChanged =>
          $base.as((v, t, t2) => _ObjectIndexChangedCopyWithImpl(v, t, t2));
}

abstract class ObjectIndexChangedCopyWith<$R, $In extends ObjectIndexChanged,
    $Out> implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get cell;
  @override
  $R call({GlobalVectorDefinition? cell, int? object, int? index});
  ObjectIndexChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectIndexChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIndexChanged, $Out>
    implements ObjectIndexChangedCopyWith<$R, ObjectIndexChanged, $Out> {
  _ObjectIndexChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIndexChanged> $mapper =
      ObjectIndexChangedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({GlobalVectorDefinition? cell, int? object, int? index}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (object != null) #object: object,
        if (index != null) #index: index
      }));
  @override
  ObjectIndexChanged $make(CopyWithData data) => ObjectIndexChanged(
      data.get(#cell, or: $value.cell),
      data.get(#object, or: $value.object),
      data.get(#index, or: $value.index));

  @override
  ObjectIndexChangedCopyWith<$R2, ObjectIndexChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIndexChangedCopyWithImpl($value, $cast, t);
}

class TeamChangedMapper extends SubClassMapperBase<TeamChanged> {
  TeamChangedMapper._();

  static TeamChangedMapper? _instance;
  static TeamChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameTeamMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TeamChanged';

  static String _$name(TeamChanged v) => v.name;
  static const Field<TeamChanged, String> _f$name = Field('name', _$name);
  static GameTeam _$team(TeamChanged v) => v.team;
  static const Field<TeamChanged, GameTeam> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamChanged> fields = const {
    #name: _f$name,
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TeamChanged _instantiate(DecodingData data) {
    return TeamChanged(data.dec(_f$name), data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamChanged>(map);
  }

  static TeamChanged fromJson(String json) {
    return ensureInitialized().decodeJson<TeamChanged>(json);
  }
}

mixin TeamChangedMappable {
  String toJson() {
    return TeamChangedMapper.ensureInitialized()
        .encodeJson<TeamChanged>(this as TeamChanged);
  }

  Map<String, dynamic> toMap() {
    return TeamChangedMapper.ensureInitialized()
        .encodeMap<TeamChanged>(this as TeamChanged);
  }

  TeamChangedCopyWith<TeamChanged, TeamChanged, TeamChanged> get copyWith =>
      _TeamChangedCopyWithImpl(this as TeamChanged, $identity, $identity);
  @override
  String toString() {
    return TeamChangedMapper.ensureInitialized()
        .stringifyValue(this as TeamChanged);
  }

  @override
  bool operator ==(Object other) {
    return TeamChangedMapper.ensureInitialized()
        .equalsValue(this as TeamChanged, other);
  }

  @override
  int get hashCode {
    return TeamChangedMapper.ensureInitialized().hashValue(this as TeamChanged);
  }
}

extension TeamChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamChanged, $Out> {
  TeamChangedCopyWith<$R, TeamChanged, $Out> get $asTeamChanged =>
      $base.as((v, t, t2) => _TeamChangedCopyWithImpl(v, t, t2));
}

abstract class TeamChangedCopyWith<$R, $In extends TeamChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GameTeamCopyWith<$R, GameTeam, GameTeam> get team;
  @override
  $R call({String? name, GameTeam? team});
  TeamChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TeamChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamChanged, $Out>
    implements TeamChangedCopyWith<$R, TeamChanged, $Out> {
  _TeamChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamChanged> $mapper =
      TeamChangedMapper.ensureInitialized();
  @override
  GameTeamCopyWith<$R, GameTeam, GameTeam> get team =>
      $value.team.copyWith.$chain((v) => call(team: v));
  @override
  $R call({String? name, GameTeam? team}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (team != null) #team: team}));
  @override
  TeamChanged $make(CopyWithData data) => TeamChanged(
      data.get(#name, or: $value.name), data.get(#team, or: $value.team));

  @override
  TeamChangedCopyWith<$R2, TeamChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeamChangedCopyWithImpl($value, $cast, t);
}

class TeamRemovedMapper extends SubClassMapperBase<TeamRemoved> {
  TeamRemovedMapper._();

  static TeamRemovedMapper? _instance;
  static TeamRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamRemoved';

  static String _$team(TeamRemoved v) => v.team;
  static const Field<TeamRemoved, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamRemoved> fields = const {
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TeamRemoved _instantiate(DecodingData data) {
    return TeamRemoved(data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamRemoved>(map);
  }

  static TeamRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<TeamRemoved>(json);
  }
}

mixin TeamRemovedMappable {
  String toJson() {
    return TeamRemovedMapper.ensureInitialized()
        .encodeJson<TeamRemoved>(this as TeamRemoved);
  }

  Map<String, dynamic> toMap() {
    return TeamRemovedMapper.ensureInitialized()
        .encodeMap<TeamRemoved>(this as TeamRemoved);
  }

  TeamRemovedCopyWith<TeamRemoved, TeamRemoved, TeamRemoved> get copyWith =>
      _TeamRemovedCopyWithImpl(this as TeamRemoved, $identity, $identity);
  @override
  String toString() {
    return TeamRemovedMapper.ensureInitialized()
        .stringifyValue(this as TeamRemoved);
  }

  @override
  bool operator ==(Object other) {
    return TeamRemovedMapper.ensureInitialized()
        .equalsValue(this as TeamRemoved, other);
  }

  @override
  int get hashCode {
    return TeamRemovedMapper.ensureInitialized().hashValue(this as TeamRemoved);
  }
}

extension TeamRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamRemoved, $Out> {
  TeamRemovedCopyWith<$R, TeamRemoved, $Out> get $asTeamRemoved =>
      $base.as((v, t, t2) => _TeamRemovedCopyWithImpl(v, t, t2));
}

abstract class TeamRemovedCopyWith<$R, $In extends TeamRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? team});
  TeamRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TeamRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamRemoved, $Out>
    implements TeamRemovedCopyWith<$R, TeamRemoved, $Out> {
  _TeamRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamRemoved> $mapper =
      TeamRemovedMapper.ensureInitialized();
  @override
  $R call({String? team}) =>
      $apply(FieldCopyWithData({if (team != null) #team: team}));
  @override
  TeamRemoved $make(CopyWithData data) =>
      TeamRemoved(data.get(#team, or: $value.team));

  @override
  TeamRemovedCopyWith<$R2, TeamRemoved, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TeamRemovedCopyWithImpl($value, $cast, t);
}

class MetadataChangedMapper extends SubClassMapperBase<MetadataChanged> {
  MetadataChangedMapper._();

  static MetadataChangedMapper? _instance;
  static MetadataChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MetadataChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      FileMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MetadataChanged';

  static FileMetadata _$metadata(MetadataChanged v) => v.metadata;
  static const Field<MetadataChanged, FileMetadata> _f$metadata =
      Field('metadata', _$metadata);

  @override
  final MappableFields<MetadataChanged> fields = const {
    #metadata: _f$metadata,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'MetadataChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static MetadataChanged _instantiate(DecodingData data) {
    return MetadataChanged(data.dec(_f$metadata));
  }

  @override
  final Function instantiate = _instantiate;

  static MetadataChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MetadataChanged>(map);
  }

  static MetadataChanged fromJson(String json) {
    return ensureInitialized().decodeJson<MetadataChanged>(json);
  }
}

mixin MetadataChangedMappable {
  String toJson() {
    return MetadataChangedMapper.ensureInitialized()
        .encodeJson<MetadataChanged>(this as MetadataChanged);
  }

  Map<String, dynamic> toMap() {
    return MetadataChangedMapper.ensureInitialized()
        .encodeMap<MetadataChanged>(this as MetadataChanged);
  }

  MetadataChangedCopyWith<MetadataChanged, MetadataChanged, MetadataChanged>
      get copyWith => _MetadataChangedCopyWithImpl(
          this as MetadataChanged, $identity, $identity);
  @override
  String toString() {
    return MetadataChangedMapper.ensureInitialized()
        .stringifyValue(this as MetadataChanged);
  }

  @override
  bool operator ==(Object other) {
    return MetadataChangedMapper.ensureInitialized()
        .equalsValue(this as MetadataChanged, other);
  }

  @override
  int get hashCode {
    return MetadataChangedMapper.ensureInitialized()
        .hashValue(this as MetadataChanged);
  }
}

extension MetadataChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MetadataChanged, $Out> {
  MetadataChangedCopyWith<$R, MetadataChanged, $Out> get $asMetadataChanged =>
      $base.as((v, t, t2) => _MetadataChangedCopyWithImpl(v, t, t2));
}

abstract class MetadataChangedCopyWith<$R, $In extends MetadataChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata;
  @override
  $R call({FileMetadata? metadata});
  MetadataChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MetadataChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MetadataChanged, $Out>
    implements MetadataChangedCopyWith<$R, MetadataChanged, $Out> {
  _MetadataChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MetadataChanged> $mapper =
      MetadataChangedMapper.ensureInitialized();
  @override
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
  @override
  $R call({FileMetadata? metadata}) =>
      $apply(FieldCopyWithData({if (metadata != null) #metadata: metadata}));
  @override
  MetadataChanged $make(CopyWithData data) =>
      MetadataChanged(data.get(#metadata, or: $value.metadata));

  @override
  MetadataChangedCopyWith<$R2, MetadataChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MetadataChangedCopyWithImpl($value, $cast, t);
}

class ObjectsRemovedMapper extends SubClassMapperBase<ObjectsRemoved> {
  ObjectsRemovedMapper._();

  static ObjectsRemovedMapper? _instance;
  static ObjectsRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsRemoved';

  static GlobalVectorDefinition _$cell(ObjectsRemoved v) => v.cell;
  static const Field<ObjectsRemoved, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static List<int>? _$objects(ObjectsRemoved v) => v.objects;
  static const Field<ObjectsRemoved, List<int>> _f$objects =
      Field('objects', _$objects, opt: true);

  @override
  final MappableFields<ObjectsRemoved> fields = const {
    #cell: _f$cell,
    #objects: _f$objects,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectsRemoved _instantiate(DecodingData data) {
    return ObjectsRemoved(data.dec(_f$cell), objects: data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsRemoved>(map);
  }

  static ObjectsRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsRemoved>(json);
  }
}

mixin ObjectsRemovedMappable {
  String toJson() {
    return ObjectsRemovedMapper.ensureInitialized()
        .encodeJson<ObjectsRemoved>(this as ObjectsRemoved);
  }

  Map<String, dynamic> toMap() {
    return ObjectsRemovedMapper.ensureInitialized()
        .encodeMap<ObjectsRemoved>(this as ObjectsRemoved);
  }

  ObjectsRemovedCopyWith<ObjectsRemoved, ObjectsRemoved, ObjectsRemoved>
      get copyWith => _ObjectsRemovedCopyWithImpl(
          this as ObjectsRemoved, $identity, $identity);
  @override
  String toString() {
    return ObjectsRemovedMapper.ensureInitialized()
        .stringifyValue(this as ObjectsRemoved);
  }

  @override
  bool operator ==(Object other) {
    return ObjectsRemovedMapper.ensureInitialized()
        .equalsValue(this as ObjectsRemoved, other);
  }

  @override
  int get hashCode {
    return ObjectsRemovedMapper.ensureInitialized()
        .hashValue(this as ObjectsRemoved);
  }
}

extension ObjectsRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsRemoved, $Out> {
  ObjectsRemovedCopyWith<$R, ObjectsRemoved, $Out> get $asObjectsRemoved =>
      $base.as((v, t, t2) => _ObjectsRemovedCopyWithImpl(v, t, t2));
}

abstract class ObjectsRemovedCopyWith<$R, $In extends ObjectsRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
      GlobalVectorDefinition> get cell;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>? get objects;
  @override
  $R call({GlobalVectorDefinition? cell, List<int>? objects});
  ObjectsRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectsRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsRemoved, $Out>
    implements ObjectsRemovedCopyWith<$R, ObjectsRemoved, $Out> {
  _ObjectsRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsRemoved> $mapper =
      ObjectsRemovedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>? get objects =>
      $value.objects != null
          ? ListCopyWith(
              $value.objects!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(objects: v))
          : null;
  @override
  $R call({GlobalVectorDefinition? cell, Object? objects = $none}) =>
      $apply(FieldCopyWithData({
        if (cell != null) #cell: cell,
        if (objects != $none) #objects: objects
      }));
  @override
  ObjectsRemoved $make(CopyWithData data) =>
      ObjectsRemoved(data.get(#cell, or: $value.cell),
          objects: data.get(#objects, or: $value.objects));

  @override
  ObjectsRemovedCopyWith<$R2, ObjectsRemoved, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectsRemovedCopyWithImpl($value, $cast, t);
}

class TableRenamedMapper extends SubClassMapperBase<TableRenamed> {
  TableRenamedMapper._();

  static TableRenamedMapper? _instance;
  static TableRenamedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableRenamedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TableRenamed';

  static String _$name(TableRenamed v) => v.name;
  static const Field<TableRenamed, String> _f$name = Field('name', _$name);
  static String _$newName(TableRenamed v) => v.newName;
  static const Field<TableRenamed, String> _f$newName =
      Field('newName', _$newName);

  @override
  final MappableFields<TableRenamed> fields = const {
    #name: _f$name,
    #newName: _f$newName,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TableRenamed';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TableRenamed _instantiate(DecodingData data) {
    return TableRenamed(data.dec(_f$name), data.dec(_f$newName));
  }

  @override
  final Function instantiate = _instantiate;

  static TableRenamed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableRenamed>(map);
  }

  static TableRenamed fromJson(String json) {
    return ensureInitialized().decodeJson<TableRenamed>(json);
  }
}

mixin TableRenamedMappable {
  String toJson() {
    return TableRenamedMapper.ensureInitialized()
        .encodeJson<TableRenamed>(this as TableRenamed);
  }

  Map<String, dynamic> toMap() {
    return TableRenamedMapper.ensureInitialized()
        .encodeMap<TableRenamed>(this as TableRenamed);
  }

  TableRenamedCopyWith<TableRenamed, TableRenamed, TableRenamed> get copyWith =>
      _TableRenamedCopyWithImpl(this as TableRenamed, $identity, $identity);
  @override
  String toString() {
    return TableRenamedMapper.ensureInitialized()
        .stringifyValue(this as TableRenamed);
  }

  @override
  bool operator ==(Object other) {
    return TableRenamedMapper.ensureInitialized()
        .equalsValue(this as TableRenamed, other);
  }

  @override
  int get hashCode {
    return TableRenamedMapper.ensureInitialized()
        .hashValue(this as TableRenamed);
  }
}

extension TableRenamedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableRenamed, $Out> {
  TableRenamedCopyWith<$R, TableRenamed, $Out> get $asTableRenamed =>
      $base.as((v, t, t2) => _TableRenamedCopyWithImpl(v, t, t2));
}

abstract class TableRenamedCopyWith<$R, $In extends TableRenamed, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? newName});
  TableRenamedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableRenamedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableRenamed, $Out>
    implements TableRenamedCopyWith<$R, TableRenamed, $Out> {
  _TableRenamedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableRenamed> $mapper =
      TableRenamedMapper.ensureInitialized();
  @override
  $R call({String? name, String? newName}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (newName != null) #newName: newName}));
  @override
  TableRenamed $make(CopyWithData data) => TableRenamed(
      data.get(#name, or: $value.name), data.get(#newName, or: $value.newName));

  @override
  TableRenamedCopyWith<$R2, TableRenamed, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableRenamedCopyWithImpl($value, $cast, t);
}

class TableRemovedMapper extends SubClassMapperBase<TableRemoved> {
  TableRemovedMapper._();

  static TableRemovedMapper? _instance;
  static TableRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TableRemoved';

  static String _$name(TableRemoved v) => v.name;
  static const Field<TableRemoved, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<TableRemoved> fields = const {
    #name: _f$name,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TableRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TableRemoved _instantiate(DecodingData data) {
    return TableRemoved(data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static TableRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableRemoved>(map);
  }

  static TableRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<TableRemoved>(json);
  }
}

mixin TableRemovedMappable {
  String toJson() {
    return TableRemovedMapper.ensureInitialized()
        .encodeJson<TableRemoved>(this as TableRemoved);
  }

  Map<String, dynamic> toMap() {
    return TableRemovedMapper.ensureInitialized()
        .encodeMap<TableRemoved>(this as TableRemoved);
  }

  TableRemovedCopyWith<TableRemoved, TableRemoved, TableRemoved> get copyWith =>
      _TableRemovedCopyWithImpl(this as TableRemoved, $identity, $identity);
  @override
  String toString() {
    return TableRemovedMapper.ensureInitialized()
        .stringifyValue(this as TableRemoved);
  }

  @override
  bool operator ==(Object other) {
    return TableRemovedMapper.ensureInitialized()
        .equalsValue(this as TableRemoved, other);
  }

  @override
  int get hashCode {
    return TableRemovedMapper.ensureInitialized()
        .hashValue(this as TableRemoved);
  }
}

extension TableRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableRemoved, $Out> {
  TableRemovedCopyWith<$R, TableRemoved, $Out> get $asTableRemoved =>
      $base.as((v, t, t2) => _TableRemovedCopyWithImpl(v, t, t2));
}

abstract class TableRemovedCopyWith<$R, $In extends TableRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name});
  TableRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableRemoved, $Out>
    implements TableRemovedCopyWith<$R, TableRemoved, $Out> {
  _TableRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableRemoved> $mapper =
      TableRemovedMapper.ensureInitialized();
  @override
  $R call({String? name}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name}));
  @override
  TableRemoved $make(CopyWithData data) =>
      TableRemoved(data.get(#name, or: $value.name));

  @override
  TableRemovedCopyWith<$R2, TableRemoved, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableRemovedCopyWithImpl($value, $cast, t);
}

class NoteChangedMapper extends SubClassMapperBase<NoteChanged> {
  NoteChangedMapper._();

  static NoteChangedMapper? _instance;
  static NoteChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'NoteChanged';

  static String _$name(NoteChanged v) => v.name;
  static const Field<NoteChanged, String> _f$name = Field('name', _$name);
  static String _$content(NoteChanged v) => v.content;
  static const Field<NoteChanged, String> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<NoteChanged> fields = const {
    #name: _f$name,
    #content: _f$content,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'NoteChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static NoteChanged _instantiate(DecodingData data) {
    return NoteChanged(data.dec(_f$name), data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static NoteChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteChanged>(map);
  }

  static NoteChanged fromJson(String json) {
    return ensureInitialized().decodeJson<NoteChanged>(json);
  }
}

mixin NoteChangedMappable {
  String toJson() {
    return NoteChangedMapper.ensureInitialized()
        .encodeJson<NoteChanged>(this as NoteChanged);
  }

  Map<String, dynamic> toMap() {
    return NoteChangedMapper.ensureInitialized()
        .encodeMap<NoteChanged>(this as NoteChanged);
  }

  NoteChangedCopyWith<NoteChanged, NoteChanged, NoteChanged> get copyWith =>
      _NoteChangedCopyWithImpl(this as NoteChanged, $identity, $identity);
  @override
  String toString() {
    return NoteChangedMapper.ensureInitialized()
        .stringifyValue(this as NoteChanged);
  }

  @override
  bool operator ==(Object other) {
    return NoteChangedMapper.ensureInitialized()
        .equalsValue(this as NoteChanged, other);
  }

  @override
  int get hashCode {
    return NoteChangedMapper.ensureInitialized().hashValue(this as NoteChanged);
  }
}

extension NoteChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NoteChanged, $Out> {
  NoteChangedCopyWith<$R, NoteChanged, $Out> get $asNoteChanged =>
      $base.as((v, t, t2) => _NoteChangedCopyWithImpl(v, t, t2));
}

abstract class NoteChangedCopyWith<$R, $In extends NoteChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? content});
  NoteChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NoteChanged, $Out>
    implements NoteChangedCopyWith<$R, NoteChanged, $Out> {
  _NoteChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteChanged> $mapper =
      NoteChangedMapper.ensureInitialized();
  @override
  $R call({String? name, String? content}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (content != null) #content: content}));
  @override
  NoteChanged $make(CopyWithData data) => NoteChanged(
      data.get(#name, or: $value.name), data.get(#content, or: $value.content));

  @override
  NoteChangedCopyWith<$R2, NoteChanged, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NoteChangedCopyWithImpl($value, $cast, t);
}

class NoteRemovedMapper extends SubClassMapperBase<NoteRemoved> {
  NoteRemovedMapper._();

  static NoteRemovedMapper? _instance;
  static NoteRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'NoteRemoved';

  static String _$name(NoteRemoved v) => v.name;
  static const Field<NoteRemoved, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<NoteRemoved> fields = const {
    #name: _f$name,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'NoteRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static NoteRemoved _instantiate(DecodingData data) {
    return NoteRemoved(data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static NoteRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteRemoved>(map);
  }

  static NoteRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<NoteRemoved>(json);
  }
}

mixin NoteRemovedMappable {
  String toJson() {
    return NoteRemovedMapper.ensureInitialized()
        .encodeJson<NoteRemoved>(this as NoteRemoved);
  }

  Map<String, dynamic> toMap() {
    return NoteRemovedMapper.ensureInitialized()
        .encodeMap<NoteRemoved>(this as NoteRemoved);
  }

  NoteRemovedCopyWith<NoteRemoved, NoteRemoved, NoteRemoved> get copyWith =>
      _NoteRemovedCopyWithImpl(this as NoteRemoved, $identity, $identity);
  @override
  String toString() {
    return NoteRemovedMapper.ensureInitialized()
        .stringifyValue(this as NoteRemoved);
  }

  @override
  bool operator ==(Object other) {
    return NoteRemovedMapper.ensureInitialized()
        .equalsValue(this as NoteRemoved, other);
  }

  @override
  int get hashCode {
    return NoteRemovedMapper.ensureInitialized().hashValue(this as NoteRemoved);
  }
}

extension NoteRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NoteRemoved, $Out> {
  NoteRemovedCopyWith<$R, NoteRemoved, $Out> get $asNoteRemoved =>
      $base.as((v, t, t2) => _NoteRemovedCopyWithImpl(v, t, t2));
}

abstract class NoteRemovedCopyWith<$R, $In extends NoteRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name});
  NoteRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NoteRemoved, $Out>
    implements NoteRemovedCopyWith<$R, NoteRemoved, $Out> {
  _NoteRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteRemoved> $mapper =
      NoteRemovedMapper.ensureInitialized();
  @override
  $R call({String? name}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name}));
  @override
  NoteRemoved $make(CopyWithData data) =>
      NoteRemoved(data.get(#name, or: $value.name));

  @override
  NoteRemovedCopyWith<$R2, NoteRemoved, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NoteRemovedCopyWithImpl($value, $cast, t);
}

class LocalWorldEventMapper extends SubClassMapperBase<LocalWorldEvent> {
  LocalWorldEventMapper._();

  static LocalWorldEventMapper? _instance;
  static LocalWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'LocalWorldEvent';

  @override
  final MappableFields<LocalWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'LocalWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static LocalWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LocalWorldEvent');
  }

  @override
  final Function instantiate = _instantiate;

  static LocalWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalWorldEvent>(map);
  }

  static LocalWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<LocalWorldEvent>(json);
  }
}

mixin LocalWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LocalWorldEventCopyWith<LocalWorldEvent, LocalWorldEvent, LocalWorldEvent>
      get copyWith;
}

abstract class LocalWorldEventCopyWith<$R, $In extends LocalWorldEvent, $Out>
    implements
        WorldEventCopyWith<$R, $In, $Out>,
        PlayableWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LocalWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}
