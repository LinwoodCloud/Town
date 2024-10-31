import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:consoler/consoler.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/asset.dart';
import 'package:setonix_server/src/events/system.dart';
import 'package:setonix_server/src/programs/packs.dart';
import 'package:setonix_server/src/programs/players.dart';
import 'package:setonix_server/src/programs/save.dart';
import 'package:setonix_server/src/programs/say.dart';
import 'package:setonix_server/src/programs/stop.dart';

import 'events/model.dart';

Future<ServerProcessed> _computeEvent(ServerWorldEvent event, WorldState state,
    Map<String, FileMetadata> signature) {
  return Isolate.run(
      () => processServerEvent(event, state, signature: signature));
}

String _limitOutput(Object? value, [int limit = 500]) {
  final string = value.toString();
  if (string.length > limit) {
    return '${string.substring(0, limit)}...';
  }
  return string;
}

final class SetonixServer extends Bloc<PlayableWorldEvent, WorldState> {
  final Consoler consoler;
  final ServerAssetManager assetManager;
  final String? worldFile;
  final eventSystem = EventSystem();
  bool autosave = false;

  NetworkerSocketServer? _server;
  NetworkerPipe<dynamic, WorldEvent>? _pipe;

  SetonixServer._(
      this.worldFile, this.consoler, SetonixData data, this.assetManager)
      : super(WorldState(
          data: data,
          table: data.getTableOrDefault(),
          metadata: data.getMetadataOrDefault(),
          info: data.getInfoOrDefault(),
        )) {
    on<ServerWorldEvent>((event, emit) async {
      final signature = assetManager.createSignature();
      final processed = await _computeEvent(event, state, signature);
      final newState = processed.state;
      processed.responses.forEach(process);
      if (newState == null) return;
      emit(newState);
      return save();
    }, transformer: sequential());
    on<ResetWorld>((event, emit) async {
      final data = SetonixData.empty().setInfo(GameInfo(
        packs: assetManager.packs.map((e) => e.key).toList(),
      ));
      final table = data.getTableOrDefault();
      final metadata = data.getMetadataOrDefault();
      final info = data.getInfoOrDefault();
      emit(WorldState(
        data: data,
        table: table,
        metadata: metadata,
        info: info,
      ));
      _pipe?.sendMessage(
        WorldInitialized(
          table: data.getTableOrDefault(),
          info: data.getInfoOrDefault(),
          packsSignature: assetManager.createSignature(),
        ),
      );
    });
    on<ImagesUpdated>((event, emit) {
      emit(state.copyWith(images: event.images));
    });
  }

  static Future<SetonixServer> load({
    String? worldFile,
    bool disableLoading = false,
  }) async {
    final assetManager = ServerAssetManager();
    final consoler = Consoler(
      defaultProgramConfig: DefaultProgramConfiguration(
        description: "Setonix server",
      ),
    );
    await _runStaticLogZone(
        consoler, () => assetManager.init(console: consoler));
    worldFile ??= defaultWorldFile;
    final file = File(worldFile);
    SetonixData? data;
    if (!disableLoading && await file.exists()) {
      final bytes = await file.readAsBytes();
      data = SetonixData.fromData(bytes);
    }
    data ??= SetonixData.empty().setInfo(GameInfo(
      packs: assetManager.packs.map((e) => e.key).toList(),
    ));
    return SetonixServer._(worldFile, consoler, data, assetManager);
  }

  void log(Object? message, {LogLevel? level}) =>
      consoler.print(message, level: level);

  static final String defaultWorldFile = 'world.stnx';

  int _maxPlayers = 10;

  Map<int, ConnectionInfo> get players =>
      Map.fromEntries((_server?.clientConnections ?? {})
          .map((e) => MapEntry(e, _server!.getConnectionInfo(e)!)));

  Future<void> init({
    int port = kDefaultPort,
    int maxPlayers = 10,
    bool verbose = false,
    bool autosave = false,
    String description = '',
  }) async {
    if (verbose) {
      consoler.minLogLevel = LogLevel.verbose;
    }
    log("Starting server on port $port", level: LogLevel.info);
    log('Verbose logging activated', level: LogLevel.verbose);
    this.autosave = autosave;
    _maxPlayers = maxPlayers;
    SecurityContext? securityContext;
    try {
      final privateKey = await File('certs/server.key').readAsBytes();
      final certificate = await File('certs/server.crt').readAsBytes();
      securityContext = SecurityContext()
        ..usePrivateKeyBytes(privateKey)
        ..useCertificateChainBytes(certificate);
      log('Certificates found, using secure connection', level: LogLevel.info);
    } on PathNotFoundException catch (_) {
      log('No certificates found, using insecure connection',
          level: LogLevel.warning);
    }
    final server =
        _server = NetworkerSocketServer(InternetAddress.anyIPv4, port,
            securityContext: securityContext,
            filterConnections: buildFilterConnections(
                loadProperty: (request) => eventSystem.runPing(
                    request,
                    GameProperty.defaultProperty.copyWith(
                      description: description,
                      maxPlayers: maxPlayers,
                      currentPlayers: _server?.clientConnections.length,
                    ))));

    final transformer = _pipe = NetworkerPipeTransformer<String, WorldEvent>(
        WorldEventMapper.fromJson, (e) => e.toJson());
    transformer.read.listen(_onClientEvent);
    server
      ..clientConnect.listen(_onJoin)
      ..clientDisconnect.listen(_onLeave)
      ..connect(StringNetworkerPlugin()..connect(transformer));
    await _server?.init();

    consoler.registerProgram('stop', StopProgram(this));
    consoler.registerProgram('save', SaveProgram(this));
    consoler.registerProgram('packs', PacksProgram(this));
    consoler.registerProgram('players', PlayersProgram(this));
    consoler.registerProgram('say', SayProgram(this));
    consoler.registerProgram(null, UnknownProgram());
  }

