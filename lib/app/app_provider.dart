import 'package:flutter/material.dart';
import 'package:open_arch_browser/data/repository/tab_repository.dart';
import 'package:open_arch_browser/data/repository/tab_repository_imp.dart';
import 'package:open_arch_browser/presentation/viewmodels/tab_viewmodel.dart';
import 'package:provider/provider.dart';

import '../data/local/browser_database_service.dart';
import '../data/repository/bookmark_repository.dart';
import '../data/repository/bookmark_repository_imp.dart';
import '../data/repository/recent_search_repository.dart';
import '../data/repository/recent_search_repository_imp.dart';
import '../model/LanguageModel.dart';
import '../presentation/viewmodels/bookmark_viewmodel.dart';
import '../presentation/viewmodels/recent_search_viewmodel.dart';
import '../presentation/viewmodels/theme_viewmodel.dart';

/// Central place for dependency injection using Provider + ChangeNotifierProvider
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ===== CORE SERVICES =====
        /// Database Service (Singleton)
        Provider<BrowserDatabaseService>(
          create: (_) {
            debugPrint("🟡[AppProviders] Creating BrowserDatabaseService...");
            return BrowserDatabaseService();
          },
          dispose: (_, service) {
            debugPrint("🛑[AppProviders] Disposing BrowserDatabaseService...");
            service.close();
          },
        ),

        // ===== REPOSITORIES =====
        Provider<BookmarkRepository>(
          create: (context) => BookmarkRepositoryImpl(
            context.read<BrowserDatabaseService>(),
          ),
        ),
        Provider<RecentSearchRepository>(
          create: (context) => RecentSearchRepositoryImpl(
            context.read<BrowserDatabaseService>(),
          ),
        ),
        Provider<TabRepository>(
          create: (context) => TabRepositoryImpl(
            context.read<BrowserDatabaseService>(),
          ),
        ),

        // ===== APP-LEVEL VIEWMODELS =====
        ChangeNotifierProvider<ThemeViewModel>(
          create: (_) => ThemeViewModel(),
        ),
        ChangeNotifierProvider<LanguageViewModel>(
          create: (_) => LanguageViewModel(),
        ),

        // ===== FEATURE VIEWMODELS =====
        ChangeNotifierProvider<BookmarkViewModel>(
          create: (context) {
            final vm = BookmarkViewModel(
              repository: context.read<BookmarkRepository>(),
            );
            debugPrint("🟡[AppProviders] Initializing BookmarkViewModel...");
            vm.init();
            return vm;
          },
        ),
        ChangeNotifierProvider<RecentSearchViewModel>(
          create: (context) {
            final vm = RecentSearchViewModel(
              repository: context.read<RecentSearchRepository>(),
            );
            debugPrint("🟡[AppProviders] Initializing RecentSearchViewModel...");
            vm.init(); // 🔑 ensures DB + searches load on startup
            return vm;
          },
        ),
        ChangeNotifierProvider<TabViewModel>(
          create: (context) {
            final vm = TabViewModel(
              repository: context.read<TabRepository>(),
            );
            debugPrint("🟡[AppProviders] Initializing TabViewModel...");
            vm.init();
            return vm;
          },
        ),

        // ===== BROWSER-SPECIFIC PROVIDERS =====
        // Example:
        // ChangeNotifierProvider<WebViewViewModel>(
        //   create: (_) => WebViewViewModel(),
        // ),
      ],
      child: child,
    );
  }
}