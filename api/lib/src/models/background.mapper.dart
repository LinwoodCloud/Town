// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'background.dart';

class BackgroundDefinitionMapper extends ClassMapperBase<BackgroundDefinition> {
  BackgroundDefinitionMapper._();

  static BackgroundDefinitionMapper? _instance;
  static BackgroundDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackgroundDefinitionMapper._());
      VisualDefinitionMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackgroundDefinition';

  static VectorDefinition _$offset(BackgroundDefinition v) => v.offset;
  static const Field<BackgroundDefinition, VectorDefinition> _f$offset =
      Field('offset', _$offset, opt: true, def: VectorDefinition.zero);
  static VectorDefinition? _$size(BackgroundDefinition v) => v.size;
  static const Field<BackgroundDefinition, VectorDefinition> _f$size =
      Field('size', _$size, opt: true);
  static String _$texture(BackgroundDefinition v) => v.texture;
  static const Field<BackgroundDefinition, String> _f$texture =
      Field('texture', _$texture);
  static int _$priority(BackgroundDefinition v) => v.priority;
  static const Field<BackgroundDefinition, int> _f$priority =
      Field('priority', _$priority, opt: true, def: 0);

  @override
  final MappableFields<BackgroundDefinition> fields = const {
    #offset: _f$offset,
    #size: _f$size,
    #texture: _f$texture,
    #priority: _f$priority,
  };

  static BackgroundDefinition _instantiate(DecodingData data) {
    return BackgroundDefinition(
        offset: data.dec(_f$offset),
        size: data.dec(_f$size),
        texture: data.dec(_f$texture),
        priority: data.dec(_f$priority));
  }

  @override
  final Function instantiate = _instantiate;

  static BackgroundDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackgroundDefinition>(map);
  }

  static BackgroundDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<BackgroundDefinition>(json);
  }
}

mixin BackgroundDefinitionMappable {
  String toJson() {
    return BackgroundDefinitionMapper.ensureInitialized()
        .encodeJson<BackgroundDefinition>(this as BackgroundDefinition);
  }

  Map<String, dynamic> toMap() {
    return BackgroundDefinitionMapper.ensureInitialized()
        .encodeMap<BackgroundDefinition>(this as BackgroundDefinition);
  }

  BackgroundDefinitionCopyWith<BackgroundDefinition, BackgroundDefinition,
          BackgroundDefinition>
      get copyWith => _BackgroundDefinitionCopyWithImpl(
          this as BackgroundDefinition, $identity, $identity);
  @override
  String toString() {
    return BackgroundDefinitionMapper.ensureInitialized()
        .stringifyValue(this as BackgroundDefinition);
  }

  @override
  bool operator ==(Object other) {
    return BackgroundDefinitionMapper.ensureInitialized()
        .equalsValue(this as BackgroundDefinition, other);
  }

  @override
  int get hashCode {
    return BackgroundDefinitionMapper.ensureInitialized()
        .hashValue(this as BackgroundDefinition);
  }
}

extension BackgroundDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BackgroundDefinition, $Out> {
  BackgroundDefinitionCopyWith<$R, BackgroundDefinition, $Out>
      get $asBackgroundDefinition =>
          $base.as((v, t, t2) => _BackgroundDefinitionCopyWithImpl(v, t, t2));
}

abstract class BackgroundDefinitionCopyWith<
    $R,
    $In extends BackgroundDefinition,
    $Out> implements VisualDefinitionCopyWith<$R, $In, $Out> {
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset;
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size;
  @override
  $R call(
      {VectorDefinition? offset,
      VectorDefinition? size,
      String? texture,
      int? priority});
  BackgroundDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BackgroundDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BackgroundDefinition, $Out>
    implements BackgroundDefinitionCopyWith<$R, BackgroundDefinition, $Out> {
  _BackgroundDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BackgroundDefinition> $mapper =
      BackgroundDefinitionMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset =>
      $value.offset.copyWith.$chain((v) => call(offset: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size =>
      $value.size?.copyWith.$chain((v) => call(size: v));
  @override
  $R call(
          {VectorDefinition? offset,
          Object? size = $none,
          String? texture,
          int? priority}) =>
      $apply(FieldCopyWithData({
        if (offset != null) #offset: offset,
        if (size != $none) #size: size,
        if (texture != null) #texture: texture,
        if (priority != null) #priority: priority
      }));
  @override
  BackgroundDefinition $make(CopyWithData data) => BackgroundDefinition(
      offset: data.get(#offset, or: $value.offset),
      size: data.get(#size, or: $value.size),
      texture: data.get(#texture, or: $value.texture),
      priority: data.get(#priority, or: $value.priority));

  @override
  BackgroundDefinitionCopyWith<$R2, BackgroundDefinition, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _BackgroundDefinitionCopyWithImpl($value, $cast, t);
}