  static R _runStaticLogZone<R>(Consoler consoler, R Function() body) =>
      runZoned(body, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, message) {
          consoler.print(message);
        },
      ));

  Future<void> run() async {
    consoler.run();
    log('Server running on ${_server?.address}', level: LogLevel.info);
    await _server?.onClosed.first;
  }

  void _onClientEvent(NetworkerPacket<WorldEvent?> packet,
      [bool force = false]) async {
    final data = packet.data;
    ServerResponse? process;
    try {
      process = processClientEvent(
        data is UserJoined ? null : data,
        packet.channel,
        state,
        assetManager: assetManager,
        allowServerEvents: packet.isServer,
      );
    } catch (e) {
      log('Error processing event: $e', level: LogLevel.error);
    }
    if (process == null) return;
    final event = Event(
      this,
      process.main.data,
      process.main.channel,
      data,
      packet.channel,
      process.needsUpdate,
    );
    if (!force) {
      eventSystem.fire(event);
      if (event.cancelled) return;
      log('Processing event by ${event.source}: ${_limitOutput(event.clientEvent)}, answered with ${_limitOutput(event.serverEvent)}',
          level: LogLevel.verbose);
    }
    switch (packet.data) {
      case MessageRequest data:
        log("Message by ${packet.channel}: ${data.message}",
            level: LogLevel.info);
      default:
    }
    sendEvent(event.serverEvent, event.target);
    final updatePackets = process.buildUpdatePacketsFor(
        state, _server?.clientConnections ?? {}, event.needsUpdate);
    for (final packet in updatePackets) {
      sendEvent(packet.data, packet.channel);
    }
  }

  void sendEvent(PlayableWorldEvent event, [Channel target = kAnyChannel]) {
    _pipe?.sendMessage(event, target);
    if (target == kAnyChannel || target == kAuthorityChannel) {
      add(event);
    }
  }

  void _onJoin((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    if (players.length > _maxPlayers) {
      log('Server is full, rejecting connection from ${info.address}',
          level: LogLevel.warning);
      info.close();
      return;
    }
    log('${info.address} ($user) joined the game', level: LogLevel.info);
    _onClientEvent(NetworkerPacket(
        UserJoined(channel: event.$1, info: event.$2), event.$1));
  }

  void _onLeave((Channel, ConnectionInfo) event) {
    final (user, info) = event;
    log('${info.address} ($user) left the game', level: LogLevel.info);
    eventSystem.runLeaveCallback(this, event.$1, event.$2);
  }

  Future<void> save({bool force = false}) async {
    if (!force && autosave) return;
    final bytes = state.save().exportAsBytes();
    await File(defaultWorldFile).writeAsBytes(bytes);
  }

  @override
  Future<void> close() async {
    await super.close();
    log('Closing...', level: LogLevel.info);
    _server?.close();
    consoler.dispose();
  }

  void process(WorldEvent event, [bool force = true]) {
    _onClientEvent(NetworkerPacket(event, kAuthorityChannel), force);
  }

  bool kick(int id) {
    final info = _server?.getConnectionInfo(id);
    if (info == null) return false;
    info.close();
    return true;
  }

  Future<void> resetWorld() async {
    add(ResetWorld());
    await stream.first;
  }

  void sendMessage(String message, [Channel target = kAnyChannel]) {
    process(MessageSent(kAuthorityChannel, message));
  }

  bool spawnDeck(ItemLocation location, GlobalVectorDefinition cell,
      [bool force = true]) {
    final definition = assetManager.getDeck(location);
    if (definition == null) return false;
    final boardSpawn = BoardsSpawnRequest(cell.table);
    for (final board in definition.boards) {
      boardSpawn.board(cell.position + board.position,
          ItemLocation.fromString(board.name, location.namespace));
    }
    final objectSpawn = ObjectsSpawned(cell.table);
    for (final object in definition.figures) {
      objectSpawn.objectWithLocation(
        object.position + cell.position,
        ItemLocation.fromString(object.name, location.namespace),
        variation: object.variation,
      );
    }
    process(boardSpawn, force);
    process(objectSpawn, force);
    return true;
  }
}
