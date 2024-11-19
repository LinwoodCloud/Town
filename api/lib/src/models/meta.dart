import 'package:dart_mappable/dart_mappable.dart';

part 'meta.mapper.dart';

const kFileVersion = 0;

@MappableEnum()
enum FileType {
  pack,
  game,
  template,
}

@MappableClass()
final class FileMetadata with FileMetadataMappable {
  final FileType type;
  final String id;
  final String name;
  final String description;
  final String author;
  final String version;
  final Set<String> dependencies;
  final int fileVersion;

  const FileMetadata({
    this.type = FileType.pack,
    this.id = '',
    this.name = '',
    this.description = '',
    this.author = '',
    this.version = '',
    this.dependencies = const {},
    this.fileVersion = kFileVersion,
  });
}

@MappableClass()
final class SignatureMetadata with SignatureMetadataMappable {
  final String id;
  final FileMetadata metadata;
  final List<String> downloadUrls;

  SignatureMetadata({
    required this.id,
    required this.metadata,
    this.downloadUrls = const [],
  });

  bool supports(SignatureMetadata other) {
    return id == other.id;
  }
}
