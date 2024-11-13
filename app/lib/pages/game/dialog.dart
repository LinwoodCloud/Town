import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix_api/setonix_api.dart';

class GameDialogOverlay extends StatelessWidget {
  const GameDialogOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
      buildWhen: (previous, current) =>
          previous.world.dialogs.firstOrNull !=
              current.world.dialogs.firstOrNull ||
          previous.world.images != current.world.images,
      builder: (context, state) {
        final dialog = state.world.dialogs.firstOrNull;
        if (dialog == null) {
          return const SizedBox();
        }
        var value = GameDialogValue();
        void updateValue(GameDialogValue newValue) {
          value = newValue;
        }

        void submitValue([GameDialogValue? newValue]) {
          context.read<WorldBloc>().process(
                DialogCloseRequest(dialog.id, newValue),
              );
        }

        final image = state.world.images[dialog.image];

        final header = image == null ? null : Image.memory(image, height: 200);

        final isMobile =
            MediaQuery.of(context).size.width < LeapBreakpoints.medium;

        return Stack(
          children: [
            GestureDetector(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              onTap: () {
                submitValue();
              },
            ),
            ResponsiveAlertDialog(
              title: Text(dialog.title),
              leading: IconButton.outlined(
                icon: const Icon(PhosphorIconsLight.x),
                onPressed: () => submitValue(),
              ),
              constraints: BoxConstraints(
                  maxWidth: header == null
                      ? LeapBreakpoints.medium
                      : LeapBreakpoints.expanded),
              content: Row(
                children: [
                  if (!isMobile && header != null) Expanded(child: header),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: dialog.components.length + 1,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, cIndex) {
                          if (cIndex == 0) {
                            return Column(
                              children: [
                                if (isMobile && header != null) header,
                                Card.filled(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Icon(PhosphorIconsLight.warning),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .thirdPartyContent,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          cIndex--;
                          final component = dialog.components[cIndex];
                          switch (component) {
                            case GameDialogMarkdownComponent():
                              return MarkdownBody(
                                extensionSet: md.ExtensionSet(
                                  md.ExtensionSet.gitHubWeb.blockSyntaxes,
                                  <md.InlineSyntax>[
                                    md.EmojiSyntax(),
                                    ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                                  ],
                                ),
                                data: component.content,
                              );
                            case GameDialogTextFieldComponent():
                              final multiline =
                                  component.multiline && !component.password;
                              final initialValue = value
                                  .getValue(component.idOrLabel)
                                  .getAsString();
                              void updateComponent(
                                String text,
                              ) =>
                                  updateValue(
                                    value.copyWith.values.put(
                                      component.idOrLabel,
                                      GameDialogTextFieldValue(
                                        value: text,
                                        component: cIndex,
                                      ),
                                    ),
                                  );
                              updateComponent(initialValue);
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: component.label,
                                  hintText: component.placeholder,
                                  filled: !multiline,
                                  border: multiline
                                      ? const OutlineInputBorder()
                                      : null,
                                ),
                                maxLines: multiline ? null : 1,
                                obscureText: component.password,
                                initialValue: initialValue,
                                onChanged: updateComponent,
                              );
                          }
                        }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    submitValue();
                  },
                  child: Text(AppLocalizations.of(context).cancel),
                ),
                ...(dialog.actions?.mapIndexed((index, action) {
                      return ElevatedButton(
                        onPressed: () {
                          submitValue(
                            value.copyWith(buttonPressed: action.idOrLabel),
                          );
                        },
                        child: Text(action.label),
                      );
                    }) ??
                    [
                      ElevatedButton(
                        onPressed: () {
                          submitValue();
                        },
                        child: Text(AppLocalizations.of(context).save),
                      ),
                    ]),
              ],
            ),
          ],
        );
      },
    );
  }
}
