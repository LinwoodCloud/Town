import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';

class PacksProgram extends ConsoleProgram {
  final SetonixServer server;

  PacksProgram(this.server);

  @override
  String getDescription() => "Show all loaded packs";

  @override
  void run(String label, List<String> args) {
    print("-----");
    final packs = server.assetManager.packs.toList();
    print("Loaded ${packs.length} pack(s).");
    for (final pack in packs) {
      final checksum = pack.value.createIdentifier();
      if (pack.key == kCorePackId) {
        print("| Core pack ($checksum)");
      } else {
        print("> ${pack.key} ($checksum)");
      }
    }
    print("-----");
  }
}
