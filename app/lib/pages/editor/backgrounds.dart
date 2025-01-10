import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix/pages/editor/textures.dart';
import 'package:setonix_api/setonix_api.dart';

class BackgroundsEditorPage extends StatelessWidget {
  const BackgroundsEditorPage({super.key});

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
                final backgrounds = state.getBackgroundItems();
                return Column(
                  children: backgrounds.map((background) {
                    final id = background.id;
                    return Dismissible(
                      key: ValueKey(id),
                      onDismissed: (direction) {
                        cubit.removeBackground(id);
                      },
                      child: ListTile(
                        title: Text(id),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: BackgroundEditorDialog(name: id),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const Icon(PhosphorIconsLight.trash),
                          onPressed: () {
                            cubit.removeBackground(id);
                          },
                        ),
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
                        context, cubit.state.getBackgrounds().toList()),
                  ));
          if (name == null) return;
          cubit.setBackground(name, BackgroundDefinition(texture: ''));
        },
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(PhosphorIconsLight.plus),
      ),
    );
  }
}

class BackgroundEditorDialog extends StatefulWidget {
  final String name;

  const BackgroundEditorDialog({
    super.key,
    required this.name,
  });

  @override
  State<BackgroundEditorDialog> createState() => _BackgroundEditorDialogState();
}

class _BackgroundEditorDialogState extends State<BackgroundEditorDialog> {
  BackgroundDefinition? _value;
  late PackTranslation _translation;

  @override
  void initState() {
    super.initState();
    final editorState = context.read<EditorCubit>().state;
    _value = editorState.getBackground(widget.name);
    _translation = editorState.getTranslationOrDefault();
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    if (value == null) {
      return const SizedBox();
    }
    return ResponsiveAlertDialog(
      title: Text(widget.name),
      constraints: const BoxConstraints(
          maxWidth: LeapBreakpoints.compact, maxHeight: 600),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              filled: true,
              icon: const Icon(PhosphorIconsLight.textT),
            ),
            initialValue: _translation.backgrounds[widget.name]?.name,
            onChanged: (value) {
              final translation = BackgroundTranslation(name: value);
              _translation = _translation.copyWith.backgrounds
                  .put(widget.name, translation);
            },
          ),
          const SizedBox(height: 8),
          VisualEditingView(
              value: value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              }),
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
            context.read<EditorCubit>().setBackground(widget.name, value);
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
