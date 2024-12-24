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
