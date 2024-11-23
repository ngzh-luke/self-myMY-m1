import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import 'package:flutter_native_splash/flutter_native_splash.dart'
    show FlutterNativeSplash;
import 'package:loader_overlay/loader_overlay.dart' show GlobalLoaderOverlay;
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, Consumer, MultiProvider, ProxyProvider;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:mymy_m1/navigation/pages_router.dart' show router;
import 'package:mymy_m1/services/settings/settings_service.dart'
    show SettingsService;
import 'package:mymy_m1/services/ui_services/notifications/notification_manager.dart'
    show NotificationManager;
import 'package:mymy_m1/shared/configs/languages/language_provider.dart'
    show LanguageProvider;
import 'package:mymy_m1/shared/configs/themes/theme_collections.dart'
    show ThemeCollections;
import 'package:mymy_m1/shared/configs/themes/theme_provider.dart'
    show ThemeProvider;
import 'package:mymy_m1/utils/dependency_inj/get_it.dart'
    show setupDependencies;

bool isBigScreen(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  // can use a different threshold like 600 for width in logical pixels
  return width >= 600;
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final languageProvider = LanguageProvider();
  await languageProvider.loadFromPrefs();

  final themeProvider = ThemeProvider();
  await themeProvider.loadFromPrefs();

  final settingsService = SettingsService(
    themeProvider: themeProvider,
    languageProvider: languageProvider,
  );

  // Log user preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("\n<------------------->");
  print(' User Preferences:');
  print('Language Code: ${prefs.getString('languageCode')}');
  print('Is System Default Language: ${prefs.getBool('isSystemDefault')}');
  print(
      'Theme Mode: ${ThemeMode.values[prefs.getInt('themeMode') ?? ThemeMode.system.index].toString().split('.').last}');
  print('Theme Name: ${prefs.getString('themeName')}');
  print("<------------------->");

  // Log what will be applied
  print("\n<------------------->");
  print(' Applied Settings:');
  print(
      'Language: ${languageProvider.currentLocale.languageCode} (Is System Default: ${languageProvider.isSystemDefault})');
  print('Theme Mode: ${themeProvider.themeMode.toString().split(".").last}');
  print('Theme Name: ${themeProvider.currentThemeName}');
  print("<------------------->");

  // Report System default
  print("\n<------------------->");
  print(" Device Default:");
  String deviceLocale =
      WidgetsBinding.instance.platformDispatcher.locales.toString();
  print('Device Default Locale: $deviceLocale');
  print(
      "Device Default Theme mode: ${WidgetsBinding.instance.platformDispatcher.platformBrightness.toString().split(".").last}");
  print("<------------------->");

  await Future.delayed(const Duration(
      seconds: 1)); // Delay to allow time for reading the console output

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(value: themeProvider),
        // ChangeNotifierProvider.value(value: languageProvider),
        ChangeNotifierProvider.value(value: settingsService),
        ProxyProvider<SettingsService, NotificationManager>(
          update: (_, settings, __) => NotificationManager(settings),
          dispose: (_, manager) => manager.dispose(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    initialization();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // TODO: add dispose()
    }
  }

  void initialization() async {
    setState(() => _isLoading = true);
    print("\n<------------------->");
    print(" Available Resources:");
    print("loading resources...");
    setupDependencies();
    print("Available localizations: ${AppLocalizations.supportedLocales}");
    print("Available Themes: ${ThemeCollections.availableThemes}");
    setState(() => _isLoading = false);
    print("resources are loaded successfully\n");
    print("<------------------->\n");
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Check if the device's screen is big
    if (!isBigScreen(context)) {
      // Lock orientation to portrait
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      // Allow both orientations for big screen
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    return Consumer<SettingsService>(
      builder: (context, settings, child) {
        return _isLoading
            ? Center(
                child: LoadingAnimationWidget.twoRotatingArc(
                    color: Theme.of(context).colorScheme.secondary, size: 65),
              )
            : SafeArea(
                child: GlobalLoaderOverlay(
                  overlayWholeScreen: true,
                  overlayColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  overlayWidgetBuilder: (progress) => Center(
                    child: LoadingAnimationWidget.twoRotatingArc(
                        color: Colors.yellowAccent, size: 65),
                  ),
                  child: MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      routerConfig: router,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: settings.supportedLocales,
                      locale: settings.currentLocale,
                      title: "myMY M1 by LukeCreated",
                      theme: settings.lightTheme,
                      darkTheme: settings.darkTheme,
                      themeMode: settings.themeMode,
                      builder: (context, child) {
                        return child ?? const SizedBox.shrink();
                      }),
                ),
              );
      },
    );
  }
}
