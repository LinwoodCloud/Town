import 'package:setonix_plugin/setonix_plugin.dart';

const LUA_SCRIPT = '''
print("Hello World")
onEvent("join", function(event)
  print("Player joined: " .. event)
end)
''';
Future<void> main() async {
  await initPluginSystem();
  final callback = await PluginCallback.default_();
  await callback.changeOnPrint(
    onPrint: (p0) {
      print("printed from sandbox ${p0}");
    },
  );
  final plugin = LuauPlugin(code: LUA_SCRIPT, callback: callback);
  await plugin.run();
  final eventSystem = plugin.eventSystem();
  await eventSystem.runJoin(name: "Alice");
  callback.dispose();
  print('end of main');
  disposePluginSystem();
}
