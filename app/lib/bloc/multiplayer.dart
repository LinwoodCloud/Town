import 'dart:async';
import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix_api/setonix_api.dart';

part 'multiplayer.mapper.dart';

@MappableClass()
sealed class MultiplayerState with MultiplayerStateMappable {
  const MultiplayerState();

  bool get isConnected => this is MultiplayerConnectedState;
  bool get isClient => false;
  bool get isServer => false;
}

@MappableClass()
final class MultiplayerDisabledState extends MultiplayerState
    with MultiplayerDisabledStateMappable {}

@MappableClass()
final class MultiplayerConnectingState extends MultiplayerState
    with MultiplayerConnectingStateMappable {}

@MappableClass()
final class MultiplayerDisconnectedState extends MultiplayerState
    with MultiplayerDisconnectedStateMappable {
  final MultiplayerConnectedState? oldState;
  final Object? error;

  MultiplayerDisconnectedState({
    this.error,
    this.oldState,
  });

  bool get canReconnect => oldState != null;
}

@MappableClass()
final class MultiplayerConnectedState extends MultiplayerState
    with MultiplayerConnectedStateMappable {
  final NetworkerBase networker;
  final SimpleNetworkerPipe<WorldEvent> pipe;

  MultiplayerConnectedState(this.networker, this.pipe);

  @override
  bool get isClient => networker is NetworkerClient;
  @override
  bool get isServer => networker is NetworkerServer;

  Stream<Set<int>>? get clientChange => networker is NetworkerServer
      ? (networker as NetworkerServer).clientChange
      : null;
}

class MultiplayerCubit extends Cubit<MultiplayerState> {
  final NetworkService networkService;
  final StreamController<PlayableWorldEvent> _eventController =
      StreamController.broadcast();

  Stream<PlayableWorldEvent> get events => _eventController.stream;

  final StreamController<NetworkerPacket<ClientWorldEvent>>
      _serverEventController = StreamController.broadcast();

  Stream<NetworkerPacket<ClientWorldEvent>> get serverEvents =>
      _serverEventController.stream;

  final StreamController<(Channel, ConnectionInfo)> _initController =
      StreamController.broadcast();

  Stream<(Channel, ConnectionInfo)> get inits => _initController.stream;

  FatalServerEventError? _fatalError;

  MultiplayerCubit(this.networkService) : super(MultiplayerDisabledState());

  bool get isConnected => state.isConnected;
  bool get isClient => state.isClient;
  bool get isServer => state.isServer;

  Set<Channel> get clients {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return {};
    final networker = state.networker;
    if (networker is! NetworkerServer) return {};
    return networker.clientConnections;
  }

  Future<MultiplayerConnectedState> _addNetworker(NetworkerBase base) async {
    final transformer = NetworkerPipeTransformer<String, WorldEvent>(
      WorldEventMapper.fromJson,
      (e) => e.toJson(),
    );
    final pipe = SimpleNetworkerPipe<WorldEvent>();
    final stringPlugin = StringNetworkerPlugin();
    transformer.read.listen(_onServerEvent);
    base.connect(stringPlugin..connect(transformer));
    if (base is NetworkerClient) {
      transformer.connect(pipe);
    } else if (base is NetworkerServer) {
      base.clientConnect.listen(_initController.add);
      transformer.connect(SimpleNetworkerPipe()
        ..read.listen(_onClientEvent)
        ..write.listen((e) => _onClientEvent(e, true))
        ..connect(pipe));
    }
    return MultiplayerConnectedState(base, pipe);
  }

  void _onClientEvent(NetworkerPacket<WorldEvent> event, [bool local = false]) {
    final data = event.data;
    if (data is ServerWorldEvent && local) {
      if (event.channel == kAuthorityChannel || event.channel == kAnyChannel) {
        _eventController.add(data);
      }
    } else if (data is ClientWorldEvent) {
      _serverEventController.add(
          NetworkerPacket(data, local ? kAuthorityChannel : event.channel));
    }
  }

  void _onServerEvent(NetworkerPacket<WorldEvent> event) {
    final data = event.data;
    if (data is ServerWorldEvent) {
      _eventController.add(data);
    }
  }

  @override
  Future<void> close() {
    disconnect(false);
    return super.close();
  }

  void disconnect([bool emit = true]) {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    state.networker.close();
    networkService.cancelServerInfo();
    if (emit && state.isServer) {
      this.emit(MultiplayerDisabledState());
    }
  }

  Future<void> connect(Uri address) async {
    try {
      emit(MultiplayerConnectingState());
      final client = NetworkerSocketClient(address);
      final state = await _addNetworker(client);
      client.onClosed.listen((_) {
        if (isClosed) return;
        emit(MultiplayerDisconnectedState(oldState: state, error: _fatalError));
        _fatalError = null;
      }, onError: (e) => emit(MultiplayerDisconnectedState(error: e)));
      await client.init();
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  Future<void> create({GameProperty? property, int? port}) async {
    try {
      port ??= kDefaultPort;
      final prop = property ?? GameProperty.defaultProperty;
      final server = NetworkerSocketServer(
        InternetAddress.loopbackIPv4,
        port,
        filterConnections: buildFilterConnections(loadProperty: (_) {
          final state = this.state;
          if (state is! MultiplayerConnectedState) return prop;
          final networker = state.networker;
          if (networker is! NetworkerServer) return prop;
          return prop.copyWith(
              currentPlayers: networker.clientConnections.length);
        }),
      );
      final state = await _addNetworker(server);
      await server.init();
      networkService.sendServerInfo(LanProperty(
        description: prop.description,
        port: port,
      ));
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  void send(WorldEvent event) {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    if (event is LocalWorldEvent) return;
    if (event is! ClientWorldEvent) return;
    state.pipe.sendMessage(event);
  }

  void sendServer(ServerWorldEvent event, [Channel channel = kAnyChannel]) =>
      sendServerPacket(NetworkerPacket(event, channel));

  void sendServerPacket(NetworkerPacket<ServerWorldEvent> packet) =>
      sendServerPackets([packet]);

  void sendServerPackets(List<NetworkerPacket<ServerWorldEvent>> packets) {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    for (final packet in packets) {
      state.pipe.sendMessage(packet.data, packet.channel);
    }
  }

  Future<void> reconnect() async {
    try {
      final state = this.state;
      if (state is! MultiplayerDisconnectedState) return;
      final oldState = state.oldState;
      if (oldState == null) return;
      emit(MultiplayerConnectingState());
      await oldState.networker.init();
      emit(oldState);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  Future<void> raiseError(FatalServerEventError e) async {
    _fatalError = e;
    disconnect();
  }
}
