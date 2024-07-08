import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog>
    with TickerProviderStateMixin {
  late final TabController _tabController, _customTabController;
  final PageController _pageController = PageController(keepPage: true);
  final GlobalKey _pageKey = GlobalKey();
  bool _infoView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _customTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _customTabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < LeapBreakpoints.medium;
    final selections = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            HorizontalTab(
              icon: const PhosphorIcon(PhosphorIconsLight.folder),
              label: Text(AppLocalizations.of(context).installed),
            ),
            HorizontalTab(
              icon: const PhosphorIcon(PhosphorIconsLight.globe),
              label: Text(AppLocalizations.of(context).custom),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Material(
                type: MaterialType.transparency,
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Template ${index + 1}'),
                      onTap: () => Navigator.of(context).pop(),
                    );
                  },
                ),
              ),
              Column(children: [
                TabBar.secondary(
                  tabs: [
                    HorizontalTab(
                      label: Text(AppLocalizations.of(context).packs),
                      icon: const Icon(PhosphorIconsLight.package),
                    ),
                    HorizontalTab(
                      label: Text(AppLocalizations.of(context).configuration),
                      icon: const Icon(PhosphorIconsLight.wrench),
                    ),
                  ],
                  tabAlignment: TabAlignment.center,
                  controller: _customTabController,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: TabBarView(
                      controller: _customTabController,
                      children: [
                        ListView.builder(
                          itemCount: 30,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text('Custom ${index + 1}'),
                              value: false,
                              onChanged: (bool? value) {},
                            );
                          },
                        ),
                        ListView(
                          children: [
                            ListTile(
                              title:
                                  Text(AppLocalizations.of(context).background),
                              subtitle: const Text('Not set'),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            const ListTile(
                              title: Text('Rules'),
                              subtitle: Text('Coming soon'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
    final details = ListView(
      children: [
        Text('Details', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Name', hintText: 'Enter a name', filled: true),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Enter a description',
            border: OutlineInputBorder(),
          ),
          minLines: 3,
          maxLines: 5,
        ),
      ],
    );
    return ResponsiveAlertDialog(
      title: const Text('Create'),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 700,
      ),
      content: IndexedStack(
        index: isMobile ? 0 : 1,
        key: _pageKey,
        children: [
          PageView(
            controller: _pageController,
            children: [
              selections,
              details,
            ],
            onPageChanged: (value) =>
                setState(() => _infoView = value.toInt() == 1),
          ),
          Row(
            children: [
              Expanded(child: selections),
              const SizedBox(width: 16),
              const VerticalDivider(),
              const SizedBox(width: 16),
              Expanded(child: details),
            ],
          )
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          label: const Text('Cancel'),
          icon: const Icon(PhosphorIconsLight.prohibit),
        ),
        if (isMobile && !_infoView) ...[
          FilledButton.icon(
            icon: const Icon(PhosphorIconsBold.arrowRight),
            label: const Text('Next'),
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
          ),
        ] else ...[
          if (isMobile)
            ElevatedButton.icon(
              icon: const Icon(PhosphorIconsBold.arrowLeft),
              label: const Text('Back'),
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              ),
            ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            label: const Text('Create'),
            icon: const Icon(PhosphorIconsLight.plus),
          ),
        ]
      ],
    );
  }
}