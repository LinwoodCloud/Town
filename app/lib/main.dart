import 'package:args/args.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/pages/editor/shell.dart';
import 'package:setonix/pages/game/page.dart';
import 'package:setonix/pages/home/page.dart';
import 'package:setonix/pages/settings/data.dart';
import 'package:setonix/pages/settings/general.dart';
import 'package:setonix/pages/settings/personalization.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:window_manager/window_manager.dart';
import 'package:setonix_plugin/setonix_plugin.dart';

import 'bloc/settings.dart';
import 'pages/settings/page.dart';

import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';

String? dataPath;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final argParser = ArgParser();
  argParser.addOption('path', abbr: 'p');
  final result = argParser.parse(args);
  dataPath = result['path'];

  final prefs = await SharedPreferences.getInstance();
  final settingsCubit = SettingsCubit(prefs);
  final networkService = NetworkService(settingsCubit);
  await networkService.init();

  await setup(settingsCubit);

  await initPluginSystem();
  if (kDebugMode) {
    print('6 + 8 = ${await simpleAdderTwinNormal(a: 6, b: 8)}');
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: settingsCubit),
        BlocProvider.value(
            value: WindowCubit(fullScreen: await isFullScreen())),
        RepositoryProvider.value(value: networkService),
        RepositoryProvider(create: (context) => SetonixFileSystem()),
      ],
      child: SetonixApp(),
    ),
  );
}

const kUnsupportedLanguages = [];

List<Locale> getLocales() =>
    List<Locale>.from(AppLocalizations.supportedLocales)
        .where((l) => !kUnsupportedLanguages.contains(l.toString()))
        .toList();

class SetonixApp extends StatelessWidget {
  SetonixApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return _buildApp(null, null);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) =>
          _buildApp(lightDynamic, darkDynamic),
    );
  }

  Widget _buildApp(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    return BlocBuilder<SettingsCubit, SetonixSettings>(
        buildWhen: (previous, current) =>
            previous.design != current.design ||
            previous.theme != current.theme ||
            previous.locale != current.locale ||
            previous.nativeTitleBar != current.nativeTitleBar ||
            previous.highContrast != current.highContrast,
        builder: (context, state) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: applicationName,
              theme: getThemeData(
                  state.design, false, lightDynamic, state.highContrast),
              darkTheme: getThemeData(
                  state.design, true, darkDynamic, state.highContrast),
              themeMode: state.theme,
              locale: state.localeTag.isEmpty ? null : Locale(state.localeTag),
              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                LeapLocalizations.delegate,
                LocaleNamesLocalizationsDelegate(),
              ],
              builder: (context, child) {
                if (!state.nativeTitleBar) {
                  child = virtualWindowFrameBuilder(context, child);
                }
                return child ?? Container();
              },
              supportedLocales: AppLocalizations.supportedLocales,
            ));
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
        routes: [
          GoRoute(
            name: 'game',
            path: 'game/:name',
            builder: (context, state) => GamePage(
              name: state.pathParameters['name'],
            ),
          ),
          ShellRoute(
            builder: (context, state, child) => EditorShell(
              state: state,
              name: state.pathParameters['name']!,
              child: child,
            ),
            routes: EditorPage.values
                .where((e) => e.location != null)
                .map(
                  (e) => GoRoute(
                    path: e.fullLocation!,
                    name: e.route,
                    builder: (context, state) => e.getPage(),
                  ),
                )
                .toList(),
          ),
          GoRoute(
            name: 'connect',
            path: 'connect',
            builder: (context, state) => GamePage(
              address: state.uri.queryParameters['address'],
              secure:
                  bool.tryParse(state.uri.queryParameters['secure'] ?? '') ??
                      true,
            ),
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsPage(),
            routes: [
              GoRoute(
                path: 'general',
                builder: (context, state) => const GeneralSettingsPage(),
              ),
              GoRoute(
                path: 'data',
                builder: (context, state) => const DataSettingsPage(),
              ),
              GoRoute(
                path: 'personalization',
                builder: (context, state) =>
                    const PersonalizationSettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
const shortApplicationName = isNightly ? 'Setonix Nightly' : 'Setonix';
const applicationName = 'Linwood $shortApplicationName';
const applicationMinorVersion = '0.3';
