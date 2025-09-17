import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:open_arch_browser/app/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import '../model/LanguageModel.dart';
import '../resources/langauges_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import '../resources/string_manager.dart';
import '../viewmodels/theme_viewmodel.dart';
import 'di.dart';

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
    return Consumer2<ThemeViewModel, LanguageViewModel>(
      builder: (context, themeVM, languageVM, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,

          // Localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // Routing
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.homeRoute,

          // Theming - Now properly integrated with ThemeViewModel
          theme: themeVM.lightTheme,
          darkTheme: themeVM.darkTheme,
          themeMode: themeVM.themeMode,

          // Builder to handle theme initialization
          builder: (context, child) {
            // Initialize theme and language ViewModels on first build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!themeVM.isInitialized) {
                themeVM.init();
              }
              if (!languageVM.isInitialized) {
                languageVM.init(context);
              }
            });

            return child ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}