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
