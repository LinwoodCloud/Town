// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'definition.dart';

class FigureDefinitionMapper extends ClassMapperBase<FigureDefinition> {
  FigureDefinitionMapper._();

  static FigureDefinitionMapper? _instance;
  static FigureDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FigureDefinitionMapper._());
      VariationDefinitionMapper.ensureInitialized();
      FigureBackDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FigureDefinition';

  static Map<String, VariationDefinition> _$variations(FigureDefinition v) =>
      v.variations;
  static const Field<FigureDefinition, Map<String, VariationDefinition>>
      _f$variations =
      Field('variations', _$variations, opt: true, def: const {});
  static bool _$rollable(FigureDefinition v) => v.rollable;
  static const Field<FigureDefinition, bool> _f$rollable =
      Field('rollable', _$rollable, opt: true, def: false);
  static FigureBackDefinition _$back(FigureDefinition v) => v.back;
  static const Field<FigureDefinition, FigureBackDefinition> _f$back =
      Field('back', _$back);

  @override
  final MappableFields<FigureDefinition> fields = const {
    #variations: _f$variations,
    #rollable: _f$rollable,
    #back: _f$back,
  };

  static FigureDefinition _instantiate(DecodingData data) {
    return FigureDefinition(
        variations: data.dec(_f$variations),
        rollable: data.dec(_f$rollable),
        back: data.dec(_f$back));
  }

  @override
  final Function instantiate = _instantiate;

  static FigureDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FigureDefinition>(map);
  }

  static FigureDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<FigureDefinition>(json);
  }
}

mixin FigureDefinitionMappable {
  String toJson() {
    return FigureDefinitionMapper.ensureInitialized()
        .encodeJson<FigureDefinition>(this as FigureDefinition);
  }

  Map<String, dynamic> toMap() {
    return FigureDefinitionMapper.ensureInitialized()
        .encodeMap<FigureDefinition>(this as FigureDefinition);
  }

  FigureDefinitionCopyWith<FigureDefinition, FigureDefinition, FigureDefinition>
      get copyWith => _FigureDefinitionCopyWithImpl(
          this as FigureDefinition, $identity, $identity);
  @override
  String toString() {
    return FigureDefinitionMapper.ensureInitialized()
        .stringifyValue(this as FigureDefinition);
  }

  @override
  bool operator ==(Object other) {
    return FigureDefinitionMapper.ensureInitialized()
        .equalsValue(this as FigureDefinition, other);
  }

  @override
  int get hashCode {
    return FigureDefinitionMapper.ensureInitialized()
        .hashValue(this as FigureDefinition);
  }
}

extension FigureDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FigureDefinition, $Out> {
  FigureDefinitionCopyWith<$R, FigureDefinition, $Out>
      get $asFigureDefinition =>
          $base.as((v, t, t2) => _FigureDefinitionCopyWithImpl(v, t, t2));
}

