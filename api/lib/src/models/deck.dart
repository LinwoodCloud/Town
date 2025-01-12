import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';

part 'deck.mapper.dart';

@MappableClass()
class DeckDefinition with DeckDefinitionMappable {
  final List<FigureDeckDefinition> figures;
  final List<BoardDeckDefinition> boards;

  DeckDefinition({
    this.figures = const [],
    this.boards = const [],
  });
}

@MappableClass()
class FigureDeckDefinition with FigureDeckDefinitionMappable {
  final String name;
  final String? variation;
  final VectorDefinition position;

  FigureDeckDefinition({
    required this.name,
    this.variation,
    this.position = VectorDefinition.zero,
  });
}

@MappableClass()
class BoardDeckDefinition with BoardDeckDefinitionMappable {
  final String name;
  final VectorDefinition position;

  BoardDeckDefinition({
    required this.name,
    this.position = VectorDefinition.zero,
  });
}
