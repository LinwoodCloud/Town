import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/settings.dart';
import '../../main.dart';
import '../../theme.dart';

class PersonalizationSettingsPage extends StatelessWidget {
  final bool inView;
  const PersonalizationSettingsPage({super.key, this.inView = false});

  String _getThemeName(BuildContext context, ThemeMode mode) => switch (mode) {
        ThemeMode.system => AppLocalizations.of(context).systemTheme,
        ThemeMode.light => AppLocalizations.of(context).lightTheme,
        ThemeMode.dark => AppLocalizations.of(context).darkTheme,
      };

  String _getLocaleName(BuildContext context, String locale) => locale
          .isNotEmpty
      ? LocaleNames.of(context)?.nameOf(locale.replaceAll('-', '_')) ?? locale
      : AppLocalizations.of(context).systemLocale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: WindowTitleBar<SettingsCubit, SetonixSettings>(
          inView: inView,
          backgroundColor: inView ? Colors.transparent : null,
          title: Text(AppLocalizations.of(context).personalization),
        ),
        body: BlocBuilder<SettingsCubit, SetonixSettings>(
          builder: (context, state) {
            final design = state.design;
            return ListView(children: [
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                            leading: const PhosphorIcon(PhosphorIconsLight.eye),
                            title: Text(AppLocalizations.of(context).theme),
                            subtitle: Text(_getThemeName(context, state.theme)),
                            onTap: () => _openThemeModal(context)),
                        ListTile(
                          leading:
                              const PhosphorIcon(PhosphorIconsLight.palette),
                          title: Text(AppLocalizations.of(context).design),
                          subtitle: Text(
                            design.isEmpty
                                ? AppLocalizations.of(context).systemTheme
                                : design.toDisplayString(),
                          ),
                          trailing: ThemeBox(
                            theme: getThemeData(state.design, false),
                          ),
                          onTap: () => _openDesignModal(context),
                        ),
                        ListTile(
                          leading:
                              const PhosphorIcon(PhosphorIconsLight.translate),
                          title: Text(AppLocalizations.of(context).locale),
                          subtitle: Text(AppLocalizations.of(context)
                              .comingSoon /*_getLocaleName(context, state.localeTag)*/),
                          onTap: null /*() => _openLocaleModal(context)*/,
                        ),
                        SwitchListTile(
                          title:
                              Text(AppLocalizations.of(context).highContrast),
                          secondary:
                              const PhosphorIcon(PhosphorIconsLight.circleHalf),
                          value: state.highContrast,
                          onChanged: (value) => context
                              .read<SettingsCubit>()
                              .changeHighContrast(value),
                        ),
                      ]),
                ),
              ),
              if (!kIsWeb && (Platform.isWindows || Platform.isLinux))
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SwitchListTile(
                            value: state.nativeTitleBar,
                            title: Text(
                                AppLocalizations.of(context).nativeTitleBar),
                            secondary: const PhosphorIcon(
                                PhosphorIconsLight.appWindow),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changeNativeTitleBar(value),
                          ),
                        ]),
                  ),
                ),
            ]);
          },
        ));
  }

  void _openDesignModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final design = cubit.state.design;

    void changeDesign(String design) {
      cubit.changeDesign(design);
      Navigator.of(context).pop();
    }

    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).theme),
      childrenBuilder: (context) => [
        ListTile(
          title: Text(AppLocalizations.of(context).systemTheme),
          selected: design.isEmpty,
          onTap: () => changeDesign(''),
          leading: ThemeBox(
            theme: getThemeData('', false),
          ),
        ),
        ...getThemes().map(
          (e) {
            final theme = getThemeData(e, false);
            return ListTile(
                title: Text(e.toDisplayString()),
                selected: e == design,
                onTap: () => changeDesign(e),
                leading: ThemeBox(
                  theme: theme,
                ));
          },
        ),
      ],
    );
  }

  void _openThemeModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final currentTheme = cubit.state.theme;
    void changeTheme(ThemeMode themeMode) {
      cubit.changeTheme(themeMode);
      Navigator.of(context).pop();
    }

    showLeapBottomSheet(
        context: context,
        titleBuilder: (context) => Text(AppLocalizations.of(context).theme),
        childrenBuilder: (context) => [
              ListTile(
                  title: Text(AppLocalizations.of(context).systemTheme),
                  selected: currentTheme == ThemeMode.system,
                  leading: const PhosphorIcon(PhosphorIconsLight.power),
                  onTap: () => changeTheme(ThemeMode.system)),
              ListTile(
                  title: Text(AppLocalizations.of(context).lightTheme),
                  selected: currentTheme == ThemeMode.light,
                  leading: const PhosphorIcon(PhosphorIconsLight.sun),
                  onTap: () => changeTheme(ThemeMode.light)),
              ListTile(
                  title: Text(AppLocalizations.of(context).darkTheme),
                  selected: currentTheme == ThemeMode.dark,
                  leading: const PhosphorIcon(PhosphorIconsLight.moon),
                  onTap: () => changeTheme(ThemeMode.dark)),
            ]);
  }

  // ignore: unused_element
  void _openLocaleModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentLocale = cubit.state.localeTag;
    var locales = getLocales();
    void changeLocale(Locale? locale) {
      cubit.changeLocale(locale);
      Navigator.of(context).pop();
    }

    showLeapBottomSheet(
        context: context,
        childrenBuilder: (context) => [
              ListTile(
                  title: Text(AppLocalizations.of(context).defaultLocale),
                  selected: currentLocale.isEmpty,
                  onTap: () => changeLocale(null)),
              ...locales.map((e) => ListTile(
                  title: Text(_getLocaleName(context, e.toLanguageTag())),
                  selected: currentLocale == e.toLanguageTag(),
                  onTap: () => changeLocale(e))),
            ]);
  }
}
