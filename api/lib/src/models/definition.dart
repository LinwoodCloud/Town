import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';
import 'visual.dart';

part 'definition.mapper.dart';

sealed class GameObjectDefinition {}

@MappableClass()
class FigureDefinition extends GameObjectDefinition
    with FigureDefinitionMappable {
  final FigureBackDefinition back;
  final bool rollable;
  final Map<String, VariationDefinition> variations;

  FigureDefinition({
    this.variations = const {},
    this.rollable = false,
    required this.back,
  });
}

@MappableClass()
class BoardDefinition extends VisualDefinition with BoardDefinitionMappable {
  final VectorDefinition tiles;

  BoardDefinition({
    super.offset,
    super.size,
    required super.texture,
    this.tiles = VectorDefinition.one,
  });
}

@MappableClass()
class VariationDefinition extends VisualDefinition
    with VariationDefinitionMappable {
  final String? category;

  VariationDefinition({
    this.category,
    required super.texture,
    super.offset,
    super.size,
  });
}

@MappableClass()
class FigureBackDefinition extends VisualDefinition
    with FigureBackDefinitionMappable {
  FigureBackDefinition({
    required super.texture,
    super.offset,
    super.size,
  });
}
