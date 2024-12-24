import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix/pages/editor/backgrounds.dart';
import 'package:setonix/pages/editor/decks.dart';
import 'package:setonix/pages/editor/figures.dart';
import 'package:setonix/pages/editor/general.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

const kEditorPath = '/editor/:name';

enum EditorPage {
  general(PhosphorIcons.house, ''),
  figures(PhosphorIcons.cube, '/figures'),
  decks(PhosphorIcons.stack, '/decks'),
  backgrounds(PhosphorIcons.image, '/backgrounds'),
  translations(PhosphorIcons.translate, '/translations');

  final IconGetter icon;
  final String location;

  const EditorPage(this.icon, this.location);

  String get fullLocation => '$kEditorPath$location';
  String get route => this == EditorPage.general ? 'editor' : 'editor-$name';

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

  Widget getPage() {
    return switch (this) {
      EditorPage.general => const GeneralEditorPage(),
      EditorPage.figures => const FiguresEditorPage(),
      EditorPage.decks => const DecksEditorPage(),
      EditorPage.backgrounds => const BackgroundsEditorPage(),
      EditorPage.translations => const GeneralEditorPage(),
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

  void _navigate(BuildContext context, EditorPage page) {
    final cubit = context.read<EditorCubit>();
    context.goNamed(page.route, pathParameters: {'name': cubit.path});
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: isMobile ? currentPage.index + 1 : currentPage.index,
      onDestinationSelected: (value) {
        if (isMobile && value == 0) {
          context.go('/');
        } else {
          _navigate(context, EditorPage.values[isMobile ? value - 1 : value]);
        }
      },
      children: [
        if (isMobile) ...[
          NavigationDrawerDestination(
            icon: Icon(PhosphorIconsLight.arrowLeft),
            label: Text(AppLocalizations.of(context).back),
          ),
          const Divider(),
        ],
        ...EditorPage.values.map((e) => NavigationDrawerDestination(
              icon: Icon(e.icon(PhosphorIconsStyle.light)),
              label: Text(e.getLocalizedName(context)),
              selectedIcon: Icon(e.icon(PhosphorIconsStyle.fill)),
            )),
      ],
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
    final name = widget.state.fullPath;
    final currentPage = EditorPage.values.firstWhere(
      (e) => e.fullLocation == name,
      orElse: () => EditorPage.general,
    );
    return BlocProvider(
      create: (context) =>
          EditorCubit(widget.name, context.read<SetonixFileSystem>(), data),
      child: Row(
        children: [
          if (!isMobile) ...[
            EditorNavigatorView(currentPage: currentPage),
            const SizedBox(width: 8)
          ],
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
