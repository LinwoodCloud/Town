part of 'dialog.dart';

class _EditorPacksView extends StatefulWidget {
  final VoidCallback onReload;

  const _EditorPacksView({
    required this.onReload,
  });

  @override
  State<_EditorPacksView> createState() => _EditorPacksViewState();
}

class _EditorPacksViewState extends State<_EditorPacksView> {
  late final SetonixFileSystem _fileSystem = context.read<SetonixFileSystem>();
  Future<List<FileSystemFile<SetonixData>>>? _packs;

  @override
  void initState() {
    super.initState();
    _packs = _fileSystem.editorSystem.getFiles();
  }

  void _reloadPacks() {
    setState(() {
      _packs = _fileSystem.editorSystem.getFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<FileSystemFile<SetonixData>>>(
            future: _packs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              final files = snapshot.data ?? [];
              if (files.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context).noData),
                );
              }
              return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  final data = file.data!;
                  final metadata = data.getMetadataOrDefault();
                  return ContextRegion(
                    builder: (context, widget, controller) {
                      return ListTile(
                        title: Text(metadata.name),
                        subtitle: Text(file.identifier),
                        onTap: () => GoRouter.of(context)
                            .goNamed('editor', pathParameters: {
                          'name': file.pathWithoutLeadingSlash,
                        }),
                        trailing: widget,
                      );
                    },
                    menuChildren: [
                      MenuItemButton(
                        leadingIcon: const Icon(PhosphorIconsLight.download),
                        child: Text(AppLocalizations.of(context).install),
                        onPressed: () async {
                          await importFileData(context, _fileSystem,
                              SetonixFile(data.exportAsBytes()));
                          widget.onReload();
                        },
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(PhosphorIconsLight.export),
                        child: Text(AppLocalizations.of(context).export),
                        onPressed: () async {
                          exportData(
                            context,
                            data,
                            metadata.name,
                          );
                        },
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(PhosphorIconsLight.trash),
                        child: Text(AppLocalizations.of(context).delete),
                        onPressed: () async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                                  Text(AppLocalizations.of(context).removePack),
                              content: Text(AppLocalizations.of(context)
                                  .removePackMessage(file.identifier)),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child:
                                      Text(AppLocalizations.of(context).cancel),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child:
                                      Text(AppLocalizations.of(context).remove),
                                ),
                              ],
                            ),
                          );
                          if (!(result ?? false)) return;
                          await _fileSystem.editorSystem
                              .deleteFile(file.identifier);
                          _reloadPacks();
                        },
                      ),
                    ],
                  );
                },
              );
            }),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
            onPressed: () async {
              final name = await showDialog(
                  context: context, builder: (context) => NameDialog());
              if (name == null) return;
              await _fileSystem.editorSystem.createFile(
                  name,
                  SetonixData.empty().setMetadata(FileMetadata(
                    name: name,
                    type: FileType.pack,
                  )));
              _reloadPacks();
            },
            label: Text(AppLocalizations.of(context).create),
            icon: const Icon(PhosphorIconsLight.plus),
          ),
        ),
      ],
    );
  }
}
