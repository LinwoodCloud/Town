import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix_api/setonix_api.dart';

class FiguresEditorPage extends StatelessWidget {
  const FiguresEditorPage({super.key});

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
                final figures = state.getFigureItems();
                if (figures.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context).noData),
                    ),
                  );
                }
                return Column(
                  children: figures.map((figure) {
                    final id = figure.id;
                    return Dismissible(
                      key: ValueKey(id),
                      onDismissed: (direction) {
                        cubit.removeFigure(id);
                      },
                      child: ListTile(
                        title: Text(id),
                        trailing: IconButton(
                          icon: const Icon(PhosphorIconsLight.trash),
                          onPressed: () {
                            cubit.removeFigure(id);
                          },
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: FigureEditorDialog(name: id),
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
                        context, cubit.state.getFigures().toList()),
                  ));
          if (name == null) return;
          cubit.setFigure(
              name, FigureDefinition(back: FigureBackDefinition(texture: '')));
        },
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(PhosphorIconsLight.plus),
      ),
    );
  }
}

class FigureEditorDialog extends StatefulWidget {
  final String name;

  const FigureEditorDialog({super.key, required this.name});

  @override
  State<FigureEditorDialog> createState() => _FigureEditorDialogState();
}

class _FigureEditorDialogState extends State<FigureEditorDialog> {
  late FigureDefinition? _value;

  @override
  void initState() {
    super.initState();
    _value = context.read<EditorCubit>().state.getFigure(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    if (value == null) {
      return const SizedBox();
    }
    return ResponsiveAlertDialog(
      title: Text(widget.name),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          CheckboxListTile(
            value: value.rollable,
            title: Text(AppLocalizations.of(context).roll),
            onChanged: (bool? value) {
              if (value != null) {
                setState(() {
                  _value = _value?.copyWith(rollable: value);
                });
              }
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
            context.read<EditorCubit>().setFigure(widget.name, value);
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
