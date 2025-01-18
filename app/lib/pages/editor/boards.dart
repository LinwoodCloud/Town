import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix/pages/editor/textures.dart';
import 'package:setonix_api/setonix_api.dart';

class BoardsEditorPage extends StatelessWidget {
  const BoardsEditorPage({super.key});

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
                final boards = state.getBoardItems();
                if (boards.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context).noData),
                    ),
                  );
                }
                return Column(
                  children: boards.map((board) {
                    final id = board.id;
                    return Dismissible(
                      key: ValueKey(id),
                      onDismissed: (direction) {
                        cubit.removeBoard(id);
                      },
                      child: ListTile(
                        title: Text(id),
                        trailing: IconButton(
                          icon: const Icon(PhosphorIconsLight.trash),
                          onPressed: () {
                            cubit.removeBoard(id);
                          },
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: BoardEditorDialog(name: id),
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
                        context, cubit.state.getBoards().toList()),
                  ));
          if (name == null) return;
          cubit.setBoard(name, BoardDefinition(texture: ''));
        },
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(PhosphorIconsLight.plus),
      ),
    );
  }
}

class BoardEditorDialog extends StatefulWidget {
  final String name;

  const BoardEditorDialog({super.key, required this.name});

  @override
  State<BoardEditorDialog> createState() => _BoardEditorDialogState();
}

class _BoardEditorDialogState extends State<BoardEditorDialog> {
  BoardDefinition? _value;
  late PackTranslation _translation;

  @override
  void initState() {
    super.initState();
    final editorState = context.read<EditorCubit>().state;
    _value = editorState.getBoard(widget.name);
    _translation = editorState.getTranslationOrDefault();
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    if (value == null) return const SizedBox();
    return ResponsiveAlertDialog(
      title: Text(widget.name),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.compact,
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              filled: true,
              icon: const Icon(PhosphorIconsLight.textT),
            ),
            initialValue: _translation.boards[widget.name]?.name,
            onChanged: (value) {
              final translation = BoardTranslation(name: value);
              _translation =
                  _translation.copyWith.boards.put(widget.name, translation);
            },
          ),
          const SizedBox(height: 8),
          OffsetListTile(
            value: value.tiles.toOffset(),
            fractionDigits: 0,
            onChanged: (value) {
              setState(() {
                _value = _value?.copyWith(tiles: value.toDefinition());
              });
            },
            title: Text(AppLocalizations.of(context).tiles),
          ),
          VisualEditingView(
            value: value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
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
            context.read<EditorCubit>().setBoard(widget.name, value);
            context.read<EditorCubit>().setTranslation(
                  _translation,
                  widget.name,
                );
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