abstract class FigureDefinitionCopyWith<$R, $In extends FigureDefinition, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
      $R,
      String,
      VariationDefinition,
      VariationDefinitionCopyWith<$R, VariationDefinition,
          VariationDefinition>> get variations;
  FigureBackDefinitionCopyWith<$R, FigureBackDefinition, FigureBackDefinition>
      get back;
  $R call(
      {Map<String, VariationDefinition>? variations,
      bool? rollable,
      FigureBackDefinition? back});
  FigureDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FigureDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FigureDefinition, $Out>
    implements FigureDefinitionCopyWith<$R, FigureDefinition, $Out> {
  _FigureDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FigureDefinition> $mapper =
      FigureDefinitionMapper.ensureInitialized();
  @override
  MapCopyWith<
      $R,
      String,
      VariationDefinition,
      VariationDefinitionCopyWith<$R, VariationDefinition,
          VariationDefinition>> get variations => MapCopyWith($value.variations,
      (v, t) => v.copyWith.$chain(t), (v) => call(variations: v));
  @override
  FigureBackDefinitionCopyWith<$R, FigureBackDefinition, FigureBackDefinition>
      get back => $value.back.copyWith.$chain((v) => call(back: v));
  @override
  $R call(
          {Map<String, VariationDefinition>? variations,
          bool? rollable,
          FigureBackDefinition? back}) =>
      $apply(FieldCopyWithData({
        if (variations != null) #variations: variations,
        if (rollable != null) #rollable: rollable,
        if (back != null) #back: back
      }));
  @override
  FigureDefinition $make(CopyWithData data) => FigureDefinition(
      variations: data.get(#variations, or: $value.variations),
      rollable: data.get(#rollable, or: $value.rollable),
      back: data.get(#back, or: $value.back));

  @override
  FigureDefinitionCopyWith<$R2, FigureDefinition, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FigureDefinitionCopyWithImpl($value, $cast, t);
}

class VariationDefinitionMapper extends ClassMapperBase<VariationDefinition> {
  VariationDefinitionMapper._();

  static VariationDefinitionMapper? _instance;
  static VariationDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VariationDefinitionMapper._());
      VisualDefinitionMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VariationDefinition';

  static String? _$category(VariationDefinition v) => v.category;
  static const Field<VariationDefinition, String> _f$category =
      Field('category', _$category, opt: true);
  static String _$texture(VariationDefinition v) => v.texture;
  static const Field<VariationDefinition, String> _f$texture =
      Field('texture', _$texture);
  static VectorDefinition _$offset(VariationDefinition v) => v.offset;
  static const Field<VariationDefinition, VectorDefinition> _f$offset =
      Field('offset', _$offset, opt: true, def: VectorDefinition.zero);
  static VectorDefinition? _$size(VariationDefinition v) => v.size;
  static const Field<VariationDefinition, VectorDefinition> _f$size =
      Field('size', _$size, opt: true);

  @override
  final MappableFields<VariationDefinition> fields = const {
    #category: _f$category,
    #texture: _f$texture,
    #offset: _f$offset,
    #size: _f$size,
  };

  static VariationDefinition _instantiate(DecodingData data) {
    return VariationDefinition(
        category: data.dec(_f$category),
        texture: data.dec(_f$texture),
        offset: data.dec(_f$offset),
        size: data.dec(_f$size));
  }

  @override
  final Function instantiate = _instantiate;

  static VariationDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VariationDefinition>(map);
  }

  static VariationDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<VariationDefinition>(json);
  }
}

mixin VariationDefinitionMappable {
  String toJson() {
    return VariationDefinitionMapper.ensureInitialized()
        .encodeJson<VariationDefinition>(this as VariationDefinition);
  }

  Map<String, dynamic> toMap() {
    return VariationDefinitionMapper.ensureInitialized()
        .encodeMap<VariationDefinition>(this as VariationDefinition);
  }

  VariationDefinitionCopyWith<VariationDefinition, VariationDefinition,
          VariationDefinition>
      get copyWith => _VariationDefinitionCopyWithImpl(
          this as VariationDefinition, $identity, $identity);
  @override
  String toString() {
    return VariationDefinitionMapper.ensureInitialized()
        .stringifyValue(this as VariationDefinition);
  }

  @override
  bool operator ==(Object other) {
    return VariationDefinitionMapper.ensureInitialized()
        .equalsValue(this as VariationDefinition, other);
  }

  @override
  int get hashCode {
    return VariationDefinitionMapper.ensureInitialized()
        .hashValue(this as VariationDefinition);
  }
}

extension VariationDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VariationDefinition, $Out> {
  VariationDefinitionCopyWith<$R, VariationDefinition, $Out>
      get $asVariationDefinition =>
          $base.as((v, t, t2) => _VariationDefinitionCopyWithImpl(v, t, t2));
}

abstract class VariationDefinitionCopyWith<$R, $In extends VariationDefinition,
    $Out> implements VisualDefinitionCopyWith<$R, $In, $Out> {
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset;
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size;
  @override
  $R call(
      {String? category,
      String? texture,
      VectorDefinition? offset,
      VectorDefinition? size});
  VariationDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _VariationDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VariationDefinition, $Out>
    implements VariationDefinitionCopyWith<$R, VariationDefinition, $Out> {
  _VariationDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VariationDefinition> $mapper =
      VariationDefinitionMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset =>
      $value.offset.copyWith.$chain((v) => call(offset: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size =>
      $value.size?.copyWith.$chain((v) => call(size: v));
  @override
  $R call(
          {Object? category = $none,
          String? texture,
          VectorDefinition? offset,
          Object? size = $none}) =>
      $apply(FieldCopyWithData({
        if (category != $none) #category: category,
        if (texture != null) #texture: texture,
        if (offset != null) #offset: offset,
        if (size != $none) #size: size
      }));
  @override
  VariationDefinition $make(CopyWithData data) => VariationDefinition(
      category: data.get(#category, or: $value.category),
      texture: data.get(#texture, or: $value.texture),
      offset: data.get(#offset, or: $value.offset),
      size: data.get(#size, or: $value.size));

  @override
  VariationDefinitionCopyWith<$R2, VariationDefinition, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _VariationDefinitionCopyWithImpl($value, $cast, t);
}

class FigureBackDefinitionMapper extends ClassMapperBase<FigureBackDefinition> {
  FigureBackDefinitionMapper._();

  static FigureBackDefinitionMapper? _instance;
  static FigureBackDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FigureBackDefinitionMapper._());
      VisualDefinitionMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FigureBackDefinition';

  static String _$texture(FigureBackDefinition v) => v.texture;
  static const Field<FigureBackDefinition, String> _f$texture =
      Field('texture', _$texture);
  static VectorDefinition _$offset(FigureBackDefinition v) => v.offset;
  static const Field<FigureBackDefinition, VectorDefinition> _f$offset =
      Field('offset', _$offset, opt: true, def: VectorDefinition.zero);
  static VectorDefinition? _$size(FigureBackDefinition v) => v.size;
  static const Field<FigureBackDefinition, VectorDefinition> _f$size =
      Field('size', _$size, opt: true);

  @override
  final MappableFields<FigureBackDefinition> fields = const {
    #texture: _f$texture,
    #offset: _f$offset,
    #size: _f$size,
  };

  static FigureBackDefinition _instantiate(DecodingData data) {
    return FigureBackDefinition(
        texture: data.dec(_f$texture),
        offset: data.dec(_f$offset),
        size: data.dec(_f$size));
  }

  @override
  final Function instantiate = _instantiate;

  static FigureBackDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FigureBackDefinition>(map);
  }

  static FigureBackDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<FigureBackDefinition>(json);
  }
}

mixin FigureBackDefinitionMappable {
  String toJson() {
    return FigureBackDefinitionMapper.ensureInitialized()
        .encodeJson<FigureBackDefinition>(this as FigureBackDefinition);
  }

  Map<String, dynamic> toMap() {
    return FigureBackDefinitionMapper.ensureInitialized()
        .encodeMap<FigureBackDefinition>(this as FigureBackDefinition);
  }

  FigureBackDefinitionCopyWith<FigureBackDefinition, FigureBackDefinition,
          FigureBackDefinition>
      get copyWith => _FigureBackDefinitionCopyWithImpl(
          this as FigureBackDefinition, $identity, $identity);
  @override
  String toString() {
    return FigureBackDefinitionMapper.ensureInitialized()
        .stringifyValue(this as FigureBackDefinition);
  }

  @override
  bool operator ==(Object other) {
    return FigureBackDefinitionMapper.ensureInitialized()
        .equalsValue(this as FigureBackDefinition, other);
  }

  @override
  int get hashCode {
    return FigureBackDefinitionMapper.ensureInitialized()
        .hashValue(this as FigureBackDefinition);
  }
}

extension FigureBackDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FigureBackDefinition, $Out> {
  FigureBackDefinitionCopyWith<$R, FigureBackDefinition, $Out>
      get $asFigureBackDefinition =>
          $base.as((v, t, t2) => _FigureBackDefinitionCopyWithImpl(v, t, t2));
}

abstract class FigureBackDefinitionCopyWith<
    $R,
    $In extends FigureBackDefinition,
    $Out> implements VisualDefinitionCopyWith<$R, $In, $Out> {
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset;
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size;
  @override
  $R call({String? texture, VectorDefinition? offset, VectorDefinition? size});
  FigureBackDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FigureBackDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FigureBackDefinition, $Out>
    implements FigureBackDefinitionCopyWith<$R, FigureBackDefinition, $Out> {
  _FigureBackDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FigureBackDefinition> $mapper =
      FigureBackDefinitionMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset =>
      $value.offset.copyWith.$chain((v) => call(offset: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size =>
      $value.size?.copyWith.$chain((v) => call(size: v));
  @override
  $R call({String? texture, VectorDefinition? offset, Object? size = $none}) =>
      $apply(FieldCopyWithData({
        if (texture != null) #texture: texture,
        if (offset != null) #offset: offset,
        if (size != $none) #size: size
      }));
  @override
  FigureBackDefinition $make(CopyWithData data) => FigureBackDefinition(
      texture: data.get(#texture, or: $value.texture),
      offset: data.get(#offset, or: $value.offset),
      size: data.get(#size, or: $value.size));

  @override
  FigureBackDefinitionCopyWith<$R2, FigureBackDefinition, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FigureBackDefinitionCopyWithImpl($value, $cast, t);
}

class BoardDefinitionMapper extends ClassMapperBase<BoardDefinition> {
  BoardDefinitionMapper._();

  static BoardDefinitionMapper? _instance;
  static BoardDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardDefinitionMapper._());
      VisualDefinitionMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardDefinition';

  static VectorDefinition _$offset(BoardDefinition v) => v.offset;
  static const Field<BoardDefinition, VectorDefinition> _f$offset =
      Field('offset', _$offset, opt: true, def: VectorDefinition.zero);
  static VectorDefinition? _$size(BoardDefinition v) => v.size;
  static const Field<BoardDefinition, VectorDefinition> _f$size =
      Field('size', _$size, opt: true);
  static String _$texture(BoardDefinition v) => v.texture;
  static const Field<BoardDefinition, String> _f$texture =
      Field('texture', _$texture);
  static VectorDefinition _$tiles(BoardDefinition v) => v.tiles;
  static const Field<BoardDefinition, VectorDefinition> _f$tiles =
      Field('tiles', _$tiles, opt: true, def: VectorDefinition.one);

  @override
  final MappableFields<BoardDefinition> fields = const {
    #offset: _f$offset,
    #size: _f$size,
    #texture: _f$texture,
    #tiles: _f$tiles,
  };

  static BoardDefinition _instantiate(DecodingData data) {
    return BoardDefinition(
        offset: data.dec(_f$offset),
        size: data.dec(_f$size),
        texture: data.dec(_f$texture),
        tiles: data.dec(_f$tiles));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardDefinition>(map);
  }

  static BoardDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<BoardDefinition>(json);
  }
}

mixin BoardDefinitionMappable {
  String toJson() {
    return BoardDefinitionMapper.ensureInitialized()
        .encodeJson<BoardDefinition>(this as BoardDefinition);
  }

  Map<String, dynamic> toMap() {
    return BoardDefinitionMapper.ensureInitialized()
        .encodeMap<BoardDefinition>(this as BoardDefinition);
  }

  BoardDefinitionCopyWith<BoardDefinition, BoardDefinition, BoardDefinition>
      get copyWith => _BoardDefinitionCopyWithImpl(
          this as BoardDefinition, $identity, $identity);
  @override
  String toString() {
    return BoardDefinitionMapper.ensureInitialized()
        .stringifyValue(this as BoardDefinition);
  }

  @override
  bool operator ==(Object other) {
    return BoardDefinitionMapper.ensureInitialized()
        .equalsValue(this as BoardDefinition, other);
  }

  @override
  int get hashCode {
    return BoardDefinitionMapper.ensureInitialized()
        .hashValue(this as BoardDefinition);
  }
}

extension BoardDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardDefinition, $Out> {
  BoardDefinitionCopyWith<$R, BoardDefinition, $Out> get $asBoardDefinition =>
      $base.as((v, t, t2) => _BoardDefinitionCopyWithImpl(v, t, t2));
}

abstract class BoardDefinitionCopyWith<$R, $In extends BoardDefinition, $Out>
    implements VisualDefinitionCopyWith<$R, $In, $Out> {
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset;
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get tiles;
  @override
  $R call(
      {VectorDefinition? offset,
      VectorDefinition? size,
      String? texture,
      VectorDefinition? tiles});
  BoardDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardDefinition, $Out>
    implements BoardDefinitionCopyWith<$R, BoardDefinition, $Out> {
  _BoardDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardDefinition> $mapper =
      BoardDefinitionMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset =>
      $value.offset.copyWith.$chain((v) => call(offset: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size =>
      $value.size?.copyWith.$chain((v) => call(size: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get tiles =>
      $value.tiles.copyWith.$chain((v) => call(tiles: v));
  @override
  $R call(
          {VectorDefinition? offset,
          Object? size = $none,
          String? texture,
          VectorDefinition? tiles}) =>
      $apply(FieldCopyWithData({
        if (offset != null) #offset: offset,
        if (size != $none) #size: size,
        if (texture != null) #texture: texture,
        if (tiles != null) #tiles: tiles
      }));
  @override
  BoardDefinition $make(CopyWithData data) => BoardDefinition(
      offset: data.get(#offset, or: $value.offset),
      size: data.get(#size, or: $value.size),
      texture: data.get(#texture, or: $value.texture),
      tiles: data.get(#tiles, or: $value.tiles));

  @override
  BoardDefinitionCopyWith<$R2, BoardDefinition, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoardDefinitionCopyWithImpl($value, $cast, t);
}
