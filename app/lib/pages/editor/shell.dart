import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

const kEditorPath = '/editor/:name';

enum EditorPage {
  general(PhosphorIcons.house, ''),
  figures(PhosphorIcons.cube, 'figures'),
  decks(PhosphorIcons.stack, 'decks'),
  backgrounds(PhosphorIcons.image, 'backgrounds'),
  translations(PhosphorIcons.translate, 'translations');

  final IconGetter icon;
  final String location;

  const EditorPage(this.icon, this.location);

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
  final bool isMobile;

  const EditorNavigatorView({
    super.key,
    required this.currentPage,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return NavigationDrawer(
        selectedIndex: currentPage.index + 1,
        onDestinationSelected: (value) {},
        children: [
          NavigationDrawerDestination(
            icon: Icon(PhosphorIconsLight.arrowLeft),
            label: Text(AppLocalizations.of(context).back),
          ),
          const Divider(),
          ...EditorPage.values.map((e) => NavigationDrawerDestination(
                icon: Icon(e.icon(PhosphorIconsStyle.light)),
                label: Text(e.getLocalizedName(context)),
                selectedIcon: Icon(e.icon(PhosphorIconsStyle.fill)),
              )),
        ],
      );
    }
    return NavigationRail(
      destinations: EditorPage.values
          .map((e) => NavigationRailDestination(
                icon: Icon(e.icon(PhosphorIconsStyle.light)),
                label: Text(e.getLocalizedName(context)),
                selectedIcon: Icon(e.icon(PhosphorIconsStyle.fill)),
              ))
          .toList(),
      selectedIndex: currentPage.index,
      extended: true,
    );
  }
}

class EditorShell extends StatefulWidget {
  final Widget child;
  final GoRouterState state;
  final String name;

  const EditorShell({
    super.key,
    required this.child,
    required this.state,
    required this.name,
  });

  @override
  State<EditorShell> createState() => _EditorShellState();
}

class _EditorShellState extends State<EditorShell> {
  Future<SetonixData?>? _data;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() => _data =
      context.read<SetonixFileSystem>().editorSystem.getFile(widget.name);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).loading),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).error),
            ),
            body: Center(
              child: Text(
                snapshot.error.toString(),
              ),
            ),
          );
        }
        final data = snapshot.data;
        if (data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).error),
            ),
            body: Center(
              child: Text(AppLocalizations.of(context).noData),
            ),
          );
        }
        return _buildContent(context, data);
      },
    );
  }

  Widget _buildContent(BuildContext context, SetonixData data) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < LeapBreakpoints.medium;
    final location = widget.state.path?.substring(kEditorPath.length + 1);
    final currentPage = EditorPage.values.firstWhere(
      (e) => e.location == location,
      orElse: () => EditorPage.general,
    );
    return BlocProvider(
      create: (context) => EditorCubit(widget.name, data),
      child: Row(
        children: [
          if (!isMobile) EditorNavigatorView(currentPage: currentPage),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(currentPage.getLocalizedName(context)),
              ),
              drawer: isMobile
                  ? EditorNavigatorView(
                      currentPage: currentPage,
                      isMobile: true,
                    )
                  : null,
              body: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
