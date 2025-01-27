import 'package:setonix_plugin/setonix_plugin.dart';

Future<void> main() async {
  await initPluginSystem();
  final callback = await PluginCallback.default_();
  await callback.changeOnPrint(
    onPrint: (p0) {
      print("printed from sandbox ${p0}");
    },
  );
  final luaPlugin = await LuauPlugin(code: '''
    print("Hello, World!")
  ''', callback: callback);
  await luaPlugin.run();
}
