import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/widgets/search.dart';
import 'package:setonix_api/setonix_api.dart';

class PacksDialog extends StatefulWidget {
  final WorldBloc? bloc;

  const PacksDialog({
    super.key,
    this.bloc,
  });

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

class _PacksDialogState extends State<PacksDialog>
    with TickerProviderStateMixin {
  bool _isMobileOpen = false;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final SetonixFileSystem _fileSystem = context.read<SetonixFileSystem>();
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  Future<List<(SetonixFile, SetonixData, DataMetadata)>>? _packsFuture;
  (SetonixFile, DataMetadata, bool)? _selectedPack;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _selectedPack = null;
          _isMobileOpen = false;
        });
      }
    });
    _packsFuture = _getPacks();
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _reloadPacks() {
    if (mounted) {
      setState(() {
        _packsFuture = _getPacks();
      });
    }
  }

  bool get isWorldLoaded => widget.bloc != null;

  List<Widget> _buildDetailsChildren(
      SetonixFile pack, FileMetadata metadata, DataMetadata data) {
    final locale = Localizations.localeOf(context).languageCode;
    final lastUsed = data.lastUsed();
    return [
      SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(data.manuallyAdded
                ? PhosphorIconsLight.plusSquare
                : PhosphorIconsLight.robot),
            const SizedBox(width: 8),
            Expanded(
              child: Text(data.manuallyAdded
                  ? AppLocalizations.of(context).manuallyAdded
                  : AppLocalizations.of(context).autoAdded),
            ),
            if (!data.manuallyAdded) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(PhosphorIconsLight.plusSquare),
                tooltip: AppLocalizations.of(context).addManually,
                onPressed: () {
                  final newData = data.copyWith(manuallyAdded: true);
                  _fileSystem.dataInfoSystem
                      .updateFile(pack.identifier, newData);
                  _reloadPacks();
                  setState(() => _selectedPack =
                      (pack, newData, _selectedPack?.$3 ?? true));
                },
              ),
            ],
            const SizedBox(width: 8),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(metadata.description),
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).size),
        subtitle: Text(pack.data.lengthInBytes.toString()),
      ),
      const SizedBox(height: 8),
      ListTile(
        title: Text(AppLocalizations.of(context).author),
        subtitle: Text(metadata.author),
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).version),
        subtitle: Text(metadata.version),
      ),
      const Divider(),
      ListTile(
        title: Text(AppLocalizations.of(context).installed),
        subtitle: Text(
            '${DateFormat.yMd(locale).format(data.addedAt)} ${DateFormat.Hm(locale).format(data.addedAt)}'),
      ),
      if (!data.manuallyAdded)
        ListTile(
          title: Text(AppLocalizations.of(context).lastUsed),
          subtitle: Text(
              '${DateFormat.yMd(locale).format(lastUsed)} ${DateFormat.Hm(locale).format(lastUsed)}'),
        ),
    ];
  }

  List<Widget> _buildActionsChildren(
    SetonixData pack, {
    VoidCallback? onInstall,
    VoidCallback? onRemove,
  }) =>
      [
        if (onInstall != null) ...[
          SizedBox(
            height: 42,
            child: FilledButton.tonalIcon(
              onPressed: onInstall,
              label: Text(AppLocalizations.of(context).install),
              icon: const Icon(PhosphorIconsLight.download),
            ),
          ),
        ],
        if (onRemove != null) ...[
          SizedBox(
            height: 42,
            child: FilledButton.tonalIcon(
              onPressed: onRemove,
              label: Text(AppLocalizations.of(context).remove),
              icon: const Icon(PhosphorIconsLight.trash),
            ),
          ),
        ],
      ];

  void _deselectPack() => _controller.reverse();

  Future<void> _removePack() async {
    _deselectPack();
    final pack = _selectedPack?.$1.identifier;
    if (pack == null) return;
    await _fileSystem.packSystem.deleteFile(pack);
    _reloadPacks();
  }

  bool _allowRemoving(String? id, bool? installed) =>
      id != kCorePackId && (installed ?? false);

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.sizeOf(context).width;
    final isMobile = currentSize < LeapBreakpoints.medium;
    Future<void> selectPack(
        SetonixFile file, DataMetadata data, bool installed) async {
      _controller.forward();
      setState(() {
        _selectedPack = (file, data, installed);
        _isMobileOpen = isMobile;
      });
      final pack = file.load();
      final metadata = pack.getMetadataOrDefault();
      if (isMobile) {
        await showLeapBottomSheet(
          context: context,
          childrenBuilder: (context) => [
            ..._buildDetailsChildren(file, metadata, data),
            const SizedBox(height: 16),
            ..._buildActionsChildren(
              pack,
              onInstall: installed ? null : _deselectPack,
              onRemove: _allowRemoving(file.identifier, installed)
                  ? _removePack
                  : null,
            ),
          ],
          titleBuilder: (context) => Text(metadata.name),
        );
        if (mounted) {
          _deselectPack();
        }
      }
    }

    final onInstall = _selectedPack?.$3 ?? false ? null : _deselectPack;
    final onRemove =
        _allowRemoving(_selectedPack?.$1.identifier, _selectedPack?.$3)
            ? _removePack
            : null;

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
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          if (bloc != null)
                            _WorldPacksView(
                              bloc: bloc,
                            ),
                          _InstalledPacksView(
                            filtered: filtered,
                            selectedPack: _selectedPack,
                            isMobile: isMobile,
                            isMobileOpen: _isMobileOpen,
                            bloc: bloc,
                            selectPack: selectPack,
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
                            final data = _selectedPack?.$1;
                            if (data == null) {
                              return const SizedBox();
                            }
                            final pack = data.load();
                            final metadata = pack.getMetadataOrDefault();
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: _selectedPack?.$1 == null
                                    ? []
                                    : [
                                        Header(
                                          title: Text(metadata.name),
                                          actions: [
                                            IconButton.outlined(
                                              icon: const Icon(
                                                  PhosphorIconsLight.x),
                                              onPressed: _deselectPack,
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children: _buildDetailsChildren(
                                              _selectedPack!.$1,
                                              metadata,
                                              _selectedPack!.$2,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: _buildActionsChildren(
                                            pack,
                                            onInstall: onInstall,
                                            onRemove: onRemove,
                                          ),
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
            _fileSystem,
          ).then((_) => _reloadPacks()),
          icon: const Icon(PhosphorIconsLight.arrowSquareIn),
        ),
      ],
    );
  }
}

