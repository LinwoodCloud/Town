part of 'dialog.dart';

class _InstalledPacksView extends StatefulWidget {
  final List<(SetonixFile, SetonixData, DataMetadata)> filtered;
  final String? selected;
  final SelectFunction onSelected;
  final VoidCallback onReload, onUnselect;
  final WorldBloc? bloc;

  const _InstalledPacksView({
    required this.filtered,
    required this.onSelected,
    required this.bloc,
    this.selected,
    required this.onReload,
    required this.onUnselect,
  });

  @override
  State<_InstalledPacksView> createState() => _InstalledPacksViewState();
}

class _InstalledPacksViewState extends State<_InstalledPacksView> {
  late final SetonixFileSystem _fileSystem = context.read<SetonixFileSystem>();

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
                  widget.onUnselect();
                  widget.onReload();
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
    VoidCallback? onRemove,
  }) =>
      [
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

  Future<void> _removePack() async {
    widget.onUnselect();
    final selected = widget.selected;
    if (selected == null) return;
    await _fileSystem.packSystem.deleteFile(selected);
    widget.onReload();
  }

  bool _allowRemoving(String? id, bool? installed) =>
      id != kCorePackId && (installed ?? false);

  void _select(
    String key,
    SetonixFile file,
    FileMetadata metadata,
    DataMetadata data,
  ) {
    widget.onSelected(
      Text(key),
      _buildDetailsChildren(
        file,
        metadata,
        data,
      ),
      _buildActionsChildren(
        file.load(),
        onRemove: _allowRemoving(key, true) ? _removePack : null,
      ),
      key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.filtered.length,
      itemBuilder: (context, index) {
        final pack = widget.filtered[index];
        final file = pack.$1;
        final key = file.identifier;
        final metadata = file.load().getMetadataOrDefault();
        return ListTile(
          title: Text(metadata.name),
          subtitle: Text(key),
          selected: widget.selected == key,
          onTap: () => _select(key, file, metadata, pack.$3),
          leading: widget.bloc != null
              ? BlocBuilder<WorldBloc, ClientWorldState>(
                  bloc: widget.bloc,
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
                                ...widget.bloc!.state.info.packs,
                                key,
                              ];
                              widget.bloc!.process(
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
