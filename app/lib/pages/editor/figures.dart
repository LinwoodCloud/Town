import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix/pages/editor/textures.dart';
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
  FigureDefinition? _value;
  late PackTranslation _translation;

  @override
  void initState() {
    super.initState();
    final editorState = context.read<EditorCubit>().state;
    _value = editorState.getFigure(widget.name);
    _translation = editorState.getTranslationOrDefault();
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    if (value == null) return const SizedBox();
    final variations = value.variations.entries.toList();
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
                  label: Text(AppLocalizations.of(context).back),
                ),
                HorizontalTab(
                  icon: const Icon(PhosphorIconsLight.stack),
                  label: Text(AppLocalizations.of(context).variations),
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
                  SingleChildScrollView(
                    child: VisualEditingView(
                        value: value.back,
                        onChanged: (v) {
                          setState(() {
                            _value = value.copyWith(back: v);
                          });
                        }),
                  ),
                  Stack(
                    children: [
                      variations.isEmpty
                          ? Center(
                              child: Text(AppLocalizations.of(context).noData))
                          : ListView.builder(
                              itemCount: variations.length,
                              itemBuilder: (context, index) {
                                final variation = variations[index];
                                return ListTile(
                                  title: Text(variation.key),
                                  onTap: () async {
                                    final bloc = context.read<EditorCubit>();
                                    final result =
                                        await showDialog<VariationDefinition>(
                                      context: context,
                                      builder: (context) => BlocProvider.value(
                                        value: bloc,
                                        child: _FigureVariationEditorDialog(
                                          name: variation.key,
                                          value: variation.value,
                                        ),
                                      ),
                                    );
                                    if (result == null) return;
                                    setState(() {
                                      _value = value.copyWith.variations.put(
                                        variation.key,
                                        result,
                                      );
                                    });
                                  },
                                  trailing: IconButton(
                                    icon: const Icon(PhosphorIconsLight.trash),
                                    onPressed: () {
                                      setState(() {
                                        _value = value.copyWith.variations
                                            .remove(variation.key);
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
                            final result = await showDialog<String>(
                              context: context,
                              builder: (context) => NameDialog(
                                validator: defaultNameValidator(
                                  context,
                                  value.variations.keys.toList(),
                                ),
                              ),
                            );
                            if (result == null) return;
                            setState(() {
                              _value = value.copyWith.variations.put(
                                result,
                                VariationDefinition(texture: ''),
                              );
                            });
                          },
                          label: Text(AppLocalizations.of(context).create),
                          icon: Icon(PhosphorIconsLight.plus),
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
              context.read<EditorCubit>().setFigure(widget.name, value);
              context.read<EditorCubit>().setTranslation(
                    _translation,
                    widget.name,
                  );
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
  }
}

class _FigureVariationEditorDialog extends StatefulWidget {
  final String name;
  final VariationDefinition value;

  const _FigureVariationEditorDialog({
    required this.name,
    required this.value,
  });

  @override
  State<_FigureVariationEditorDialog> createState() =>
      __FigureVariationEditorDialogState();
}

class __FigureVariationEditorDialogState
    extends State<_FigureVariationEditorDialog> {
  late VariationDefinition _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(widget.name),
      constraints: const BoxConstraints(
          maxWidth: LeapBreakpoints.compact, maxHeight: 600),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).category,
              filled: true,
              icon: const Icon(PhosphorIconsLight.tag),
            ),
            initialValue: _value.category,
            onChanged: (value) {
              setState(() {
                _value = _value.copyWith(category: value);
              });
            },
          ),
          const SizedBox(height: 8),
          VisualEditingView(
            value: _value,
            onChanged: (v) => setState(() {
              _value = v;
            }),
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
            Navigator.of(context).pop(_value);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
