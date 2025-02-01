import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';

void main(List<String> args) {
  final port = args.isEmpty ? 80 : int.parse(args.first);
  final staticHandler =
      createStaticHandler('app/build/web', defaultDocument: 'index.html');

  final socketHandler = webSocketHandler((webSocket, _) async {
    final proxied = await WebSocket.connect('ws://localhost:10357');
    webSocket.stream.listen((message) {
      proxied.add(message);
    }, onDone: () {
      proxied.close();
    });
    proxied.listen((message) {
      webSocket.sink.add(message);
    }, onDone: () {
      webSocket.sink.close();
    });
  });

  // Serve /connect requests with the web socket handler.
  // Serve other requests with the static file handler.
  handler(Request request) {
    print(request.url.path);
    if (request.url.path == 'connect') {
      return socketHandler(request);
    } else {
      return staticHandler(request);
    }
  }

  // Serve on every ip
  io.serve(handler, InternetAddress.anyIPv4, port).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}
