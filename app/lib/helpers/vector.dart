import 'dart:ui';

import 'package:flame/components.dart';
import 'package:setonix_api/setonix_api.dart';

extension VectorToDefinition on Vector2 {
  VectorDefinition toDefinition() => VectorDefinition(x.round(), y.round());
}

extension OffsetToDefinition on Offset {
  VectorDefinition toDefinition() => VectorDefinition(dx.round(), dy.round());
}

extension DefinitionToVector on VectorDefinition {
  Vector2 toVector() => Vector2(x.toDouble(), y.toDouble());
  Offset toOffset() => Offset(x.toDouble(), y.toDouble());
}
