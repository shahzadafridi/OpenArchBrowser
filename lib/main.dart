import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:open_arch_browser/app/app_provider.dart';
import 'package:open_arch_browser/resources/langauges_manager.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import 'package:window_manager/window_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import 'app/di.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Initialize dependency injection
  await initAppModule();

  // Initialize window manager (if needed for desktop)
  if (WidgetsBinding.instance.platformDispatcher.views.isNotEmpty) {
    await windowManager.ensureInitialized();

    // Optional: Configure window settings
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1200, 800),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [ARABIC_LOCALE, ENGLISH_LOCALE],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(
        child: AppProviders(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.homeRoute,
      theme: getApplicationTheme(),
      title: AppStrings.appName,
    );
  }
}