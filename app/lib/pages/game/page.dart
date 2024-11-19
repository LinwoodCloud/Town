import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/pages/game/chat.dart';
import 'package:setonix/pages/game/dialog.dart';
import 'package:setonix/pages/game/drawer.dart';
import 'package:setonix/pages/game/error.dart';
import 'package:setonix/pages/game/filter.dart';
import 'package:setonix/pages/game/notes.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix_api/setonix_api.dart';

class GamePage extends StatefulWidget {
  final String? name;
  final String? address;
  final bool secure;
  final SetonixData? data;

  const GamePage({
    super.key,
    this.name,
    this.data,
    this.address,
    this.secure = true,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

typedef Blocs = (MultiplayerCubit, WorldBloc);

class _GamePageState extends State<GamePage> {
  Future<Blocs>? _bloc;
  final ContextMenuController _contextMenuController = ContextMenuController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _bloc = _loadTable();
      });
    });
  }

  Future<Blocs> _initBloc([SetonixData? data]) async {
    final cubit = MultiplayerCubit(context.read<NetworkService>());
    final address = widget.address;
    final world = WorldBloc(
      multiplayer: cubit,
      fileSystem: context.read<SetonixFileSystem>(),
      name: widget.name,
      data: data,
      colorScheme: Theme.of(context).colorScheme,
    );
    await world.state.assetManager.loadPacks();
    if (address != null) {
      cubit.connect(buildServerAddress(address, widget.secure));
    }
    return (cubit, world);
  }

  Future<Blocs> _loadTable() async {
    final address = widget.address;
    if (address != null) {
      return _initBloc();
    }
    final worldSystem = context.read<SetonixFileSystem>().worldSystem;
    final name = widget.name;
    final data = (widget.data ??
            (name == null ? null : await worldSystem.getFile(name))) ??
        SetonixData.empty();
    return _initBloc(data);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final nextColorScheme = Theme.of(context).colorScheme;
    final bloc = await _bloc;
    if (nextColorScheme != bloc?.$2.state.colorScheme) {
      bloc?.$2.process(ColorSchemeChanged(nextColorScheme));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _bloc?.then((bloc) {
      bloc.$1.close();
      bloc.$2.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Blocs>(
        future: _bloc,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final bloc = snapshot.data!;
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) => _contextMenuController.remove(),
            child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: bloc.$1),
                  BlocProvider.value(value: bloc.$2),
                ],
                child: BlocBuilder<MultiplayerCubit, MultiplayerState>(
                  buildWhen: (previous, current) =>
                      previous is MultiplayerDisconnectedState !=
                          current is MultiplayerDisconnectedState ||
                      previous is MultiplayerConnectingState !=
                          current is MultiplayerConnectingState,
                  builder: (context, state) {
                    if (state is MultiplayerConnectingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is MultiplayerDisconnectedState) {
                      return GameErrorView(
                        state: state,
                        onReconnect: () async => (await _bloc)?.$1.reconnect(),
                      );
                    }
                    return Scaffold(
                      appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
                        title: Text(AppLocalizations.of(context).game),
                        height: 50,
                        actions: [
                          BlocBuilder<WorldBloc, ClientWorldState>(
                              buildWhen: (previous, current) =>
                                  previous.showHand != current.showHand ||
                                  previous.selectedCell != current.selectedCell,
                              builder: (context, state) {
                                final selected = state.showHand &&
                                    state.selectedCell == null;
                                return IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.plusCircle),
                                  selectedIcon: const PhosphorIcon(
                                      PhosphorIconsFill.plusCircle),
                                  isSelected: selected,
                                  tooltip: selected
                                      ? AppLocalizations.of(context)
                                          .enterEditMode
                                      : AppLocalizations.of(context)
                                          .exitEditMode,
                                  onPressed: () {
                                    context
                                        .read<WorldBloc>()
                                        .process(HandChanged.toggle());
                                    _focusNode.requestFocus();
                                  },
                                );
                              })
                        ],
                      ),
                      drawer: const GameDrawer(),
                      endDrawer: BlocBuilder<WorldBloc, ClientWorldState>(
                        buildWhen: (previous, current) =>
                            previous.drawerView != current.drawerView,
                        builder: (context, state) => switch (state.drawerView) {
                          DrawerView.chat => const GameChatDrawer(),
                          DrawerView.notes => const GameNotesDrawer(),
                        },
                      ),
                      body: BlocListener<WorldBloc, ClientWorldState>(
                        listenWhen: (previous, current) =>
                            previous.messages.length != current.messages.length,
                        listener: (context, state) {
                          final message = state.messages.lastOrNull;
                          if (message == null || message.author == state.id) {
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              width: 300,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context).newMessage(
                                          message.author.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(message.content,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                              action: SnackBarAction(
                                label: AppLocalizations.of(context).open,
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: GameWidget(
                          game: BoardGame(
                            bloc: context.read<WorldBloc>(),
                            settingsCubit: context.read<SettingsCubit>(),
                            contextMenuController: _contextMenuController,
                            onEscape: () => Scaffold.of(context).openDrawer(),
                          ),
                          focusNode: _focusNode,
                          initialActiveOverlays: ['dialogs', 'filter'],
                          overlayBuilderMap: {
                            'dialogs': (context, game) => GameDialogOverlay(),
                            'filter': (context, game) => GameFilterView(),
                          },
                        ),
                      ),
                    );
                  },
                )),
          );
        });
  }
}
