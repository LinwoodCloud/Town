// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'visual.dart';

class VisualDefinitionMapper extends ClassMapperBase<VisualDefinition> {
  VisualDefinitionMapper._();

  static VisualDefinitionMapper? _instance;
  static VisualDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VisualDefinitionMapper._());
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VisualDefinition';

  static String _$texture(VisualDefinition v) => v.texture;
  static const Field<VisualDefinition, String> _f$texture =
      Field('texture', _$texture);
  static VectorDefinition _$offset(VisualDefinition v) => v.offset;
  static const Field<VisualDefinition, VectorDefinition> _f$offset =
      Field('offset', _$offset, opt: true, def: VectorDefinition.zero);
  static VectorDefinition? _$size(VisualDefinition v) => v.size;
  static const Field<VisualDefinition, VectorDefinition> _f$size =
      Field('size', _$size);

  @override
  final MappableFields<VisualDefinition> fields = const {
    #texture: _f$texture,
    #offset: _f$offset,
    #size: _f$size,
  };

  static VisualDefinition _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('VisualDefinition');
  }

  @override
  final Function instantiate = _instantiate;

  static VisualDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VisualDefinition>(map);
  }

  static VisualDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<VisualDefinition>(json);
  }
}

mixin VisualDefinitionMappable {
  String toJson();
  Map<String, dynamic> toMap();
  VisualDefinitionCopyWith<VisualDefinition, VisualDefinition, VisualDefinition>
      get copyWith;
}

abstract class VisualDefinitionCopyWith<$R, $In extends VisualDefinition, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get offset;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get size;
  $R call({String? texture, VectorDefinition? offset, VectorDefinition? size});
  VisualDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}
