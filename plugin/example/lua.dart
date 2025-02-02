import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:setonix_plugin/setonix_plugin.dart';

const LUA_SCRIPT = '''
print("Hello World")
event:schoo(function(_, details)
  details["cancelled"] = true
  print("schoo event")
end)

''';
Future<void> main() async {
  await initPluginSystem();
  final callback = await PluginCallback.default_();
  await callback.changeOnPrint(
    onPrint: (p0) {
      print("SANDBOX: ${p0}");
    },
  );
  final plugin = LuauPlugin(code: LUA_SCRIPT, callback: callback);
  try {
    await plugin.run();
  } catch (e) {
    if (e is AnyhowException) {
      print("Error while evaluating lua script: ${e.message}");
    }
  }
  var result = await plugin.runEvent(
    event: '{"key": "value"}',
    eventType: 'schoo',
    serverEvent: '{"key": "server-value"}',
    target: 0,
  );
  print("cancelled: ${result.serverEvent == null}");
  result = await plugin.runEvent(
    event: '{"key": "value"}',
    eventType: 'another',
    serverEvent: '{"key": "server-value"}',
    target: 0,
  );
  print("cancelled: ${result.serverEvent == null}");
  callback.dispose();
  print('end of main');
  disposePluginSystem();
}
