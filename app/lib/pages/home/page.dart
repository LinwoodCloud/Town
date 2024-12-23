import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/main.dart';
import 'package:setonix/pages/home/background.dart';
import 'package:setonix/pages/home/connect.dart';
import 'package:setonix/pages/home/header.dart';
import 'package:setonix/pages/packs/dialog.dart';
import 'package:setonix/pages/home/play.dart';

import '../../api/settings.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  HomePage({super.key});

  List<(String, IconData, VoidCallback, Widget?, bool)> _getItems(
          BuildContext context) =>
      [
        (
          AppLocalizations.of(context).play,
          PhosphorIconsLight.play,
          () => showDialog(
              context: context, builder: (context) => const PlayDialog()),
          null,
          false,
        ),
        (
          AppLocalizations.of(context).servers,
          PhosphorIconsLight.plugsConnected,
          () => showDialog(
              context: context, builder: (context) => const ServersDialog()),
          null,
          false,
        ),
        (
          AppLocalizations.of(context).packs,
          PhosphorIconsLight.package,
          () => showDialog(
                context: context,
                builder: (context) => const PacksDialog(),
              ),
          null,
          false,
        ),
        (
          AppLocalizations.of(context).settings,
          PhosphorIconsLight.gear,
          () => openSettings(context),
          null,
          false,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final items = _getItems(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
        title: Text(applicationName),
        onlyShowOnDesktop: true,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            ListenableBuilder(
              listenable: _scrollController,
              builder: (context, child) => DotsBackground(
                offset:
                    _scrollController.hasClients ? _scrollController.offset : 0,
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Align(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: LeapBreakpoints.expanded,
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HeaderHomeView(),
                      if (constraints.maxWidth < LeapBreakpoints.compact)
                        Card(
                          clipBehavior: Clip.antiAlias,
                          child: ListView(
                            shrinkWrap: true,
                            children: items.map((item) {
                              return ListTile(
                                title: Text(item.$1),
                                subtitle: item.$4,
                                leading: Icon(item.$2,
                                    color: theme.colorScheme.primary),
                                trailing: item.$5
                                    ? Icon(
                                        PhosphorIconsFill.arrowSquareOut,
                                        color: theme.colorScheme.primaryFixed,
                                      )
                                    : null,
                                onTap: item.$3,
                              );
                            }).toList(),
                          ),
                        )
                      else
                        _GridHomeView(items: items),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _GridHomeView extends StatelessWidget {
  const _GridHomeView({
    required this.items,
  });

  final List<(String, IconData, VoidCallback, Widget?, bool)> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        shrinkWrap: true,
        crossAxisCount: constraints.maxWidth >= LeapBreakpoints.medium ? 4 : 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: items.map((item) {
          return LayoutBuilder(
              builder: (context, constraints) => Card.outlined(
                    child: InkWell(
                      onTap: item.$3,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  item.$2,
                                  size: constraints.maxWidth / 2,
                                  color: theme.colorScheme.primary,
                                ),
                                if (item.$5)
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      PhosphorIconsFill.arrowSquareOut,
                                      color: theme.colorScheme.primaryFixed,
                                    ),
                                  ),
                              ],
                            )),
                            SizedBox(
                              height: 64,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.$1,
                                      style: theme.textTheme.headlineSmall,
                                    ),
                                  ),
                                  if (item.$4 != null)
                                    DefaultTextStyle(
                                      style: (theme.textTheme.headlineSmall ??
                                              const TextStyle())
                                          .copyWith(
                                        color: theme.colorScheme.primary,
                                      ),
                                      child: item.$4!,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
        }).toList(),
      ),
    );
  }
}
