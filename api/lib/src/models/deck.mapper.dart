// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck.dart';

class DeckDefinitionMapper extends ClassMapperBase<DeckDefinition> {
  DeckDefinitionMapper._();

  static DeckDefinitionMapper? _instance;
  static DeckDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckDefinitionMapper._());
      FigureDeckDefinitionMapper.ensureInitialized();
      BoardDeckDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckDefinition';

  static List<FigureDeckDefinition> _$figures(DeckDefinition v) => v.figures;
  static const Field<DeckDefinition, List<FigureDeckDefinition>> _f$figures =
      Field('figures', _$figures, opt: true, def: const []);
  static List<BoardDeckDefinition> _$boards(DeckDefinition v) => v.boards;
  static const Field<DeckDefinition, List<BoardDeckDefinition>> _f$boards =
      Field('boards', _$boards, opt: true, def: const []);

  @override
  final MappableFields<DeckDefinition> fields = const {
    #figures: _f$figures,
    #boards: _f$boards,
  };

  static DeckDefinition _instantiate(DecodingData data) {
    return DeckDefinition(
        figures: data.dec(_f$figures), boards: data.dec(_f$boards));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckDefinition>(map);
  }

  static DeckDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<DeckDefinition>(json);
  }
}

mixin DeckDefinitionMappable {
  String toJson() {
    return DeckDefinitionMapper.ensureInitialized()
        .encodeJson<DeckDefinition>(this as DeckDefinition);
  }

  Map<String, dynamic> toMap() {
    return DeckDefinitionMapper.ensureInitialized()
        .encodeMap<DeckDefinition>(this as DeckDefinition);
  }

  DeckDefinitionCopyWith<DeckDefinition, DeckDefinition, DeckDefinition>
      get copyWith => _DeckDefinitionCopyWithImpl(
          this as DeckDefinition, $identity, $identity);
  @override
  String toString() {
    return DeckDefinitionMapper.ensureInitialized()
        .stringifyValue(this as DeckDefinition);
  }

  @override
  bool operator ==(Object other) {
    return DeckDefinitionMapper.ensureInitialized()
        .equalsValue(this as DeckDefinition, other);
  }

  @override
  int get hashCode {
    return DeckDefinitionMapper.ensureInitialized()
        .hashValue(this as DeckDefinition);
  }
}

extension DeckDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeckDefinition, $Out> {
  DeckDefinitionCopyWith<$R, DeckDefinition, $Out> get $asDeckDefinition =>
      $base.as((v, t, t2) => _DeckDefinitionCopyWithImpl(v, t, t2));
}

