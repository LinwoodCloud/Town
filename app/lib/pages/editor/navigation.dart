import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum EditorPage {
  general,
  figures,
  decks,
  backgrounds,
  translations;

  IconGetter get icon => switch (this) {
        EditorPage.general => PhosphorIcons.house,
        EditorPage.figures => PhosphorIcons.cube,
        EditorPage.decks => PhosphorIcons.stack,
        EditorPage.backgrounds => PhosphorIcons.image,
        EditorPage.translations => PhosphorIcons.translate,
      };

  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      EditorPage.general => loc.general,
      EditorPage.figures => loc.figures,
      EditorPage.decks => loc.decks,
      EditorPage.backgrounds => loc.backgrounds,
      EditorPage.translations => loc.translations,
    };
  }
}

class EditorNavigatorView extends StatelessWidget {
  final EditorPage currentPage;

  const EditorNavigatorView({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: EditorPage.values
          .map((e) => NavigationRailDestination(
                icon: Icon(e.icon(PhosphorIconsStyle.light)),
                label: Text(e.getLocalizedName(context)),
                selectedIcon: Icon(e.icon(PhosphorIconsStyle.fill)),
              ))
          .toList(),
      selectedIndex: currentPage.index,
      labelType: NavigationRailLabelType.all,
    );
  }
}

class EditorScaffold extends StatelessWidget {
  final EditorPage currentPage;
  final Widget body;

  const EditorScaffold({
    super.key,
    required this.currentPage,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < LeapBreakpoints.medium;
    final navigator = EditorNavigatorView(currentPage: currentPage);
    return Row(
      children: [
        if (!isMobile) navigator,
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: Text(currentPage.getLocalizedName(context)),
            ),
            drawer: isMobile ? navigator : null,
            body: body,
          ),
        ),
      ],
    );
  }
}
