import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

class GameAssetManager extends AssetManager {
  String currentLocale;
  final Map<String, SetonixData> _loadedPacks = {};
  final Map<String, TranslationsStore> _loadedTranslations = {};
  final Map<ItemLocation?, Future<Image>> _cachedImages = {};

  final SetonixFileSystem fileSystem;

  GameAssetManager({
    required this.fileSystem,
    this.currentLocale = 'en',
  });

  @override
  Iterable<MapEntry<String, SetonixData>> get packs => _loadedPacks.entries;

  Uint8List? getTexture(String key, String namespace) =>
      getTextureFromLocation(ItemLocation.fromString(key, namespace));

  Uint8List? getTextureFromLocation(ItemLocation location) {
    final pack = _loadedPacks[location.namespace];
    if (pack == null) return null;
    final asset = pack.getTexture(location.id);
    if (asset == null) return null;
    return asset;
  }

  Future<Sprite?> loadSprite(
    String key,
    String namespace, {
    Vector2? srcPosition,
    Vector2? srcSize,
  }) =>
      loadSpriteFromLocation(
        ItemLocation.fromString(key, namespace),
        srcPosition: srcPosition,
        srcSize: srcSize,
      );

  Future<Sprite?> loadSpriteFromLocation(
    ItemLocation location, {
    Vector2? srcPosition,
    Vector2? srcSize,
  }) {
    Future<Image>? image = _cachedImages[location];
    if (image == null) {
      final texture = getTextureFromLocation(location);
      if (texture == null) return Future.value(null);
      image = _cachedImages[location] = decodeImageFromList(texture);
    }
    return image.then((e) => Sprite(
          e,
          srcPosition: srcPosition,
          srcSize: srcSize,
        ));
  }

  Future<Sprite?> loadFigureSprite(ItemLocation location,
      [String? variation]) async {
    final figure = getFigure(location);
    if (figure == null) return null;
    final definition = figure.variations[variation] ?? figure.back;
    return loadSprite(
      definition.texture,
      location.namespace,
      srcPosition: definition.offset.toVector(),
      srcSize: definition.size?.toVector(),
    );
  }

  Future<Sprite?> loadBoardSprite(ItemLocation location,
      [VectorDefinition? tile]) async {
    final board = getBoard(location);
    if (board == null) return null;
    Vector2 offset = board.offset.toVector();
    Vector2? size = board.size?.toVector();
    if (tile != null && size != null) {
      size = size.clone()..divide(board.tiles.toVector());
      offset += size.clone()..multiply(tile.toVector());
    }
    return loadSprite(
      board.texture,
      location.namespace,
      srcPosition: offset,
      srcSize: size,
    );
  }

  @override
  SetonixData? getPack(String key) => _loadedPacks[key];

  Future<void> loadPacks() async {
    final files = await fileSystem.getPacks();
    unloadPacks(
        _loadedPacks.keys.where((e) => !files.any((f) => f.identifier == e)));
    for (final file in files) {
      try {
        final pack = file.load();
        _loadedPacks[file.identifier] = pack;
        _loadedTranslations[file.identifier] =
            pack.getTranslationsStore(getLocale: () => currentLocale);
      } catch (_) {}
    }
  }

  TranslationsStore getTranslations(String key) =>
      _loadedTranslations[key] ??
      TranslationsStore(getLocale: () => currentLocale);

  void unloadPacks(Iterable<String> keys) {
    _loadedTranslations.removeWhere((e, _) => keys.contains(e));
    for (final key in keys) {
      if (_loadedPacks.remove(key) != null) clearImagesFromNamespace(key);
    }
  }

  void clearImagesFromNamespace(String namespace) => _cachedImages
    ..removeWhere((k, v) {
      if (namespace != k?.namespace) return false;
      v.then((e) => e.dispose());
      return true;
    });

  void clearImages() => _cachedImages
    ..forEach((_, v) => v.then((e) => e.dispose()))
    ..clear();

  @override
  bool hasPack(String key) => _loadedPacks.containsKey(key);
}