class _InstalledPacksView extends StatelessWidget {
  final List<(SetonixFile, SetonixData, DataMetadata)> filtered;
  final (SetonixFile, DataMetadata, bool)? selectedPack;
  final void Function(SetonixFile, DataMetadata, bool) selectPack;
  final bool isMobile;
  final bool isMobileOpen;
  final WorldBloc? bloc;

  const _InstalledPacksView({
    required this.filtered,
    required this.selectedPack,
    required this.selectPack,
    required this.isMobile,
    required this.isMobileOpen,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final pack = filtered[index];
        final file = pack.$1;
        final key = file.identifier;
        final dataMeta = pack.$3;
        final metadata = file.load().getMetadata();
        return ListTile(
          title: Text(metadata?.name ?? AppLocalizations.of(context).unnamed),
          subtitle: Text(key),
          selected:
              selectedPack?.$1.identifier == key && (!isMobile || isMobileOpen),
          onTap: () => selectPack(pack.$1, dataMeta, true),
          leading: bloc != null
              ? BlocBuilder<WorldBloc, ClientWorldState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.info.packs != current.info.packs,
                  builder: (context, state) {
                    return IconButton.outlined(
                      icon: const Icon(PhosphorIconsLight.plus),
                      tooltip: AppLocalizations.of(context).addPack,
                      onPressed: state.info.packs.contains(key)
                          ? null
                          : () {
                              final packs = [
                                ...bloc!.state.info.packs,
                                key,
                              ];
                              bloc!.process(
                                PacksChangeRequest(packs),
                              );
                            },
                    );
                  })
              : null,
        );
      },
    );
  }
}

class _WorldPacksView extends StatelessWidget {
  const _WorldPacksView({
    required this.bloc,
  });

  final WorldBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, ClientWorldState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.info.packs != current.info.packs,
      builder: (context, state) {
        final loadedPacks = state.assetManager.packs.toList();
        final worldPacks = loadedPacks
            .where((entry) => state.info.packs.contains(entry.key))
            .toList();
        return ReorderableListView.builder(
          itemCount: worldPacks.length,
          itemBuilder: (context, index) {
            final entry = worldPacks[index];
            final id = entry.key;
            final data = entry.value;
            final metadata = data.getMetadata();
            return ListTile(
              key: ValueKey(id),
              title:
                  Text(metadata?.name ?? AppLocalizations.of(context).unnamed),
              subtitle: Text(id),
              leading: IconButton.outlined(
                icon: const Icon(PhosphorIconsLight.minus),
                tooltip: AppLocalizations.of(context).removePack,
                onPressed: () {
                  final packs = List<String>.from(state.info.packs)..remove(id);
                  bloc.process(
                    PacksChangeRequest(packs),
                  );
                },
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final packs = List<String>.from(state.info.packs);
            final pack = packs.removeAt(oldIndex);
            packs.insert(newIndex, pack);
            bloc.process(
              PacksChangeRequest(packs),
            );
          },
        );
      },
    );
  }
}

class _EditorPacksView extends StatelessWidget {
  const _EditorPacksView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text('Pack $index'),
            onTap: () => GoRouter.of(context).go('/editor/$index'));
      },
    );
  }
}
