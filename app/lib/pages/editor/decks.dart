import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
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
                  SizedBox(),
                  SizedBox(),
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
