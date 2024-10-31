import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networker/networker.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/helpers/asset.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix_api/setonix_api.dart';

ServerProcessed _compute(
        (ServerWorldEvent, WorldState, Map<String, FileMetadata>) m) =>
    processServerEvent(m.$1, m.$2, signature: m.$3);

SetonixData _saveState(WorldState state) => state.save();

class WorldBloc extends Bloc<PlayableWorldEvent, ClientWorldState> {
  bool _remoteEvent = false;
  WorldBloc({
    required MultiplayerCubit multiplayer,
    required ColorScheme colorScheme,
    required SetonixFileSystem fileSystem,
    String? name,
    SetonixData? data,
    GameTable? table,
  }) : super(ClientWorldState(
          assetManager: GameAssetManager(
            fileSystem: fileSystem,
          ),
          multiplayer: multiplayer,
          colorScheme: colorScheme,
          world: WorldState(
            name: name,
            data: data ?? SetonixData.empty(),
            table: table ?? data?.getTable() ?? const GameTable(),
            metadata: data?.getMetadata() ?? const FileMetadata(),
            info: data?.getInfo() ?? const GameInfo(),
          ),
        )) {
    state.multiplayer
      ..events.listen((event) {
        _remoteEvent = true;
        add(event);
        _remoteEvent = false;
      })
      ..inits.listen((e) {
        if (e.$1 == kAnyChannel) return;
        _processEvent(NetworkerPacket(null, e.$1));
      })
      ..serverEvents.listen(_processEvent);

    on<ServerWorldEvent>((event, emit) async {
      try {
        final signature = state.assetManager.createSignature();
        final world = state.world;
        final processed = await compute<
            (ServerWorldEvent, WorldState, Map<String, FileMetadata>),
            ServerProcessed>(_compute, (event, world, signature));
        final newWorld = processed.state;
        processed.responses.forEach(process);
        if (newWorld == null) return;
        emit(state.copyWith(world: newWorld));
        return save();
      } on FatalServerEventError catch (e) {
        state.multiplayer.raiseError(e);
      }
    }, transformer: sequential());
    on<ColorSchemeChanged>((event, emit) {
      emit(state.copyWith(colorScheme: event.colorScheme));
    });
    on<HandChanged>((event, emit) {
      emit(state.copyWith(
        showHand: event.show ??
            (!state.showHand ||
                state.selectedDeck != event.deck ||
                state.selectedCell != null),
        selectedDeck: event.deck,
        selectedCell: null,
      ));
    });
    on<CellSwitched>((event, emit) {
      emit(state.copyWith(
        selectedCell: event.toggle && state.selectedCell == event.cell
            ? null
            : event.cell,
        selectedDeck: null,
        showHand: true,
      ));
    });
    on<SwitchCellOnMoveChanged>((event, emit) {
      emit(state.copyWith(
        switchCellOnMove: event.value,
      ));
    });
    on<TableSwitched>((event, emit) {
      emit(state.copyWith.world(
        table: state.world.getTableOrDefault(event.name),
        tableName: event.name,
        data:
            state.world.data.setTable(state.world.table, state.world.tableName),
      ));
    });
    on<DrawerViewChanged>((event, emit) {
      emit(state.copyWith(drawerView: event.view));
    });
    on<SearchTermChanged>((event, emit) {
      emit(state.copyWith(searchTerm: event.term));
    });
    on<ShowDuplicatesChanged>((event, emit) {
      emit(
          state.copyWith(showDuplicates: event.value ?? !state.showDuplicates));
    });
  }

  Future<void> save() async {
    final data = await compute((state) => _saveState(state), state.world);
    final name = state.world.name;
    if (name == null) return;
    return state.fileSystem.worldSystem.updateFile(name, data);
  }

  void _processEvent(NetworkerPacket<WorldEvent?> data) {
    final value = processClientEvent(data.data, data.channel, state.world,
        assetManager: state.assetManager);
    if (value == null) return;
    state.multiplayer.sendServerPackets(
        value.buildPackets(state.world, state.multiplayer.clients));
  }

  @override
  void onEvent(PlayableWorldEvent event) {
    super.onEvent(event);
    if (event is ClientWorldEvent && !_remoteEvent) {
      state.multiplayer.send(event);
    }
  }

  void process(WorldEvent event) {
    switch (event) {
      case LocalWorldEvent e:
        add(e);
      case ClientWorldEvent e:
        final multiplayer = state.multiplayer;
        if (multiplayer.isConnected) {
          multiplayer.send(e);
        } else {
          final event = processClientEvent(e, kAuthorityChannel, state.world,
              assetManager: state.assetManager, allowServerEvents: true);
          if (event != null) {
            add(event.main.data);
            final updatePacket = event.buildUpdatePackets(
                state.world, {kAuthorityChannel}).firstOrNull;
            if (updatePacket != null) {
              add(updatePacket.data);
            }
          }
        }
      case ServerWorldEvent e:
        add(e);
    }
  }
}
