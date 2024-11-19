import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/pages/home/background.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

class GameErrorView extends StatelessWidget {
  final MultiplayerDisconnectedState state;
  final VoidCallback onReconnect;

  const GameErrorView({
    super.key,
    required this.state,
    required this.onReconnect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = state.error;
    var message = AppLocalizations.of(context).disconnectedMessage;
    Widget? content;
    if (error is FatalServerEventError) {
      message = switch (error) {
        InvalidPacksError() => AppLocalizations.of(context).invalidPacks,
      };
      content = switch (error) {
        InvalidPacksError() =>
          _PacksGameErrorView(error: error, onReconnect: onReconnect),
      };
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const DotsBackground(),
          Card.filled(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: LeapBreakpoints.large,
              ),
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).disconnected,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                    if (content != null) ...[
                      const SizedBox(height: 16),
                      content,
                    ],
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilledButton(
                          onPressed: onReconnect,
                          child: Text(AppLocalizations.of(context).reconnect),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => GoRouter.of(context).go('/'),
                          child: Text(AppLocalizations.of(context).home),
                        ),
                      ],
                    ),
                    if (state.error != null) ...[
                      const SizedBox(height: 16),
                      Text(state.error.toString()),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PacksGameErrorView extends StatefulWidget {
  final InvalidPacksError error;
  final VoidCallback onReconnect;

  const _PacksGameErrorView({required this.error, required this.onReconnect});

  @override
  State<_PacksGameErrorView> createState() => _PacksGameErrorViewState();
}

class _PacksGameErrorViewState extends State<_PacksGameErrorView> {
  final List<int> _selectedUrls = [];
  final List<int> _excludedPacks = [];
  bool _currentlyDownloading = false;

  @override
  Widget build(BuildContext context) {
    final packs = widget.error.signature;
    return Column(children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: packs.length,
        itemBuilder: (context, index) {
          final pack = packs[index];
          final currentDownloadUrl = pack.downloadUrls
              .elementAtOrNull(_selectedUrls.elementAtOrNull(index) ?? 0);
          return CheckboxListTile(
            value: !_excludedPacks.contains(index),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _excludedPacks.remove(index);
                } else {
                  _excludedPacks.add(index);
                }
              });
            },
            title: Text(pack.metadata.name),
            subtitle: currentDownloadUrl != null
                ? Text(currentDownloadUrl)
                : Text(
                    AppLocalizations.of(context).noDownloadAvailable,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
            secondary: IconButton(
              onPressed: () => showLeapBottomSheet(
                context: context,
                titleBuilder: (context) => Text(pack.metadata.name),
                childrenBuilder: (context) => [
                  for (var i = 0; i < pack.downloadUrls.length; i++)
                    ListTile(
                      title: Text(pack.downloadUrls[i]),
                      onTap: () {
                        setState(() {
                          _selectedUrls[index] = i;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
              icon: Icon(PhosphorIconsLight.fadersHorizontal),
            ),
          );
        },
      ),
      Wrap(
        children: [
          if (packs.any((e) => e.downloadUrls.isNotEmpty))
            FilledButton(
              onPressed: _currentlyDownloading ? null : _download,
              child: Text(
                _excludedPacks.isEmpty
                    ? AppLocalizations.of(context).downloadAll
                    : AppLocalizations.of(context).downloadSelected,
              ),
            ),
        ],
      ),
    ]);
  }

  void _download() async {
    final packs = widget.error.signature;
    final context = this.context;
    setState(() {
      _currentlyDownloading = true;
    });
    final fileSystem = context.read<SetonixFileSystem>();
    final fetched = packs
        .asMap()
        .entries
        .where((e) =>
            !_excludedPacks.contains(e.key) && e.value.downloadUrls.isNotEmpty)
        .toList();
    final results = await Future.wait(
      fetched.map((e) => fileSystem.downloadPack(
          e.value.downloadUrls[_selectedUrls.elementAtOrNull(e.key) ?? 0],
          e.value.id)),
    );
    final success = results.every((e) => e.isSuccess);
    if (!context.mounted) return;
    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).downloadSuccess),
          content: Text(
            AppLocalizations.of(context).downloadSuccessMessage,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onReconnect();
              },
              child: Text(AppLocalizations.of(context).reconnect),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                GoRouter.of(context).go('/');
              },
              child: Text(AppLocalizations.of(context).home),
            ),
          ],
        ),
      );
    } else {
      // Combine packs with result
      final failed = fetched
          .where((e) {
            final result = results[e.key];
            return result != PackDownloadResult.success;
          })
          .map((e) => (
                metadata: e.value.metadata,
                id: e.value.id,
                result: results[e.key],
              ))
          .toList();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).downloadFailed),
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context).downloadFailedMessage,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: failed.length,
                itemBuilder: (context, index) {
                  final details = failed[index];
                  return ListTile(
                    title: Text('${details.metadata.name} (${details.id})'),
                    subtitle: Text(
                      switch (details.result) {
                        PackDownloadResult.invalidUri =>
                          AppLocalizations.of(context).invalidUri,
                        PackDownloadResult.downloadFailed =>
                          AppLocalizations.of(context).downloadFailed,
                        PackDownloadResult.invalidIdentifier =>
                          AppLocalizations.of(context).invalidIdentifier,
                        _ => '',
                      },
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                GoRouter.of(context).go('/');
              },
              child: Text(AppLocalizations.of(context).close),
            ),
          ],
        ),
      );
    }
  }
}
