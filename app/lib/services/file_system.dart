import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:lw_file_system/lw_file_system.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/api/storage.dart';
import 'package:setonix_api/setonix_api.dart';

enum PackDownloadResult {
  success,
  alreadyExists,
  downloadFailed,
  invalidIdentifier,
  invalidUri;

  bool get isSuccess => this == success || this == alreadyExists;
}

class SetonixFileSystem {
  SetonixData? _corePack;
  final TypedKeyFileSystem<SetonixData> packSystem, templateSystem, worldSystem;
  final TypedKeyFileSystem<DataMetadata> dataInfoSystem;

  static _onDatabaseUpgrade(event) =>
      initStores(event, ['packs', 'templates', 'worlds']);

  SetonixFileSystem({
    SetonixData? corePack,
  })  : _corePack = corePack,
        packSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'packs',
            getDirectory: (storage) async =>
                '${await getSetonixDirectory()}/Packs',
            database: 'setonix.db',
            databaseVersion: 1,
            keySuffix: '.stnx',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: SetonixData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        ),
        dataInfoSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'packs',
            getDirectory: (storage) async =>
                '${await getSetonixDirectory()}/Packs',
            database: 'setonix.db',
            databaseVersion: 1,
            keySuffix: '.json',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onEncode: (data) => utf8.encode(data.toJson()),
          onDecode: (data) =>
              DataMetadataMapper.fromJson(jsonDecode(utf8.decode(data))),
        ),
        templateSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'templates',
            getDirectory: (storage) async =>
                '${await getSetonixDirectory()}/Templates',
            database: 'setonix.db',
            databaseVersion: 1,
            keySuffix: '.stnx',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: SetonixData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        ),
        worldSystem = TypedKeyFileSystem.build(
          FileSystemConfig(
            passwordStorage: SecureStoragePasswordStorage(),
            storeName: 'worlds',
            getDirectory: (storage) async =>
                '${await getSetonixDirectory()}/Worlds',
            database: 'setonix.db',
            databaseVersion: 1,
            keySuffix: '.stnx',
            onDatabaseUpgrade: _onDatabaseUpgrade,
          ),
          onDecode: SetonixData.fromData,
          onEncode: (data) => data.exportAsBytes(),
        );

  Future<SetonixData?> fetchCorePack() async =>
      _corePack ?? (_corePack = await getCorePack());

  Future<List<FileSystemFile<SetonixData>>> getPacks({
    bool fetchCore = true,
    bool force = false,
  }) async {
    final corePack = fetchCore ? await fetchCorePack() : null;
    await packSystem.initialize();
    return [
      ...await packSystem.getFiles(),
      if (corePack != null)
        FileSystemFile(const AssetLocation(path: kCorePackId), data: corePack),
    ];
  }

  Future<SetonixData?> getPack(String packId) =>
      packId == kCorePackId ? fetchCorePack() : packSystem.getFile(packId);

  Future<bool> addPack(Uint8List data, {bool force = false}) async {
    final pack = SetonixData.fromData(data);
    final identifier = createPackIdentifier(data);
    if (!force && await packSystem.hasKey(identifier)) return false;
    await packSystem.updateFile(identifier, pack);
    await dataInfoSystem.updateFile(
        identifier,
        DataMetadata(
          addedAt: DateTime.now(),
          manuallyAdded: true,
        ));
    return true;
  }

  Future<PackDownloadResult> downloadPack(String url, String expectedIdentifier,
      {bool force = false}) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return PackDownloadResult.invalidUri;
    if (!force && await packSystem.hasKey(expectedIdentifier)) {
      return PackDownloadResult.alreadyExists;
    }
    final response = await http.get(uri);
    if (response.statusCode != 200) return PackDownloadResult.downloadFailed;
    final identifier = createPackIdentifier(response.bodyBytes);
    if (identifier != expectedIdentifier) {
      return PackDownloadResult.invalidIdentifier;
    }
    final pack = SetonixData.fromData(response.bodyBytes);
    await packSystem.updateFile(expectedIdentifier, pack);
    await dataInfoSystem.updateFile(
        expectedIdentifier,
        DataMetadata(
          addedAt: DateTime.now(),
          manuallyAdded: false,
        ));
    return PackDownloadResult.success;
  }

  Future<void> updateServerLastUsed(String packId, String serverAddress) async {
    final data = await dataInfoSystem.getFile(packId) ??
        DataMetadata(addedAt: DateTime(0));
    data.serversLastUsed[serverAddress] = DateTime.now();
    await dataInfoSystem.updateFile(packId, data);
  }

  Future<void> updateMultipleServerLastUsed(
      Iterable<String> packIds, String serverAddress) async {
    for (final pack in packIds) {
      await updateServerLastUsed(pack, serverAddress);
    }
  }
}
