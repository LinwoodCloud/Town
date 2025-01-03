import 'package:dart_mappable/dart_mappable.dart';

import 'vector.dart';

part 'visual.mapper.dart';

@MappableClass()
abstract class VisualDefinition with VisualDefinitionMappable {
  final String texture;
  final VectorDefinition offset;
  final VectorDefinition? size;

  VisualDefinition(
      {required this.texture,
      this.offset = VectorDefinition.zero,
      required this.size});
}
