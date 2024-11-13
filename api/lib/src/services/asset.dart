import 'package:setonix_api/setonix_api.dart';

const kCorePackId = "core";

abstract class AssetManager {
  SetonixData? getPack(String key);
  bool hasPack(String key);

  Iterable<MapEntry<String, SetonixData>> get packs;

  Map<String, SignatureMetadata> createSignature([Set<String>? packs]) {
    final signature = <String, SignatureMetadata>{};
    for (final entry in this.packs) {
      if (!(packs?.contains(entry.key) ?? true)) continue;
      signature[entry.key] = SignatureMetadata(
        metadata: entry.value.getMetadataOrDefault(),
        id: entry.value.createIdentifier(),
      );
    }
    return signature;
  }

  BoardDefinition? getBoard(ItemLocation location) =>
      getPack(location.namespace)?.getBoard(location.id);

  PackItem<BoardDefinition>? getBoardItem(ItemLocation location) =>
      getPack(location.namespace)
          ?.getBoardItem(location.id, location.namespace);

  FigureDefinition? getFigure(ItemLocation location) =>
      getPack(location.namespace)?.getFigure(location.id);

  PackItem<FigureDefinition>? getFigureItem(ItemLocation location) =>
      getPack(location.namespace)
          ?.getFigureItem(location.id, location.namespace);

  BackgroundDefinition? getBackground(ItemLocation location) =>
      getPack(location.namespace)?.getBackground(location.id);

  PackItem<BackgroundDefinition>? getBackgroundItem(ItemLocation location) =>
      getPack(location.namespace)
          ?.getBackgroundItem(location.id, location.namespace);

  DeckDefinition? getDeck(ItemLocation location) =>
      getPack(location.namespace)?.getDeck(location.id);

  PackItem<DeckDefinition>? getDeckItem(ItemLocation location) =>
      getPack(location.namespace)?.getDeckItem(location.id, location.namespace);
}
