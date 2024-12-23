part of 'dialog.dart';

class _WorldPacksView extends StatelessWidget {
  final WorldBloc bloc;
  final String query;

  const _WorldPacksView({
    required this.bloc,
    required this.query,
  });

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
            .where((entry) =>
                entry.value.getMetadataOrDefault().name.contains(query))
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
