import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix_api/setonix_api.dart';

class GeneralEditorPage extends StatelessWidget {
  const GeneralEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: LeapBreakpoints.expanded),
          padding: const EdgeInsets.all(4),
          child: BlocBuilder<EditorCubit, SetonixData>(
            builder: (context, state) {
              final metadata = state.getMetadataOrDefault();
              var currentName = metadata.name,
                  currentAuthor = metadata.author,
                  currentVersion = metadata.version,
                  currentDescription = metadata.description;
              void updateMeta() => context.read<EditorCubit>().updateMeta(
                    metadata.copyWith(
                      name: currentName,
                      author: currentAuthor,
                      version: currentVersion,
                      description: currentDescription,
                    ),
                  );
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).name,
                      filled: true,
                      icon: const Icon(PhosphorIconsLight.textT),
                    ),
                    initialValue: currentName,
                    onChanged: (value) {
                      currentName = value;
                      updateMeta();
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).author,
                      filled: true,
                      icon: const Icon(PhosphorIconsLight.user),
                    ),
                    initialValue: currentAuthor,
                    onChanged: (value) {
                      currentAuthor = value;
                      updateMeta();
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).version,
                      filled: true,
                      icon: const Icon(PhosphorIconsLight.info),
                    ),
                    initialValue: currentVersion,
                    onChanged: (value) {
                      currentVersion = value;
                      updateMeta();
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).description,
                      border: OutlineInputBorder(),
                      icon: const Icon(PhosphorIconsLight.article),
                    ),
                    initialValue: currentDescription,
                    onChanged: (value) {
                      currentDescription = value;
                      updateMeta();
                    },
                    minLines: 3,
                    maxLines: 5,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
