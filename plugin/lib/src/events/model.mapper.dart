// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class UserJoinedMapper extends SubClassMapperBase<UserJoined> {
  UserJoinedMapper._();

  static UserJoinedMapper? _instance;
  static UserJoinedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserJoinedMapper._());
      LocalWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'UserJoined';

  static int _$channel(UserJoined v) => v.channel;
  static const Field<UserJoined, int> _f$channel = Field('channel', _$channel);
  static ConnectionInfo _$info(UserJoined v) => v.info;
  static const Field<UserJoined, ConnectionInfo> _f$info =
      Field('info', _$info);

  @override
  final MappableFields<UserJoined> fields = const {
    #channel: _f$channel,
    #info: _f$info,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'UserJoined';
  @override
  late final ClassMapperBase superMapper =
      LocalWorldEventMapper.ensureInitialized();

  static UserJoined _instantiate(DecodingData data) {
    return UserJoined(channel: data.dec(_f$channel), info: data.dec(_f$info));
  }

  @override
  final Function instantiate = _instantiate;

  static UserJoined fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserJoined>(map);
  }

  static UserJoined fromJson(String json) {
    return ensureInitialized().decodeJson<UserJoined>(json);
  }
}

mixin UserJoinedMappable {
  String toJson() {
    return UserJoinedMapper.ensureInitialized()
        .encodeJson<UserJoined>(this as UserJoined);
  }

  Map<String, dynamic> toMap() {
    return UserJoinedMapper.ensureInitialized()
        .encodeMap<UserJoined>(this as UserJoined);
  }

  UserJoinedCopyWith<UserJoined, UserJoined, UserJoined> get copyWith =>
      _UserJoinedCopyWithImpl(this as UserJoined, $identity, $identity);
  @override
  String toString() {
    return UserJoinedMapper.ensureInitialized()
        .stringifyValue(this as UserJoined);
  }

  @override
  bool operator ==(Object other) {
    return UserJoinedMapper.ensureInitialized()
        .equalsValue(this as UserJoined, other);
  }

  @override
  int get hashCode {
    return UserJoinedMapper.ensureInitialized().hashValue(this as UserJoined);
  }
}

extension UserJoinedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserJoined, $Out> {
  UserJoinedCopyWith<$R, UserJoined, $Out> get $asUserJoined =>
      $base.as((v, t, t2) => _UserJoinedCopyWithImpl(v, t, t2));
}

abstract class UserJoinedCopyWith<$R, $In extends UserJoined, $Out>
    implements LocalWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({int? channel, ConnectionInfo? info});
  UserJoinedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserJoinedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserJoined, $Out>
    implements UserJoinedCopyWith<$R, UserJoined, $Out> {
  _UserJoinedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserJoined> $mapper =
      UserJoinedMapper.ensureInitialized();
  @override
  $R call({int? channel, ConnectionInfo? info}) => $apply(FieldCopyWithData(
      {if (channel != null) #channel: channel, if (info != null) #info: info}));
  @override
  UserJoined $make(CopyWithData data) => UserJoined(
      channel: data.get(#channel, or: $value.channel),
      info: data.get(#info, or: $value.info));

  @override
  UserJoinedCopyWith<$R2, UserJoined, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserJoinedCopyWithImpl($value, $cast, t);
}

class ResetWorldMapper extends SubClassMapperBase<ResetWorld> {
  ResetWorldMapper._();

  static ResetWorldMapper? _instance;
  static ResetWorldMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResetWorldMapper._());
      LocalWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'ResetWorld';

  @override
  final MappableFields<ResetWorld> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ResetWorld';
  @override
  late final ClassMapperBase superMapper =
      LocalWorldEventMapper.ensureInitialized();

  static ResetWorld _instantiate(DecodingData data) {
    return ResetWorld();
  }

  @override
  final Function instantiate = _instantiate;

  static ResetWorld fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ResetWorld>(map);
  }

  static ResetWorld fromJson(String json) {
    return ensureInitialized().decodeJson<ResetWorld>(json);
  }
}

mixin ResetWorldMappable {
  String toJson() {
    return ResetWorldMapper.ensureInitialized()
        .encodeJson<ResetWorld>(this as ResetWorld);
  }

  Map<String, dynamic> toMap() {
    return ResetWorldMapper.ensureInitialized()
        .encodeMap<ResetWorld>(this as ResetWorld);
  }

  ResetWorldCopyWith<ResetWorld, ResetWorld, ResetWorld> get copyWith =>
      _ResetWorldCopyWithImpl(this as ResetWorld, $identity, $identity);
  @override
  String toString() {
    return ResetWorldMapper.ensureInitialized()
        .stringifyValue(this as ResetWorld);
  }

  @override
  bool operator ==(Object other) {
    return ResetWorldMapper.ensureInitialized()
        .equalsValue(this as ResetWorld, other);
  }

  @override
  int get hashCode {
    return ResetWorldMapper.ensureInitialized().hashValue(this as ResetWorld);
  }
}

extension ResetWorldValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ResetWorld, $Out> {
  ResetWorldCopyWith<$R, ResetWorld, $Out> get $asResetWorld =>
      $base.as((v, t, t2) => _ResetWorldCopyWithImpl(v, t, t2));
}

abstract class ResetWorldCopyWith<$R, $In extends ResetWorld, $Out>
    implements LocalWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ResetWorldCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ResetWorldCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ResetWorld, $Out>
    implements ResetWorldCopyWith<$R, ResetWorld, $Out> {
  _ResetWorldCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ResetWorld> $mapper =
      ResetWorldMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ResetWorld $make(CopyWithData data) => ResetWorld();

  @override
  ResetWorldCopyWith<$R2, ResetWorld, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ResetWorldCopyWithImpl($value, $cast, t);
}
