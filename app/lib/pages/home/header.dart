import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/api/open.dart';
import 'package:setonix/bloc/settings.dart';

class HeaderHomeView extends StatefulWidget {
  const HeaderHomeView({super.key});

  @override
  State<HeaderHomeView> createState() => _HeaderHomeViewState();
}

class _HeaderHomeViewState extends State<HeaderHomeView> {
  late final Future<bool> _hasNewerVersionFuture;
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _hasNewerVersionFuture = _settingsCubit.hasNewerVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: LeapBreakpoints.expanded),
        child: LayoutBuilder(builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= LeapBreakpoints.medium;
          return FutureBuilder(
              future: _hasNewerVersionFuture,
              builder: (context, snapshot) {
                final hasNewerVersion = snapshot.data ?? true;
                final colorScheme = Theme.of(context).colorScheme;
                final actions = Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () => openHelp(['intro']),
                      icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
                      label: Text(AppLocalizations.of(context).documentation),
                    ),
                  ],
                );
                final style = FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                );
                void openNew() {
                  openReleaseNotes();
                  _settingsCubit.updateLastVersion();
                }

                final whatsNew = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    hasNewerVersion
                        ? FilledButton(
                            onPressed: openNew,
                            style: style,
                            child: Text(AppLocalizations.of(context).whatsNew),
                          )
                        : ElevatedButton(
                            onPressed: openNew,
                            style: style,
                            child: Text(AppLocalizations.of(context).whatsNew),
                          ),
                    if (hasNewerVersion)
                      const SizedBox(
                        height: 0,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: PhosphorIcon(PhosphorIconsLight.caretUp),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
                final logo = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: 64,
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).welcome,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: colorScheme.onInverseSurface,
                                ),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            AppLocalizations.of(context).welcomeContent,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onInverseSurface,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                final innerCard =
                    LayoutBuilder(builder: (context, constraints) {
                  final isMobile =
                      constraints.maxWidth < LeapBreakpoints.compact;
                  if (isMobile) {
                    return Column(
                      children: [logo, const SizedBox(height: 16), whatsNew],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [logo, whatsNew],
                  );
                });
                final card = Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colorScheme.secondary,
                          colorScheme.primary,
                        ],
                        stops: const [0.2, 0.8],
                      ),
                    ),
                    child: innerCard,
                  ),
                );
                final child = isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: card),
                          const SizedBox(width: 32),
                          actions,
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          card,
                          const SizedBox(height: 32),
                          actions,
                        ],
                      );
                return Column(
                  children: [
                    const SizedBox(height: 64),
                    child,
                    const SizedBox(height: 48),
                  ],
                );
              });
        }),
      ),
    );
  }
}
