import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/pages/home/background.dart';
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
        InvalidPacksError() => _PacksGameErrorView(error: error),
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
  const _PacksGameErrorView({required this.error});

  @override
  State<_PacksGameErrorView> createState() => _PacksGameErrorViewState();
}

class _PacksGameErrorViewState extends State<_PacksGameErrorView> {
  final List<int> _selectedUrls = [];

  @override
  Widget build(BuildContext context) {
    final packs = widget.error.signature;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: packs.length + 1,
      itemBuilder: (context, index) {
        if (index == packs.length) {
          return Wrap(
            children: [
              if (packs.any((e) => e.downloadUrls.isNotEmpty))
                FilledButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context).downloadAll),
                ),
            ],
          );
        }
        final pack = packs[index];
        final currentDownloadUrl = pack.downloadUrls
            .elementAtOrNull(_selectedUrls.elementAtOrNull(index) ?? 0);
        return ListTile(
          title: Text(pack.metadata.name),
          subtitle: Text(currentDownloadUrl ?? ''),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(PhosphorIconsLight.downloadSimple),
          ),
        );
      },
    );
  }
}
