import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';
import 'visual.dart';

part 'background.mapper.dart';

@MappableClass()
class BackgroundDefinition extends VisualDefinition
    with BackgroundDefinitionMappable {
  final int priority;

  BackgroundDefinition({
    super.offset,
    super.size,
    required super.texture,
    this.priority = 0,
  });
}
