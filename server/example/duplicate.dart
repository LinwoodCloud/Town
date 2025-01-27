import 'package:setonix_server/setonix_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments, onLoad);
}

Future<void> onLoad(SetonixServer server) async {
  print("on load was called");
  // Add your custom code here
  bool toggleCancel = false;
  // Put the event you want to listen to in the brackets
  server.eventSystem.on<ObjectsMoved>((e) {
    print("Listener was called, cancel: $toggleCancel");
    // Cancel the event every second time and duplicate the objects instead
    if (toggleCancel) {
      final event = e.clientEvent;
      final table = server.state.getTableOrDefault(event.table);
      final cell = table.getCell(event.from);
      final objects = <GameObject>[];
      for (final index in event.objects) {
        final object = cell.objects[index];
        objects.add(object);
      }
      // Send the event to all clients
      server
          .sendEvent(ObjectsSpawned(e.clientEvent.table, {event.to: objects}));
      // Cancel the event
      e.cancel();
    }
    toggleCancel = !toggleCancel;
  });
}
