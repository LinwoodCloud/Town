import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/pages/editor/navigation.dart';

class GeneralEditorPage extends StatelessWidget {
  final String name;

  const GeneralEditorPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return EditorScaffold(
      currentPage: EditorPage.general,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: LeapBreakpoints.expanded),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).name,
                    filled: true,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).version,
                    filled: true,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).description,
                    border: OutlineInputBorder(),
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
