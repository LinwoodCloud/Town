import 'package:setonix_plugin/setonix_plugin.dart';

const LUA_SCRIPT = '''
print("Hello World")
onEvent("schoo", function(_, details)
  details["cancelled"] = true
end)
onEvent("another", function(_, details)
  print("another event")
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
  var result = await eventSystem.runEvent(
    event: '{"key": "value"}',
    eventType: 'schoo',
    serverEvent: '{"key": "server-value"}',
    target: 0,
  );
  print("cancelled: ${result.cancelled}");
  result = await eventSystem.runEvent(
    event: '{"key": "value"}',
    eventType: 'another',
    serverEvent: '{"key": "server-value"}',
    target: 0,
  );
  print("cancelled: ${result.cancelled}");
  callback.dispose();
  print('end of main');
  disposePluginSystem();
}
