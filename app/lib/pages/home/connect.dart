import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix/widgets/search.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:rxdart/rxdart.dart';

void _connect(BuildContext context, String address, bool secure) {
  Navigator.of(context).pop();
  GoRouter.of(context).goNamed('connect', queryParameters: {
    'address': address,
    'secure': secure.toString(),
  });
}

class ConnectEditDialog extends StatelessWidget {
  final ListGameServer? initialValue;
  final int? index;

  const ConnectEditDialog({
    super.key,
    this.initialValue,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    String address = initialValue?.address ?? '';
    String name = initialValue?.name ?? '';
    bool secure = initialValue?.secure ?? true;

    final secureSwitchEnabled = !kIsWeb || Uri.base.isScheme('HTTP');

    void connect() {
      _connect(context, address, secure);
    }

    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).connect),
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
      ),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).connectNote),
          const SizedBox(height: 16),
          if (index != null) ...[
            TextFormField(
              initialValue: name,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                filled: true,
              ),
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            initialValue: address,
            onChanged: (value) => address = value,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).address,
              filled: true,
            ),
            onFieldSubmitted: index == null ? (_) => connect() : null,
          ),
          const SizedBox(height: 8),
          if (secureSwitchEnabled)
            StatefulBuilder(
              builder: (context, setState) => SwitchListTile(
                title: Text(AppLocalizations.of(context).secure),
                value: secure,
                onChanged: (value) => setState(() => secure = value),
              ),
            ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            final cubit = context.read<SettingsCubit>();
            var updated = initialValue ?? ListGameServer(address: '');
            updated = updated.copyWith(
              address: address,
              secure: secure,
              name: name,
            );
            if (index != null) {
              cubit.updateServer(index!, updated);
            } else {
              cubit.addServer(updated);
            }
            Navigator.of(context).pop();
          },
          label: Text(AppLocalizations.of(context).save),
          icon: const Icon(PhosphorIconsLight.floppyDisk),
        ),
        if (index == null)
          FilledButton.icon(
            onPressed: connect,
            label: Text(AppLocalizations.of(context).connect),
            icon: const Icon(PhosphorIconsLight.link),
          ),
      ],
    );
  }
}

class ServersDialog extends StatefulWidget {
  const ServersDialog({super.key});

  @override
  State<ServersDialog> createState() => _ServersDialogState();
}

class _ServersDialogState extends State<ServersDialog> {
  late final Stream<Map<GameServer, GameProperty?>> _servers;

