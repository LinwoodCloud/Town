import 'package:networker/networker.dart';
import 'package:qeck/models/message.dart';
import 'package:qeck/services/messenger.dart';

mixin GenericClientMessenger on NetworkMessenger {
  void sendUpdate(NetworkUpdateMessage event) {
    rpc.sendMessage(
        RpcRequest(kNetworkerConnectionIdAny, 'update', event.toMap()));
  }
}

class ClientMessenger extends NetworkMessenger with GenericClientMessenger {
  @override
  final NetworkerClient networker;

  @override
  final RpcNetworkerPlugin rpc = RpcNetworkerPlugin();

  ClientMessenger(this.networker) {
    networker.addPlugin(RawJsonNetworkerPlugin()..addPlugin(rpc));
  }
}
