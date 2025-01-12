import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix_api/setonix_api.dart';

class DecksEditorPage extends StatelessWidget {
  const DecksEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditorCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: LeapBreakpoints.expanded),
            padding: const EdgeInsets.all(4),
            child: BlocBuilder<EditorCubit, SetonixData>(
              builder: (context, state) {
                final decks = state.getDeckItems();
                return Column(
                  children: decks.map((deck) {
                    final id = deck.id;
                    return Dismissible(
                      key: ValueKey(id),
                      onDismissed: (direction) {
                        cubit.removeDeck(id);
                      },
                      child: ListTile(
                        title: Text(id),
                        trailing: IconButton(
                          icon: const Icon(PhosphorIconsLight.trash),
                          onPressed: () {
                            cubit.removeDeck(id);
                          },
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: DeckEditorDialog(name: id),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final name = await showDialog<String>(
              context: context,
              builder: (context) => NameDialog(
                    validator: defaultNameValidator(
                        context, cubit.state.getDecks().toList()),
                  ));
          if (name == null) return;
          cubit.setDeck(name, DeckDefinition());
        },
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(PhosphorIconsLight.plus),
      ),
    );
  }
}

class DeckEditorDialog extends StatefulWidget {
  final String name;

  const DeckEditorDialog({super.key, required this.name});

  @override
  State<DeckEditorDialog> createState() => _DeckEditorDialogState();
}

class _DeckEditorDialogState extends State<DeckEditorDialog> {
  DeckDefinition? _value;
  late PackTranslation _translation;

  @override
  void initState() {
    super.initState();
    final editorState = context.read<EditorCubit>().state;
    _value = editorState.getDeck(widget.name);
    _translation = editorState.getTranslationOrDefault();
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    if (value == null) return const SizedBox();
    return DefaultTabController(
      length: 3,
      child: ResponsiveAlertDialog(
        title: Text(widget.name),
        constraints: const BoxConstraints(
          maxWidth: LeapBreakpoints.compact,
          maxHeight: 600,
        ),
        content: Column(
          children: [
            TabBar(
              tabs: [
                HorizontalTab(
                  icon: const Icon(PhosphorIconsLight.textT),
                  label: Text(AppLocalizations.of(context).general),
                ),
                HorizontalTab(
                  icon: const Icon(PhosphorIconsLight.spade),
                  label: Text(AppLocalizations.of(context).figures),
                ),
                HorizontalTab(
                  icon: const Icon(PhosphorIconsLight.stack),
                  label: Text(AppLocalizations.of(context).boards),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).name,
                          filled: true,
                          icon: const Icon(PhosphorIconsLight.textT),
                        ),
                        initialValue: _translation.figures[widget.name]?.name,
                        onChanged: (value) {
                          final translation = FigureTranslation(name: value);
                          _translation = _translation.copyWith.figures
                              .put(widget.name, translation);
                        },
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      ListView.builder(
                        itemCount: value.figures.length,
                        itemBuilder: (context, index) {
                          final figure = value.figures[index];
                          return ListTile(
                            title: Text(figure.name),
                            onTap: () async {
                              final bloc = context.read<EditorCubit>();
                              final result =
                                  await showDialog<FigureDeckDefinition>(
                                context: context,
                                builder: (context) => BlocProvider.value(
                                  value: bloc,
                                  child: _DeckFigureEditorDialog(
                                    value: figure,
                                  ),
                                ),
                              );
                              if (result == null) return;
                              setState(() {
                                value.figures[index] = result;
                              });
                            },
                            trailing: IconButton(
                              icon: const Icon(PhosphorIconsLight.trash),
                              onPressed: () {
                                setState(() {
                                  value.figures.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            final bloc = context.read<EditorCubit>();
                            final result =
                                await showDialog<FigureDeckDefinition>(
                              context: context,
                              builder: (context) => BlocProvider.value(
                                value: bloc,
                                child: _DeckFigureEditorDialog(),
                              ),
                            );
                            if (result == null) return;
                            setState(() {
                              value.figures.add(result);
                            });
                          },
                          icon: const Icon(PhosphorIconsLight.plus),
                          label: Text(AppLocalizations.of(context).create),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      ListView.builder(
                        itemCount: value.boards.length,
                        itemBuilder: (context, index) {
                          final board = value.boards[index];
                          return ListTile(
                            title: Text(board.name),
                            onTap: () async {
                              final bloc = context.read<EditorCubit>();
                              final result =
                                  await showDialog<BoardDeckDefinition>(
                                context: context,
                                builder: (context) => BlocProvider.value(
                                  value: bloc,
                                  child: _DeckBoardEditorDialog(
                                    value: board,
                                  ),
                                ),
                              );
                              if (result == null) return;
                              setState(() {
                                value.boards[index] = result;
                              });
                            },
                            trailing: IconButton(
                              icon: const Icon(PhosphorIconsLight.trash),
                              onPressed: () {
                                setState(() {
                                  value.boards.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            final bloc = context.read<EditorCubit>();
                            final result =
                                await showDialog<BoardDeckDefinition>(
                              context: context,
                              builder: (context) => BlocProvider.value(
                                value: bloc,
                                child: _DeckBoardEditorDialog(),
                              ),
                            );
                            if (result == null) return;
                            setState(() {
                              value.boards.add(result);
                            });
                          },
                          icon: const Icon(PhosphorIconsLight.plus),
                          label: Text(AppLocalizations.of(context).create),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<EditorCubit>().setDeck(widget.name, value);
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
  }
}

class _DeckFigureEditorDialog extends StatefulWidget {
  final FigureDeckDefinition? value;

  const _DeckFigureEditorDialog({
    this.value,
  });

  @override
  State<_DeckFigureEditorDialog> createState() =>
      __DeckFigureEditorDialogState();
}

class __DeckFigureEditorDialogState extends State<_DeckFigureEditorDialog> {
  FigureDeckDefinition? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).figure),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: BlocBuilder<EditorCubit, SetonixData>(
        builder: (context, state) {
          final figure = _value == null ? null : state.getFigure(_value!.name);
          return ListView(
            shrinkWrap: true,
            children: [
              DropdownMenu<String>(
                dropdownMenuEntries: state.getFigures().map((e) {
                  return DropdownMenuEntry(
                    value: e,
                    label: e,
                  );
                }).toList(),
                label: Text(AppLocalizations.of(context).name),
                initialSelection: _value?.name,
                expandedInsets: EdgeInsets.all(8),
                onSelected: (value) {
                  if (value == null) return;
                  setState(() {
                    _value = FigureDeckDefinition(name: value);
                  });
                },
              ),
              if (figure != null) ...[
                const SizedBox(height: 8),
                DropdownMenu<String>(
                  initialSelection: _value?.variation,
                  label: Text(AppLocalizations.of(context).variation),
                  expandedInsets: EdgeInsets.all(8),
                  dropdownMenuEntries: ['', ...figure.variations.keys].map((e) {
                    return DropdownMenuEntry(
                      value: e,
                      label:
                          e.isEmpty ? AppLocalizations.of(context).notSet : e,
                    );
                  }).toList(),
                  onSelected: (value) {
                    if (value == null) return;
                    setState(() {
                      _value = FigureDeckDefinition(
                        name: _value!.name,
                        variation: value,
                      );
                    });
                  },
                ),
                const SizedBox(height: 8),
                OffsetListTile(
                  title: Text(AppLocalizations.of(context).position),
                  value: _value!.position.toOffset(),
                  onChanged: (value) {
                    setState(() {
                      _value = FigureDeckDefinition(
                        name: _value!.name,
                        variation: _value!.variation,
                        position: value.toDefinition(),
                      );
                    });
                  },
                ),
              ],
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_value);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}

class _DeckBoardEditorDialog extends StatefulWidget {
  final BoardDeckDefinition? value;

  const _DeckBoardEditorDialog({
    this.value,
  });

  @override
  State<_DeckBoardEditorDialog> createState() => __DeckBoardEditorDialogState();
}

class __DeckBoardEditorDialogState extends State<_DeckBoardEditorDialog> {
  BoardDeckDefinition? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).board),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: BlocBuilder<EditorCubit, SetonixData>(
        builder: (context, state) {
          final board = _value == null ? null : state.getBoard(_value!.name);
          return ListView(
            shrinkWrap: true,
            children: [
              DropdownMenu<String>(
                dropdownMenuEntries: state.getBoards().map((e) {
                  return DropdownMenuEntry(
                    value: e,
                    label: e,
                  );
                }).toList(),
                label: Text(AppLocalizations.of(context).name),
                initialSelection: _value?.name,
                expandedInsets: EdgeInsets.all(8),
                onSelected: (value) {
                  if (value == null) return;
                  setState(() {
                    _value = BoardDeckDefinition(name: value);
                  });
                },
              ),
              if (board != null) ...[
                const SizedBox(height: 8),
                OffsetListTile(
                  title: Text(AppLocalizations.of(context).position),
                  value: _value!.position.toOffset(),
                  onChanged: (value) {
                    setState(() {
                      _value = BoardDeckDefinition(
                        name: _value!.name,
                        position: value.toDefinition(),
                      );
                    });
                  },
                ),
              ],
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_value);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
