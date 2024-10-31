// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'state.dart';

class WorldOperationModeMapper extends EnumMapper<WorldOperationMode> {
  WorldOperationModeMapper._();

  static WorldOperationModeMapper? _instance;
  static WorldOperationModeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldOperationModeMapper._());
    }
    return _instance!;
  }

  static WorldOperationMode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  WorldOperationMode decode(dynamic value) {
    switch (value) {
      case 'figures':
        return WorldOperationMode.figures;
      case 'boards':
        return WorldOperationMode.boards;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(WorldOperationMode self) {
    switch (self) {
      case WorldOperationMode.figures:
        return 'figures';
      case WorldOperationMode.boards:
        return 'boards';
    }
  }
}

extension WorldOperationModeMapperExtension on WorldOperationMode {
  String toValue() {
    WorldOperationModeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<WorldOperationMode>(this) as String;
  }
}

class WorldStateMapper extends ClassMapperBase<WorldState> {
  WorldStateMapper._();

  static WorldStateMapper? _instance;
  static WorldStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldStateMapper._());
      GameTableMapper.ensureInitialized();
      GameInfoMapper.ensureInitialized();
      FileMetadataMapper.ensureInitialized();
      ChatMessageMapper.ensureInitialized();
      GameDialogMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorldState';

  static String? _$name(WorldState v) => v.name;
  static const Field<WorldState, String> _f$name =
      Field('name', _$name, opt: true);
  static GameTable _$table(WorldState v) => v.table;
  static const Field<WorldState, GameTable> _f$table =
      Field('table', _$table, opt: true, def: const GameTable());
  static String _$tableName(WorldState v) => v.tableName;
  static const Field<WorldState, String> _f$tableName =
      Field('tableName', _$tableName, opt: true, def: '');
  static GameInfo _$info(WorldState v) => v.info;
  static const Field<WorldState, GameInfo> _f$info =
      Field('info', _$info, opt: true, def: const GameInfo());
  static FileMetadata _$metadata(WorldState v) => v.metadata;
  static const Field<WorldState, FileMetadata> _f$metadata =
      Field('metadata', _$metadata, opt: true, def: const FileMetadata());
  static Map<String, Set<int>> _$teamMembers(WorldState v) => v.teamMembers;
  static const Field<WorldState, Map<String, Set<int>>> _f$teamMembers =
      Field('teamMembers', _$teamMembers, opt: true, def: const {});
  static List<ChatMessage> _$messages(WorldState v) => v.messages;
  static const Field<WorldState, List<ChatMessage>> _f$messages =
      Field('messages', _$messages, opt: true, def: const []);
  static int _$id(WorldState v) => v.id;
  static const Field<WorldState, int> _f$id =
      Field('id', _$id, opt: true, def: kAuthorityChannel);
  static List<GameDialog> _$dialogs(WorldState v) => v.dialogs;
  static const Field<WorldState, List<GameDialog>> _f$dialogs =
      Field('dialogs', _$dialogs, opt: true, def: const []);
  static Map<String, Uint8List> _$images(WorldState v) => v.images;
  static const Field<WorldState, Map<String, Uint8List>> _f$images =
      Field('images', _$images, opt: true, def: const {});
  static SetonixData _$data(WorldState v) => v.data;
  static const Field<WorldState, SetonixData> _f$data = Field('data', _$data);

  @override
  final MappableFields<WorldState> fields = const {
    #name: _f$name,
    #table: _f$table,
    #tableName: _f$tableName,
    #info: _f$info,
    #metadata: _f$metadata,
    #teamMembers: _f$teamMembers,
    #messages: _f$messages,
    #id: _f$id,
    #dialogs: _f$dialogs,
    #images: _f$images,
    #data: _f$data,
  };

  static WorldState _instantiate(DecodingData data) {
    return WorldState(
        name: data.dec(_f$name),
        table: data.dec(_f$table),
        tableName: data.dec(_f$tableName),
        info: data.dec(_f$info),
        metadata: data.dec(_f$metadata),
        teamMembers: data.dec(_f$teamMembers),
        messages: data.dec(_f$messages),
        id: data.dec(_f$id),
        dialogs: data.dec(_f$dialogs),
        images: data.dec(_f$images),
        data: data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static WorldState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorldState>(map);
  }

  static WorldState fromJson(String json) {
    return ensureInitialized().decodeJson<WorldState>(json);
  }
}

mixin WorldStateMappable {
  String toJson() {
    return WorldStateMapper.ensureInitialized()
        .encodeJson<WorldState>(this as WorldState);
  }

  Map<String, dynamic> toMap() {
    return WorldStateMapper.ensureInitialized()
        .encodeMap<WorldState>(this as WorldState);
  }

  WorldStateCopyWith<WorldState, WorldState, WorldState> get copyWith =>
      _WorldStateCopyWithImpl(this as WorldState, $identity, $identity);
  @override
  String toString() {
    return WorldStateMapper.ensureInitialized()
        .stringifyValue(this as WorldState);
  }

  @override
  bool operator ==(Object other) {
    return WorldStateMapper.ensureInitialized()
        .equalsValue(this as WorldState, other);
  }

  @override
  int get hashCode {
    return WorldStateMapper.ensureInitialized().hashValue(this as WorldState);
  }
}

extension WorldStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorldState, $Out> {
  WorldStateCopyWith<$R, WorldState, $Out> get $asWorldState =>
      $base.as((v, t, t2) => _WorldStateCopyWithImpl(v, t, t2));
}

abstract class WorldStateCopyWith<$R, $In extends WorldState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  GameTableCopyWith<$R, GameTable, GameTable> get table;
  GameInfoCopyWith<$R, GameInfo, GameInfo> get info;
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata;
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>
      get teamMembers;
  ListCopyWith<$R, ChatMessage,
      ChatMessageCopyWith<$R, ChatMessage, ChatMessage>> get messages;
  ListCopyWith<$R, GameDialog, GameDialogCopyWith<$R, GameDialog, GameDialog>>
      get dialogs;
  MapCopyWith<$R, String, Uint8List, ObjectCopyWith<$R, Uint8List, Uint8List>>
      get images;
  $R call(
      {String? name,
      GameTable? table,
      String? tableName,
      GameInfo? info,
      FileMetadata? metadata,
      Map<String, Set<int>>? teamMembers,
      List<ChatMessage>? messages,
      int? id,
      List<GameDialog>? dialogs,
      Map<String, Uint8List>? images,
      SetonixData? data});
  WorldStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WorldStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorldState, $Out>
    implements WorldStateCopyWith<$R, WorldState, $Out> {
  _WorldStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorldState> $mapper =
      WorldStateMapper.ensureInitialized();
  @override
  GameTableCopyWith<$R, GameTable, GameTable> get table =>
      $value.table.copyWith.$chain((v) => call(table: v));
  @override
  GameInfoCopyWith<$R, GameInfo, GameInfo> get info =>
      $value.info.copyWith.$chain((v) => call(info: v));
  @override
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
  @override
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>
      get teamMembers => MapCopyWith(
          $value.teamMembers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(teamMembers: v));
  @override
  ListCopyWith<$R, ChatMessage,
          ChatMessageCopyWith<$R, ChatMessage, ChatMessage>>
      get messages => ListCopyWith($value.messages,
          (v, t) => v.copyWith.$chain(t), (v) => call(messages: v));
  @override
  ListCopyWith<$R, GameDialog, GameDialogCopyWith<$R, GameDialog, GameDialog>>
      get dialogs => ListCopyWith($value.dialogs,
          (v, t) => v.copyWith.$chain(t), (v) => call(dialogs: v));
  @override
  MapCopyWith<$R, String, Uint8List, ObjectCopyWith<$R, Uint8List, Uint8List>>
      get images => MapCopyWith($value.images,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(images: v));
  @override
  $R call(
          {Object? name = $none,
          GameTable? table,
          String? tableName,
          GameInfo? info,
          FileMetadata? metadata,
          Map<String, Set<int>>? teamMembers,
          List<ChatMessage>? messages,
          int? id,
          List<GameDialog>? dialogs,
          Map<String, Uint8List>? images,
          SetonixData? data}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (table != null) #table: table,
        if (tableName != null) #tableName: tableName,
        if (info != null) #info: info,
        if (metadata != null) #metadata: metadata,
        if (teamMembers != null) #teamMembers: teamMembers,
        if (messages != null) #messages: messages,
        if (id != null) #id: id,
        if (dialogs != null) #dialogs: dialogs,
        if (images != null) #images: images,
        if (data != null) #data: data
      }));
  @override
  WorldState $make(CopyWithData data) => WorldState(
      name: data.get(#name, or: $value.name),
      table: data.get(#table, or: $value.table),
      tableName: data.get(#tableName, or: $value.tableName),
      info: data.get(#info, or: $value.info),
      metadata: data.get(#metadata, or: $value.metadata),
      teamMembers: data.get(#teamMembers, or: $value.teamMembers),
      messages: data.get(#messages, or: $value.messages),
      id: data.get(#id, or: $value.id),
      dialogs: data.get(#dialogs, or: $value.dialogs),
      images: data.get(#images, or: $value.images),
      data: data.get(#data, or: $value.data));

  @override
  WorldStateCopyWith<$R2, WorldState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WorldStateCopyWithImpl($value, $cast, t);
}