abstract class DeckDefinitionCopyWith<$R, $In extends DeckDefinition, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      FigureDeckDefinition,
      FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition,
          FigureDeckDefinition>> get figures;
  ListCopyWith<
      $R,
      BoardDeckDefinition,
      BoardDeckDefinitionCopyWith<$R, BoardDeckDefinition,
          BoardDeckDefinition>> get boards;
  $R call(
      {List<FigureDeckDefinition>? figures, List<BoardDeckDefinition>? boards});
  DeckDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DeckDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckDefinition, $Out>
    implements DeckDefinitionCopyWith<$R, DeckDefinition, $Out> {
  _DeckDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckDefinition> $mapper =
      DeckDefinitionMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      FigureDeckDefinition,
      FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition,
          FigureDeckDefinition>> get figures => ListCopyWith(
      $value.figures, (v, t) => v.copyWith.$chain(t), (v) => call(figures: v));
  @override
  ListCopyWith<
      $R,
      BoardDeckDefinition,
      BoardDeckDefinitionCopyWith<$R, BoardDeckDefinition,
          BoardDeckDefinition>> get boards => ListCopyWith(
      $value.boards, (v, t) => v.copyWith.$chain(t), (v) => call(boards: v));
  @override
  $R call(
          {List<FigureDeckDefinition>? figures,
          List<BoardDeckDefinition>? boards}) =>
      $apply(FieldCopyWithData({
        if (figures != null) #figures: figures,
        if (boards != null) #boards: boards
      }));
  @override
  DeckDefinition $make(CopyWithData data) => DeckDefinition(
      figures: data.get(#figures, or: $value.figures),
      boards: data.get(#boards, or: $value.boards));

  @override
  DeckDefinitionCopyWith<$R2, DeckDefinition, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckDefinitionCopyWithImpl($value, $cast, t);
}

class FigureDeckDefinitionMapper extends ClassMapperBase<FigureDeckDefinition> {
  FigureDeckDefinitionMapper._();

  static FigureDeckDefinitionMapper? _instance;
  static FigureDeckDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FigureDeckDefinitionMapper._());
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FigureDeckDefinition';

  static String _$name(FigureDeckDefinition v) => v.name;
  static const Field<FigureDeckDefinition, String> _f$name =
      Field('name', _$name);
  static String? _$variation(FigureDeckDefinition v) => v.variation;
  static const Field<FigureDeckDefinition, String> _f$variation =
      Field('variation', _$variation, opt: true);
  static VectorDefinition _$position(FigureDeckDefinition v) => v.position;
  static const Field<FigureDeckDefinition, VectorDefinition> _f$position =
      Field('position', _$position, opt: true, def: VectorDefinition.zero);

  @override
  final MappableFields<FigureDeckDefinition> fields = const {
    #name: _f$name,
    #variation: _f$variation,
    #position: _f$position,
  };

  static FigureDeckDefinition _instantiate(DecodingData data) {
    return FigureDeckDefinition(
        name: data.dec(_f$name),
        variation: data.dec(_f$variation),
        position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static FigureDeckDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FigureDeckDefinition>(map);
  }

  static FigureDeckDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<FigureDeckDefinition>(json);
  }
}

mixin FigureDeckDefinitionMappable {
  String toJson() {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .encodeJson<FigureDeckDefinition>(this as FigureDeckDefinition);
  }

  Map<String, dynamic> toMap() {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .encodeMap<FigureDeckDefinition>(this as FigureDeckDefinition);
  }

  FigureDeckDefinitionCopyWith<FigureDeckDefinition, FigureDeckDefinition,
          FigureDeckDefinition>
      get copyWith => _FigureDeckDefinitionCopyWithImpl(
          this as FigureDeckDefinition, $identity, $identity);
  @override
  String toString() {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .stringifyValue(this as FigureDeckDefinition);
  }

  @override
  bool operator ==(Object other) {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .equalsValue(this as FigureDeckDefinition, other);
  }

  @override
  int get hashCode {
    return FigureDeckDefinitionMapper.ensureInitialized()
        .hashValue(this as FigureDeckDefinition);
  }
}

extension FigureDeckDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FigureDeckDefinition, $Out> {
  FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition, $Out>
      get $asFigureDeckDefinition =>
          $base.as((v, t, t2) => _FigureDeckDefinitionCopyWithImpl(v, t, t2));
}

abstract class FigureDeckDefinitionCopyWith<
    $R,
    $In extends FigureDeckDefinition,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get position;
  $R call({String? name, String? variation, VectorDefinition? position});
  FigureDeckDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FigureDeckDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FigureDeckDefinition, $Out>
    implements FigureDeckDefinitionCopyWith<$R, FigureDeckDefinition, $Out> {
  _FigureDeckDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FigureDeckDefinition> $mapper =
      FigureDeckDefinitionMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>
      get position => $value.position.copyWith.$chain((v) => call(position: v));
  @override
  $R call(
          {String? name,
          Object? variation = $none,
          VectorDefinition? position}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (variation != $none) #variation: variation,
        if (position != null) #position: position
      }));
  @override
  FigureDeckDefinition $make(CopyWithData data) => FigureDeckDefinition(
      name: data.get(#name, or: $value.name),
      variation: data.get(#variation, or: $value.variation),
      position: data.get(#position, or: $value.position));

  @override
  FigureDeckDefinitionCopyWith<$R2, FigureDeckDefinition, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FigureDeckDefinitionCopyWithImpl($value, $cast, t);
}

class BoardDeckDefinitionMapper extends ClassMapperBase<BoardDeckDefinition> {
  BoardDeckDefinitionMapper._();

  static BoardDeckDefinitionMapper? _instance;
  static BoardDeckDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardDeckDefinitionMapper._());
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardDeckDefinition';

  static String _$name(BoardDeckDefinition v) => v.name;
  static const Field<BoardDeckDefinition, String> _f$name =
      Field('name', _$name);
  static VectorDefinition _$position(BoardDeckDefinition v) => v.position;
  static const Field<BoardDeckDefinition, VectorDefinition> _f$position =
      Field('position', _$position, opt: true, def: VectorDefinition.zero);

  @override
  final MappableFields<BoardDeckDefinition> fields = const {
    #name: _f$name,
    #position: _f$position,
  };

  static BoardDeckDefinition _instantiate(DecodingData data) {
    return BoardDeckDefinition(
        name: data.dec(_f$name), position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardDeckDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardDeckDefinition>(map);
  }

  static BoardDeckDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<BoardDeckDefinition>(json);
  }
}

mixin BoardDeckDefinitionMappable {
  String toJson() {
    return BoardDeckDefinitionMapper.ensureInitialized()
        .encodeJson<BoardDeckDefinition>(this as BoardDeckDefinition);
  }

  Map<String, dynamic> toMap() {
    return BoardDeckDefinitionMapper.ensureInitialized()
        .encodeMap<BoardDeckDefinition>(this as BoardDeckDefinition);
  }

  BoardDeckDefinitionCopyWith<BoardDeckDefinition, BoardDeckDefinition,
          BoardDeckDefinition>
      get copyWith => _BoardDeckDefinitionCopyWithImpl(
          this as BoardDeckDefinition, $identity, $identity);
  @override
  String toString() {
    return BoardDeckDefinitionMapper.ensureInitialized()
        .stringifyValue(this as BoardDeckDefinition);
  }

  @override
  bool operator ==(Object other) {
    return BoardDeckDefinitionMapper.ensureInitialized()
        .equalsValue(this as BoardDeckDefinition, other);
  }

  @override
  int get hashCode {
    return BoardDeckDefinitionMapper.ensureInitialized()
        .hashValue(this as BoardDeckDefinition);
  }
}

extension BoardDeckDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardDeckDefinition, $Out> {
  BoardDeckDefinitionCopyWith<$R, BoardDeckDefinition, $Out>
      get $asBoardDeckDefinition =>
          $base.as((v, t, t2) => _BoardDeckDefinitionCopyWithImpl(v, t, t2));
}

abstract class BoardDeckDefinitionCopyWith<$R, $In extends BoardDeckDefinition,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get position;
  $R call({String? name, VectorDefinition? position});
  BoardDeckDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoardDeckDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardDeckDefinition, $Out>
    implements BoardDeckDefinitionCopyWith<$R, BoardDeckDefinition, $Out> {
  _BoardDeckDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardDeckDefinition> $mapper =
      BoardDeckDefinitionMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>
      get position => $value.position.copyWith.$chain((v) => call(position: v));
  @override
  $R call({String? name, VectorDefinition? position}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (position != null) #position: position
      }));
  @override
  BoardDeckDefinition $make(CopyWithData data) => BoardDeckDefinition(
      name: data.get(#name, or: $value.name),
      position: data.get(#position, or: $value.position));

  @override
  BoardDeckDefinitionCopyWith<$R2, BoardDeckDefinition, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _BoardDeckDefinitionCopyWithImpl($value, $cast, t);
}
