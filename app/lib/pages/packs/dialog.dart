import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/widgets/search.dart';
import 'package:setonix_api/setonix_api.dart';

part 'installed.dart';
part 'world.dart';
part 'editor.dart';

class PacksDialog extends StatefulWidget {
  final WorldBloc? bloc;

  const PacksDialog({
    super.key,
    this.bloc,
  });

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

typedef SelectFunction = Future<void> Function(
  Widget title,
  List<Widget> details,
  List<Widget> actions,
  String id,
);

class _PacksDialogState extends State<PacksDialog>
    with TickerProviderStateMixin {
  // It needs to be here to be able to reload it when clicking on import
  Future<Iterable<(SetonixFile, SetonixData, DataMetadata)>>? _packsFuture;
  ({
    Widget title,
    List<Widget> details,
    List<Widget> actions,
    String id
  })? _selected;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final TabController _tabController;
  late final SetonixFileSystem _fileSystem = context.read<SetonixFileSystem>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _packsFuture = _getPacks();
    _tabController = TabController(length: 3, vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _selected = null;
        });
      }
    });
  }

  Future<List<(SetonixFile, SetonixData, DataMetadata)>> _getPacks() async {
    final packs = <(SetonixFile, SetonixData, DataMetadata)>[];
    for (final pack in await _fileSystem.getPacks()) {
      final data = pack.load();
      final dataMeta =
          await _fileSystem.dataInfoSystem.getFile(pack.identifier) ??
              DataMetadata(addedAt: DateTime.now());
      packs.add((pack, data, dataMeta));
    }
    return packs;
  }

  void _reloadPacks() {
    if (mounted) {
      setState(() {
        _packsFuture = _getPacks();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool get isWorldLoaded => widget.bloc != null;

  void _unselect() {
    _controller.reverse();
  }

  Future<void> _select(bool isMobile, Widget title, List<Widget> details,
      List<Widget> actions, String id) async {
    _controller.forward();
    setState(() {
      _selected = (
        title: title,
        details: details,
        actions: actions,
        id: id,
      );
    });
    if (isMobile) {
      await showLeapBottomSheet(
        context: context,
        childrenBuilder: (context) => [
          ...details,
          const SizedBox(height: 16),
          ...actions,
        ],
        titleBuilder: (context) => title,
      );
      if (mounted) {
        _unselect();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.sizeOf(context).width;
    final isMobile = currentSize < LeapBreakpoints.medium;

    Future<void> select(Widget title, List<Widget> details,
            List<Widget> actions, String id) =>
        _select(isMobile, title, details, actions, id);

    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).packs),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 700,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabSearchView(
            tabController: _tabController,
            searchController: _searchController,
            onTabTap: (_) => _unselect(),
            tabs: [
              if (isWorldLoaded)
                HorizontalTab(
                  icon: const PhosphorIcon(PhosphorIconsLight.play),
                  label: Text(AppLocalizations.of(context).game),
                ),
              HorizontalTab(
                icon: const PhosphorIcon(PhosphorIconsLight.folder),
                label: Text(AppLocalizations.of(context).installed),
              ),
              HorizontalTab(
                icon: const PhosphorIcon(PhosphorIconsLight.globe),
                label: Text(AppLocalizations.of(context).browse),
              ),
              if (!isWorldLoaded)
                HorizontalTab(
                  icon: const PhosphorIcon(PhosphorIconsLight.notePencil),
                  label: Text(AppLocalizations.of(context).editor),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<
                Iterable<(SetonixFile, SetonixData, DataMetadata)>>(
              future: _packsFuture,
              builder: (context, snapshot) {
                final packs = snapshot.data ?? [];
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context).error,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 8),
                        Text(snapshot.error.toString()),
                      ],
                    ),
                  );
                }
                final view = ListenableBuilder(
                    listenable: _searchController,
                    builder: (context, _) {
                      final query = _searchController.text.toLowerCase();
                      final filtered = packs
                          .where((entry) =>
                              entry.$2
                                  .getMetadata()
                                  ?.name
                                  .toLowerCase()
                                  .contains(query) ??
                              entry.$1.identifier.toLowerCase().contains(query))
                          .where(
                              (e) => widget.bloc == null || e.$3.manuallyAdded)
                          .toList();
                      final bloc = widget.bloc;
                      final selected = _selected?.id;
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          if (bloc != null)
                            _WorldPacksView(
                              bloc: bloc,
                              query: query,
                            ),
                          _InstalledPacksView(
                            filtered: filtered,
                            bloc: bloc,
                            onSelected: select,
                            onReload: _reloadPacks,
                            onUnselect: _unselect,
                            selected: selected,
                          ),
                          Center(
                            child:
                                Text(AppLocalizations.of(context).comingSoon),
                          ),
                          if (bloc == null) _EditorPacksView(),
                        ],
                      );
                    });
                if (isMobile) {
                  return view;
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: view,
                    ),
                    SizeTransition(
                      sizeFactor: CurvedAnimation(
                        parent: _controller,
                        curve: Curves.fastOutSlowIn,
                      ),
                      axis: Axis.horizontal,
                      child: SizedBox(
                        width: 300,
                        child: Card(child: Builder(
                          builder: (context) {
                            final selected = _selected;
                            if (selected == null) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Header(
                                    title: selected.title,
                                    actions: [
                                      IconButton.outlined(
                                        icon: const Icon(PhosphorIconsLight.x),
                                        onPressed: _unselect,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView(children: selected.details),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: selected.actions,
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      headerActions: [
        /*IconButton(
          icon: Icon(_gridView
              ? PhosphorIconsLight.list
              : PhosphorIconsLight.gridFour),
          onPressed: () => setState(() => _gridView = !_gridView),
        ),
        const SizedBox(height: 32, child: VerticalDivider()),*/
        IconButton(
          tooltip: AppLocalizations.of(context).import,
          onPressed: () => importFile(
            context,
            context.read<SetonixFileSystem>(),
          ).then((_) => _reloadPacks()),
          icon: const Icon(PhosphorIconsLight.arrowSquareIn),
        ),
      ],
    );
  }
}
