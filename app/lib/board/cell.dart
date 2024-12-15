import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/background.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/board/grid.dart';
import 'package:setonix/board/hand/item.dart';
import 'package:setonix/helpers/scroll.dart';
import 'package:setonix/helpers/secondary.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix/helpers/visualizer.dart';
import 'package:setonix_api/setonix_api.dart';

class GameCell extends PositionComponent
    with
        HasGameRef<BoardGame>,
        HoverCallbacks,
        TapCallbacks,
        DragCallbacks,
        DoubleTapCallbacks,
        SecondaryTapCallbacks,
        DetailsTapCallbacks,
        CollisionCallbacks,
        HandItemDropZone,
        FlameBlocListenable<WorldBloc, ClientWorldState>,
        ScrollCallbacks {
  late final SpriteComponent _selectionComponent;
  SpriteComponent? _cardComponent, _boardComponent;
  late final BoardGrid grid;
  List<Effect>? _effects;

  GameCell({
    super.size,
    super.position,
  });

  void _updateEffects(List<Effect> effects) {
    _effects = effects;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final effects = _effects;
    if (effects != null) {
      _selectionComponent.removeWhere((e) => e is Effect);
      _selectionComponent.addAll(effects);
      _effects = null;
    }
    if (isMounted) {
      _updateTop();
    }
  }

  @override
  void onLoad() {
    super.onLoad();
    grid = findParent<BoardGrid>()!;
    add(GameBoardBackground(size: size));
    _selectionComponent = SpriteComponent(
      sprite: game.selectionSprite,
      size: size,
      priority: 1,
    );
    add(_selectionComponent);
  }

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) {
    final definition = toDefinition();
    return (previousState.selectedCell == definition) !=
            (newState.selectedCell == definition) ||
        previousState.table.cells[definition] !=
            newState.table.cells[definition] ||
        previousState.teamMembers != newState.teamMembers ||
        previousState.colorScheme != newState.colorScheme;
  }

  bool get isSelected => isMounted && bloc.state.selectedCell == toDefinition();

  void _fadeIn() => _updateEffects([
        OpacityEffect.fadeIn(
          EffectController(
            duration: 0.2,
          ),
        )
      ]);
  @override
  void onHoverEnter() {
    if (!isSelected) {
      _fadeIn();
    }
  }

  @override
  void onDragOver(HandItem handItem) => _fadeIn();

  void _fadeOut() => _updateEffects([
        OpacityEffect.fadeOut(
          EffectController(
            duration: 0.2,
          ),
        )
      ]);

  @override
  void onHoverExit() {
    if (!isSelected) {
      _fadeOut();
    }
  }

  @override
  void onDragOverEnd(HandItem handItem) {
    if (!isSelected) {
      _fadeOut();
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (isSelected) {
      bloc.process(HandChanged.hide());
    } else {
      bloc.process(CellSwitched(toDefinition(), toggle: true));
    }
  }

  VectorDefinition toDefinition() =>
      (position.clone()..divide(grid.cellSizeWithZoom)).toDefinition();

  GlobalVectorDefinition toGlobalDefinition(ClientWorldState state) =>
      GlobalVectorDefinition.fromLocal(state.tableName, toDefinition());

  @override
  void onInitialState(ClientWorldState state) {
    if (state.selectedCell != toDefinition()) _selectionComponent.opacity = 0;
  }

  bool isClaimed(ClientWorldState state) => state.info.teams.entries.any(
      (entry) => entry.value.claimedCells.contains(toGlobalDefinition(state)));

  bool isAllowed(ClientWorldState state) => state.teamMembers.entries
      .where((entry) => entry.value.contains(state.id))
      .any((entry) =>
          state.info.teams[entry.key]?.claimedCells
              .contains(toGlobalDefinition(state)) ??
          false);

  GameObject? _currentTop;
  BoardTile? _currentTile;
  bool _currentVisible = true;

  @override
  void onNewState(ClientWorldState state) {
    final selected = state.selectedCell == toDefinition();
    final color = isClaimed(state)
        ? isAllowed(state)
            ? state.colorScheme.secondary
            : state.colorScheme.error
        : state.colorScheme.primary;
    if (selected) {
      _updateEffects([
        OpacityEffect.fadeIn(
          EffectController(
            duration: 0.2,
          ),
        ),
        ColorEffect(
          color,
          EffectController(
            duration: 0.2,
          ),
        ),
      ]);
    } else {
      _updateEffects([
        OpacityEffect.fadeOut(
          EffectController(
            duration: 0.2,
          ),
        ),
        ColorEffect(
            color,
            EffectController(
              duration: 0.2,
            ),
            opacityFrom: 1,
            opacityTo: 0),
      ]);
    }
  }

  Future<void> _updateTop() async {
    final state = bloc.state;
    final cell = state.table.cells[toDefinition()];
    final top = cell?.objects.firstOrNull;
    final visible = state.isCellVisible(toGlobalDefinition(state));
    final tile = cell?.tiles.lastOrNull;
    if (top == _currentTop &&
        visible == _currentVisible &&
        tile == _currentTile) {
      return;
    }
    _currentTop = top;
    _currentVisible = visible;
    _currentTile = tile;
    final paint = Paint()..isAntiAlias = false;
    if (tile != null) {
      final component = _boardComponent ??= SpriteComponent(
        size: size,
        paint: paint,
      );
      component.sprite =
          await state.assetManager.loadBoardSprite(tile.asset, tile.tile) ??
              game.blankSprite;
      if (!component.isMounted) {
        add(component);
      }
    } else {
      _boardComponent?.removeFromParent();
    }
    if (top != null) {
      final component = _cardComponent ??= SpriteComponent(
        size: size,
        paint: paint,
        priority: 1,
      );
      component.sprite = await state.assetManager.loadFigureSprite(
              top.asset,
              top.hidden || !state.isCellVisible(toGlobalDefinition(state))
                  ? null
                  : top.variation) ??
          game.blankSprite;
      if (!component.isMounted) {
        add(component);
      }
    } else {
      _cardComponent?.removeFromParent();
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    final delta = event.canvasDelta
      ..negate()
      ..divide(Vector2.all(game.camera.viewfinder.zoom));
    game.camera.moveBy(delta);
  }

  bool anyRollable(ClientWorldState state) {
    final assetManager = state.assetManager;
    final global = toGlobalDefinition(state);
    final local = global.position;
    final cell = state.table.getCell(local);
    if (!state.isCellVisible(global)) return false;
    return cell.objects.any((object) =>
        (assetManager.getFigure(object.asset)?.rollable ?? false) &&
        state.isCellVisible(global));
  }

  @override
  void onContextMenu(Vector2 position) {
    game.showContextMenu(
        contextMenuBuilder: (context, onClose) =>
            AdaptiveTextSelectionToolbar.buttonItems(
                buttonItems: [
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).toggleHide,
                    onPressed: () {
                      bloc.process(
                          CellHideChanged(toGlobalDefinition(bloc.state)));
                      onClose();
                    },
                  ),
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).shuffle,
                    onPressed: () {
                      bloc.process(
                          ShuffleCellRequest(toGlobalDefinition(bloc.state)));
                      onClose();
                    },
                  ),
                  if (anyRollable(bloc.state))
                    ContextMenuButtonItem(
                      label: AppLocalizations.of(context).roll,
                      onPressed: () {
                        bloc.process(
                            CellRollRequest(toGlobalDefinition(bloc.state)));
                        onClose();
                      },
                    ),
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).remove,
                    onPressed: () {
                      bloc.process(
                          ObjectsRemoved(toGlobalDefinition(bloc.state)));
                      onClose();
                    },
                  ),
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).teams,
                    onPressed: () {
                      onClose();
                      showLeapBottomSheet(
                        context: context,
                        titleBuilder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppLocalizations.of(context).teams),
                            Text(toDefinition().toDisplayString(),
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        childrenBuilder: (context) => [
                          BlocBuilder<WorldBloc, ClientWorldState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous.info.teams != current.info.teams,
                            builder: (context, state) {
                              final teams = state.info.teams.entries.toList();
                              if (teams.isEmpty) {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context).noTeams,
                                  ),
                                );
                              }
                              final anyClaimed = teams.any((entry) => entry
                                  .value.claimedCells
                                  .contains(toGlobalDefinition(state)));
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    anyClaimed
                                        ? AppLocalizations.of(context)
                                            .claimedCell
                                        : AppLocalizations.of(context)
                                            .publicCell,
                                  ),
                                  ...teams.map((entry) {
                                    final selected = entry.value.claimedCells
                                        .contains(toGlobalDefinition(state));
                                    return ListTile(
                                      title: Text(entry.key),
                                      leading: ColorButton(
                                        color: entry.value.color?.color ??
                                            Colors.transparent,
                                        size: 24,
                                      ),
                                      selected: selected,
                                      onTap: () => bloc.process(TeamChanged(
                                          entry.key,
                                          entry.value.copyWith(
                                            claimedCells: selected
                                                ? entry.value.claimedCells
                                                    .difference({
                                                    toGlobalDefinition(state)
                                                  })
                                                : entry.value.claimedCells
                                                    .union({
                                                    toGlobalDefinition(state)
                                                  }),
                                          ))),
                                    );
                                  }),
                                ],
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                ],
                anchors: TextSelectionToolbarAnchors(
                    primaryAnchor: position.toOffset())));
  }

  @override
  bool onScroll(PointerScrollInfo info) {
    var delta = info.scrollDelta.global.clone()..divide(Vector2.all(4));
    if (game.isShifting) {
      delta = Vector2(delta.y, delta.x);
    }
    game.camera.moveBy(delta);
    return false;
  }
}
