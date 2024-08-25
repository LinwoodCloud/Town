import 'package:dart_mappable/dart_mappable.dart';

part 'meta.mapper.dart';

@MappableEnum()
enum FileType {
  pack,
  game,
  template,
}

@MappableClass()
final class FileMetadata with FileMetadataMappable {
  final FileType type;
  final String namespace;
  final String name;
  final String description;
  final String author;
  final String version;
  final Set<String> dependencies;

  const FileMetadata({
    this.type = FileType.pack,
    this.namespace = '',
    this.name = '',
    this.description = '',
    this.author = '',
    this.version = '',
    this.dependencies = const {},
  });
}