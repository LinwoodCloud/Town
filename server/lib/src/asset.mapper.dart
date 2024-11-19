// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset.dart';

class ServerDataMetadataMapper extends ClassMapperBase<ServerDataMetadata> {
  ServerDataMetadataMapper._();

  static ServerDataMetadataMapper? _instance;
  static ServerDataMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerDataMetadataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ServerDataMetadata';

  static List<String> _$downloadUrls(ServerDataMetadata v) => v.downloadUrls;
  static const Field<ServerDataMetadata, List<String>> _f$downloadUrls =
      Field('downloadUrls', _$downloadUrls);

  @override
  final MappableFields<ServerDataMetadata> fields = const {
    #downloadUrls: _f$downloadUrls,
  };

  static ServerDataMetadata _instantiate(DecodingData data) {
    return ServerDataMetadata(downloadUrls: data.dec(_f$downloadUrls));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerDataMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerDataMetadata>(map);
  }

  static ServerDataMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<ServerDataMetadata>(json);
  }
}

mixin ServerDataMetadataMappable {
  String toJson() {
    return ServerDataMetadataMapper.ensureInitialized()
        .encodeJson<ServerDataMetadata>(this as ServerDataMetadata);
  }

  Map<String, dynamic> toMap() {
    return ServerDataMetadataMapper.ensureInitialized()
        .encodeMap<ServerDataMetadata>(this as ServerDataMetadata);
  }

  ServerDataMetadataCopyWith<ServerDataMetadata, ServerDataMetadata,
          ServerDataMetadata>
      get copyWith => _ServerDataMetadataCopyWithImpl(
          this as ServerDataMetadata, $identity, $identity);
  @override
  String toString() {
    return ServerDataMetadataMapper.ensureInitialized()
        .stringifyValue(this as ServerDataMetadata);
  }

  @override
  bool operator ==(Object other) {
    return ServerDataMetadataMapper.ensureInitialized()
        .equalsValue(this as ServerDataMetadata, other);
  }

  @override
  int get hashCode {
    return ServerDataMetadataMapper.ensureInitialized()
        .hashValue(this as ServerDataMetadata);
  }
}

extension ServerDataMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerDataMetadata, $Out> {
  ServerDataMetadataCopyWith<$R, ServerDataMetadata, $Out>
      get $asServerDataMetadata =>
          $base.as((v, t, t2) => _ServerDataMetadataCopyWithImpl(v, t, t2));
}

abstract class ServerDataMetadataCopyWith<$R, $In extends ServerDataMetadata,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get downloadUrls;
  $R call({List<String>? downloadUrls});
  ServerDataMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ServerDataMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerDataMetadata, $Out>
    implements ServerDataMetadataCopyWith<$R, ServerDataMetadata, $Out> {
  _ServerDataMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerDataMetadata> $mapper =
      ServerDataMetadataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get downloadUrls => ListCopyWith(
          $value.downloadUrls,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(downloadUrls: v));
  @override
  $R call({List<String>? downloadUrls}) => $apply(FieldCopyWithData(
      {if (downloadUrls != null) #downloadUrls: downloadUrls}));
  @override
  ServerDataMetadata $make(CopyWithData data) => ServerDataMetadata(
      downloadUrls: data.get(#downloadUrls, or: $value.downloadUrls));

  @override
  ServerDataMetadataCopyWith<$R2, ServerDataMetadata, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ServerDataMetadataCopyWithImpl($value, $cast, t);
}
