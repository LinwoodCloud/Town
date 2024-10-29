import 'package:dart_mappable/dart_mappable.dart';
import '../services/asset.dart';
import 'vector.dart';

part 'table.mapper.dart';

@MappableClass(
    includeCustomMappers: [IgnoreForEquality()],
    generateMethods: GenerateMethods.all &
        ~GenerateMethods.equals &
        ~GenerateMethods.stringify)
class IgnoreEqualityBox<T> with IgnoreEqualityBoxMappable<T> {
  final T content;

  const IgnoreEqualityBox(this.content);
}

class IgnoreForEquality extends SimpleMapper1<IgnoreEqualityBox> {
  const IgnoreForEquality();
  @override
  // use the type parameter [T] in the return type [GenericBox<T>]
  IgnoreEqualityBox<T> decode<T>(dynamic value) {
    // use the type parameter [T] in your decoding logic
    T content = MapperContainer.globals.fromValue<T>(value);
    return IgnoreEqualityBox<T>(content);
  }

  @override
  // use the type parameter [T] in the parameter type [GenericBox<T>]
  dynamic encode<T>(IgnoreEqualityBox<T> self) {
    // use the type parameter [T] in your encoding logic
    return MapperContainer.globals.toValue<T>(self.content);
  }

  // In case of generic types, we also must specify a type factory. This is a special type of
  // function used internally to construct generic instances of your type.
  // Specify any type arguments in alignment to the decode/encode functions.
  @override
  Function get typeFactory => <T>(f) => f<IgnoreEqualityBox<T>>();

  @override
  bool equals(value, other, MappingContext context) => value == other;

  @override
  int hash(value, MappingContext context) => value.hashCode;

  @override
  String stringify(value, MappingContext context) => value.toString();
}

@MappableClass()
class GameTable with GameTableMappable {
  @MappableField(key: "cells")
  final IgnoreEqualityBox<Map<VectorDefinition, TableCell>> cellsBox;
  final ItemLocation? background;

  const GameTable({
    this.cellsBox = const IgnoreEqualityBox({}),
    this.background,
  });

  Map<VectorDefinition, TableCell> get cells => cellsBox.content;

  TableCell getCell(VectorDefinition position) =>
      cells[position] ?? TableCell();
}

@MappableClass()
class GlobalVectorDefinition with GlobalVectorDefinitionMappable {
  final String table;
  final VectorDefinition position;

  GlobalVectorDefinition(
    this.table,
    int x,
    int y,
  ) : position = VectorDefinition(x, y);

  GlobalVectorDefinition.fromLocal(this.table, this.position);

  int get x => position.x;
  int get y => position.y;
}

@MappableClass()
class GameSeat with GameSeatMappable {
  final int? color;

  GameSeat({
    this.color,
  });
}

@MappableClass()
class TableCell with TableCellMappable {
  final List<GameObject> objects;
  final List<BoardTile> tiles;

  TableCell({
    this.objects = const [],
    this.tiles = const [],
  });

  bool get isEmpty => objects.isEmpty && tiles.isEmpty;
}

@MappableClass()
class GameObject with GameObjectMappable {
  final ItemLocation asset;
  final String? variation;
  final bool hidden;

  GameObject(
    this.asset, {
    this.variation,
    this.hidden = false,
  });
}

@MappableClass()
class BoardTile with BoardTileMappable {
  final ItemLocation asset;
  final VectorDefinition tile;

  BoardTile(this.asset, this.tile);
}

@MappableClass()
class ItemLocation with ItemLocationMappable {
  final String namespace, id;

  ItemLocation(this.namespace, this.id);
  factory ItemLocation.fromString(String location, [String? namespace]) {
    namespace ??= kCorePackId;
    final splitted = location.split(':');
    if (splitted.length < 2) {
      return ItemLocation(namespace, splitted[0]);
    }
    return ItemLocation(splitted[0], splitted[1]);
  }

  @override
  String toString() => namespace.isEmpty ? id : '$namespace:$id';
}
