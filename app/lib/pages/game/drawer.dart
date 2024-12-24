import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/settings.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/helpers/visualizer.dart';
import 'package:setonix/pages/game/info.dart';
import 'package:setonix/pages/game/multiplayer.dart';
import 'package:setonix/pages/game/team.dart';
import 'package:setonix/pages/packs/dialog.dart';
import 'package:setonix_api/setonix_api.dart';

class GameDrawer extends StatelessWidget {
  const GameDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            BlocBuilder<WorldBloc, ClientWorldState>(
              buildWhen: (previous, current) =>
                  previous.name != current.name ||
                  previous.metadata != current.metadata,
              builder: (context, state) {
                final metadata = state.metadata;
                return Card.filled(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            metadata.name,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall,
                          ),
                          if (metadata.description.isNotEmpty)
                            Text(
                              metadata.description,
                              maxLines: 5,
                            ),
                        ],
                      ),
                    ),
                    onTap: () {
                      final bloc = context.read<WorldBloc>();
                      showLeapBottomSheet(
                        context: context,
                        titleBuilder: (context) => Text(metadata.name),
                        actionsBuilder: (context) => [
                          IconButton(
                            icon: const Icon(PhosphorIconsLight.pencil),
                            tooltip: AppLocalizations.of(context).editInfo,
                            onPressed: () async {
                              final newInfo = await showDialog<FileMetadata>(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                        value: bloc,
                                        child: EditInfoDialog(
                                          value: metadata,
                                        ),
                                      ));
                              if (newInfo == null) return;
                              bloc.process(MetadataChanged(newInfo.copyWith(
                                type: metadata.type,
                              )));
                            },
                          ),
                        ],
                        childrenBuilder: (context) => [
                          BlocBuilder<WorldBloc, ClientWorldState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous.metadata != current.metadata,
                            builder: (context, state) =>
                                Text(state.metadata.description),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(PhosphorIconsLight.arrowLeft),
              title: Text(MaterialLocalizations.of(context).backButtonTooltip),
              onTap: () => Scaffold.of(context).closeDrawer(),
            ),
            BlocBuilder<WorldBloc, ClientWorldState>(
              buildWhen: (previous, current) =>
                  previous.switchCellOnMove != current.switchCellOnMove,
              builder: (context, state) {
                return SwitchListTile(
                  value: state.switchCellOnMove,
                  title: Text(AppLocalizations.of(context).switchCellOnMove),
                  secondary: const Icon(PhosphorIconsLight.selection),
                  onChanged: (value) {
                    context
                        .read<WorldBloc>()
                        .process(SwitchCellOnMoveChanged(value));
                  },
                );
              },
            ),
            BlocBuilder<SettingsCubit, SetonixSettings>(
              buildWhen: (previous, current) => previous.zoom != current.zoom,
              builder: (context, state) => ListTile(
                leading: const Icon(PhosphorIconsLight.magnifyingGlass),
                title: Text(
                  AppLocalizations.of(context).zoom,
                ),
                subtitle: Text(
                  '${(state.zoom * 100).toStringAsFixed(0)}%',
                ),
                onTap: () {
                  final settingsCubit = context.read<SettingsCubit>();
                  showLeapBottomSheet(
                    context: context,
                    titleBuilder: (context) =>
                        Text(AppLocalizations.of(context).zoom),
                    childrenBuilder: (context) => [
                      ExactSlider(
                        value: state.zoom * 100,
                        onChangeEnd: (value) =>
                            settingsCubit.resetZoom(value / 100),
                        min: 40,
                        max: 200,
                        fractionDigits: 0,
                      ),
                    ],
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(PhosphorIconsLight.minus),
                      tooltip: AppLocalizations.of(context).zoomOut,
                      onPressed: () => context.read<SettingsCubit>().zoomOut(),
                    ),
                    IconButton(
                      icon: const Icon(PhosphorIconsLight.plus),
                      tooltip: AppLocalizations.of(context).zoomIn,
                      onPressed: () => context.read<SettingsCubit>().zoomIn(),
                    ),
                    IconButton(
                      icon: const Icon(PhosphorIconsLight.clockClockwise),
                      tooltip: AppLocalizations.of(context).resetZoom,
                      onPressed: () =>
                          context.read<SettingsCubit>().resetZoom(),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<MultiplayerCubit, MultiplayerState>(
                builder: (context, state) {
              if (!state.isServer) return SizedBox.shrink();
              return ListTile(
                leading: const Icon(PhosphorIconsLight.package),
                title: Text(AppLocalizations.of(context).packs),
                onTap: () {
                  final bloc = context.read<WorldBloc>();
                  showDialog(
                    builder: (context) => PacksDialog(
                      bloc: bloc,
                    ),
                    context: context,
                  );
                },
              );
            }),
            BlocBuilder<WorldBloc, ClientWorldState>(
              buildWhen: (previous, current) =>
                  previous.tableName != current.tableName,
              builder: (context, state) => ListTile(
                  leading: const Icon(PhosphorIconsLight.gridFour),
                  title: Text(AppLocalizations.of(context).table),
                  subtitle: Text(state.tableName.isEmpty
                      ? AppLocalizations.of(context).defaultTable
                      : state.tableName),
                  onTap: () => _showTableDialog(context, state)),
            ),
            BlocBuilder<WorldBloc, ClientWorldState>(
              buildWhen: (previous, current) =>
                  previous.table.background != current.table.background,
              builder: (context, state) {
                final bloc = context.read<WorldBloc>();
                final assetManager = state.assetManager;
                final background = state.table.background;
                return ListTile(
                    leading: const Icon(PhosphorIconsLight.image),
                    title: Text(AppLocalizations.of(context).background),
                    subtitle: background == null
                        ? null
                        : Text(assetManager
                            .getTranslations(background.namespace)
                            .getBackgroundTranslation(background.id)
                            .name),
                    onTap: () => showLeapBottomSheet(
                        context: context,
                        titleBuilder: (context) =>
                            Text(AppLocalizations.of(context).background),
                        childrenBuilder: (context) => bloc.state.packs
                                .expand(
                                    (e) => e.value.getBackgroundItems(e.key))
                                .sorted((a, b) =>
                                    b.item.priority.compareTo(a.item.priority))
                                .map((entry) {
                              final translation = assetManager
                                  .getTranslations(entry.namespace)
                                  .getBackgroundTranslation(entry.id);
                              return ListTile(
                                title: Text(translation.name),
                                subtitle: translation.description == null
                                    ? null
                                    : Text(translation.description!),
                                onTap: () {
                                  bloc.process(
                                      BackgroundChanged(entry.location));
                                  Navigator.of(context).pop();
                                },
                                selected: background == entry.location,
                              );
                            }).toList()));
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIconsLight.flag),
              title: Text(AppLocalizations.of(context).teams),
              onTap: () {
                final bloc = context.read<WorldBloc>();
                showLeapBottomSheet(
                  context: context,
                  titleBuilder: (context) =>
                      Text(AppLocalizations.of(context).teams),
                  actionsBuilder: (context) => [
                    IconButton(
                      icon: const Icon(PhosphorIconsLight.plusCircle),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                              value: bloc, child: const TeamDialog())),
                    ),
                  ],
                  childrenBuilder: (context) => [
                    BlocBuilder<WorldBloc, ClientWorldState>(
                      buildWhen: (previous, current) =>
                          previous.info.teams != current.info.teams ||
                          previous.teamMembers != current.teamMembers,
                      bloc: bloc,
                      builder: (context, state) {
                        if (state.info.teams.isEmpty) {
                          return Center(
                              child:
                                  Text(AppLocalizations.of(context).noTeams));
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: state.info.teams.entries.map((entry) {
                            final name = entry.key;
                            final team = entry.value;
                            final color = team.color;
                            final selected =
                                state.teamMembers[name]?.contains(state.id) ??
                                    false;
                            return ListTile(
                              title: Text(entry.key),
                              leading: ColorButton(
                                color: color?.color ?? Colors.transparent,
                                size: 24,
                              ),
                              selected: selected,
                              trailing: MenuAnchor(
                                builder: defaultMenuButton(),
                                menuChildren: [
                                  MenuItemButton(
                                    leadingIcon:
                                        const Icon(PhosphorIconsLight.pencil),
                                    child:
                                        Text(AppLocalizations.of(context).edit),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: bloc,
                                          child: TeamDialog(
                                              team: name, data: team),
                                        ),
                                      );
                                    },
                                  ),
                                  MenuItemButton(
                                    leadingIcon:
                                        const Icon(PhosphorIconsLight.trash),
                                    child: Text(
                                        AppLocalizations.of(context).delete),
                                    onPressed: () {
                                      bloc.process(TeamRemoved(name));
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                if (selected) {
                                  bloc.process(TeamLeaveRequest(name));
                                } else {
                                  bloc.process(TeamJoinRequest(name));
                                }
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(PhosphorIconsLight.users),
              title: Text(AppLocalizations.of(context).multiplayer),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                final multiplayer = context.read<MultiplayerCubit>();
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                      value: multiplayer, child: const MultiplayerDialog()),
                );
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIconsLight.chat),
              title: Text(AppLocalizations.of(context).chat),
              onTap: () {
                context
                    .read<WorldBloc>()
                    .process(DrawerViewChanged(DrawerView.chat));
                Scaffold.of(context).openEndDrawer();
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIconsLight.file),
              title: Text(AppLocalizations.of(context).notes),
              onTap: () {
                context
                    .read<WorldBloc>()
                    .process(DrawerViewChanged(DrawerView.notes));
                Scaffold.of(context).openEndDrawer();
              },
            ),
            ListTile(
                leading: const Icon(PhosphorIconsLight.fileArchive),
                title: Text(AppLocalizations.of(context).saveAsTemplate),
                onTap: () async {
                  final bloc = context.read<WorldBloc>();
                  String name = '';
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context).saveAsTemplate),
                      content: TextField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).name,
                          hintText: AppLocalizations.of(context).enterName,
                          filled: true,
                        ),
                        onChanged: (value) => name = value,
                        onSubmitted: (value) => Navigator.of(context).pop(true),
                        autofocus: true,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(AppLocalizations.of(context).cancel),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(AppLocalizations.of(context).save),
                        ),
                      ],
                    ),
                  );
                  if (!(result ?? false)) return;
                  final state = bloc.state;
                  var data = state.world.save();
                  data = data.setFileMetadata(data
                      .getMetadataOrDefault()
                      .copyWith(name: name, type: FileType.template));
                  state.fileSystem.templateSystem.createFile(name, data);
                }),
            ListTile(
              leading: const Icon(PhosphorIconsLight.gear),
              title: Text(AppLocalizations.of(context).settings),
              onTap: () => openSettings(context),
            ),
            ListTile(
              leading: const Icon(PhosphorIconsLight.door),
              title: Text(AppLocalizations.of(context).home),
              onTap: () => GoRouter.of(context).go('/'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTableDialog(BuildContext context, ClientWorldState state) {
    final bloc = context.read<WorldBloc>();
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).table),
      actionsBuilder: (context) => [
        IconButton(
          icon: const Icon(PhosphorIconsLight.arrowsLeftRight),
          tooltip: AppLocalizations.of(context).switchTable,
          onPressed: () async {
            String name = '';
            final result = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context).switchTable),
                content: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).name,
                    hintText: AppLocalizations.of(context).enterName,
                    filled: true,
                  ),
                  onChanged: (value) => name = value,
                  onSubmitted: (value) => Navigator.of(context).pop(true),
                  autofocus: true,
                ),
                actions: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(false),
                    label: Text(AppLocalizations.of(context).cancel),
                    icon: const Icon(PhosphorIconsLight.prohibit),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    label: Text(AppLocalizations.of(context).change),
                    icon: const Icon(PhosphorIconsLight.check),
                  ),
                ],
              ),
            );
            if (!(result ?? false)) return;
            bloc.process(TableSwitched(name));
          },
        ),
      ],
      childrenBuilder: (context) => [
        BlocBuilder<WorldBloc, ClientWorldState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous.tableName != current.tableName ||
              previous.data != current.data,
          builder: (context, state) {
            final other = {...state.data.getTables(), state.tableName}
                .where((e) => e.isNotEmpty)
                .toList();
            return Column(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).defaultTable),
                  selected: state.tableName == '',
                  onTap: () => bloc.process(TableSwitched()),
                ),
                if (other.isNotEmpty) const Divider(),
                ...other.map(
                  (e) => ListTile(
                    title: Text(e),
                    selected: state.tableName == e,
                    onTap: () => bloc.process(TableSwitched(e)),
                    trailing: MenuAnchor(
                      builder: defaultMenuButton(),
                      menuChildren: [
                        MenuItemButton(
                          leadingIcon: const Icon(PhosphorIconsLight.pencil),
                          child: Text(AppLocalizations.of(context).edit),
                          onPressed: () async {
                            String name = e;
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context).background),
                                content: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context).name,
                                    hintText:
                                        AppLocalizations.of(context).enterName,
                                    filled: true,
                                  ),
                                  initialValue: name,
                                  onChanged: (value) => name = value,
                                  onFieldSubmitted: (value) =>
                                      Navigator.of(context).pop(true),
                                  autofocus: true,
                                ),
                                actions: [
                                  TextButton.icon(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    label: Text(
                                        AppLocalizations.of(context).cancel),
                                    icon:
                                        const Icon(PhosphorIconsLight.prohibit),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    label: Text(
                                        AppLocalizations.of(context).rename),
                                    icon: const Icon(PhosphorIconsLight.check),
                                  ),
                                ],
                              ),
                            );
                            if (!(result ?? false)) return;
                            bloc.process(TableRenamed(e, name));
                          },
                        ),
                        MenuItemButton(
                          leadingIcon: const Icon(PhosphorIconsLight.trash),
                          child: Text(AppLocalizations.of(context).delete),
                          onPressed: () {
                            bloc.process(TableRemoved(e));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