  bool _isMobileOpen = false;
  (GameServer, int)? _selected;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _servers = ValueConnectableStream(
            context.read<NetworkService>().fetchServersWithProperties())
        .autoConnect();
  }

  _buildDetails(BuildContext context, GameProperty property) =>
      Text('${property.currentPlayers}/${property.maxPlayers ?? '?'}');

  _buildDetailsChildren(GameProperty server) => [
        ListTile(
          title: Text(AppLocalizations.of(context).description),
          subtitle: Text(server.description),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SetonixSettings>(
      buildWhen: (previous, current) =>
          previous.showConnectYour != current.showConnectYour ||
          previous.showConnectNetwork != current.showConnectNetwork,
      builder: (context, settings) => ResponsiveAlertDialog(
        title: Text(AppLocalizations.of(context).connect),
        leading: IconButton.outlined(
          icon: const Icon(PhosphorIconsLight.x),
          onPressed: () => Navigator.of(context).pop(),
        ),
        constraints: const BoxConstraints(
          maxWidth: LeapBreakpoints.expanded,
          maxHeight: 700,
        ),
        content: StreamBuilder<Map<GameServer, GameProperty?>>(
            stream: _servers,
            builder: (context, snapshot) {
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
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final allServers = snapshot.data!;
              final servers = allServers.entries
                  .where((server) =>
                      server.key.display.toLowerCase().contains(_search))
                  .toList();
              final isMobile =
                  MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
              final property = allServers.containsKey(_selected?.$1)
                  ? (allServers[_selected?.$1] ?? const GameProperty())
                  : null;
              final server = _selected?.$1 ?? ListGameServer(address: '');
              final playButton = SizedBox(
                height: 48,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(PhosphorIconsLight.play),
                        label: Text(AppLocalizations.of(context).play),
                        onPressed: () =>
                            _connect(context, server.address, server.secure),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        IconButton.outlined(
                          icon: const Icon(PhosphorIconsLight.pencil),
                          tooltip: AppLocalizations.of(context).edit,
                          onPressed: () {
                            if (server is! ListGameServer) return;
                            showDialog<bool>(
                              context: context,
                              builder: (context) => ConnectEditDialog(
                                initialValue: server,
                                index: _selected!.$2,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton.outlined(
                          icon: const Icon(PhosphorIconsLight.trash),
                          tooltip: AppLocalizations.of(context).delete,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                  AppLocalizations.of(context).deleteServer),
                              content: Text(AppLocalizations.of(context)
                                  .deleteServerMessage),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child:
                                      Text(AppLocalizations.of(context).cancel),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_selected != null) {
                                      context
                                          .read<SettingsCubit>()
                                          .removeServer(_selected!.$2);
                                    }
                                    Navigator.of(context).pop();
                                    if (_isMobileOpen) {
                                      Navigator.of(context).pop();
                                    }
                                    _selected = null;
                                  },
                                  child:
                                      Text(AppLocalizations.of(context).delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
              final listView = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: servers.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context).noServers))
                        : ListView.builder(
                            itemCount: servers.length,
                            itemBuilder: (context, index) {
                              final entry = servers[index];
                              final current = entry.key;
                              return ListTile(
                                title: Text(current.display),
                                leading: switch (current) {
                                  LanGameServer() =>
                                    const Icon(PhosphorIconsLight.globe),
                                  _ => null,
                                },
                                onTap: () {
                                  setState(() {
                                    _selected = (current, index);
                                    _isMobileOpen = isMobile;
                                  });
                                  if (isMobile) {
                                    showLeapBottomSheet(
                                      context: context,
                                      titleBuilder: (context) =>
                                          Text(server.display),
                                      actionsBuilder: (context) => [
                                        if (property != null) ...[
                                          DefaultTextStyle(
                                            style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall ??
                                                const TextStyle(fontSize: 20),
                                            child: _buildDetails(
                                                context, property),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      ],
                                      childrenBuilder: (context) => [
                                        ..._buildDetailsChildren(entry.value ??
                                            const GameProperty()),
                                        const SizedBox(height: 16),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: playButton,
                                        ),
                                      ],
                                    ).then((_) {
                                      if (mounted) {
                                        setState(() => _isMobileOpen = false);
                                      }
                                    });
                                  }
                                },
                                selected: server == current &&
                                    (!isMobile || _isMobileOpen),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: const Icon(PhosphorIconsLight.plus),
                      label: Text(AppLocalizations.of(context).create),
                      onPressed: () => showDialog<bool>(
                        context: context,
                        builder: (context) => const ConnectEditDialog(),
                      ),
                    ),
                  ),
                ],
              );
              return Column(
                children: [
                  RowSearchView(
                      onSearchChanged: (value) => setState(() {
                            _search = value;
                          }),
                      children: const [
                        /*  InputChip(
                        label: Text(AppLocalizations.of(context).yourServers),
                        avatar: const Icon(PhosphorIconsLight.puzzlePiece),
                        showCheckmark: false,
                        selected: settings.showConnectYour,
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .changeShowConnectYour(!settings.showConnectYour),
                      ),
                      InputChip(
                        label: Text(AppLocalizations.of(context).inNetwork),
                        avatar: const Icon(PhosphorIconsLight.globe),
                        showCheckmark: false,
                        selected: settings.showConnectNetwork,
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .changeShowConnectNetwork(
                                !settings.showConnectNetwork),
                      ), */
                      ]),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: listView),
                        if (!isMobile) ...[
                          const VerticalDivider(),
                          Expanded(
                              child: property == null
                                  ? Center(
                                      child: Text(AppLocalizations.of(context)
                                          .selectServer),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DefaultTextStyle(
                                            style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge ??
                                                const TextStyle(),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    server.display,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                _buildDetails(
                                                    context, property),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children:
                                                _buildDetailsChildren(property),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        playButton,
                                      ],
                                    )),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
