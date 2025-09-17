import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/local/browser_database_service.dart';
import '../data/repository/bookmark_repository_imp.dart';
import '../data/repository/recent_search_repository_imp.dart';
import '../data/repository/bookmark_repository.dart';
import '../data/repository/recent_search_repository.dart';
import '../model/LanguageModel.dart';
import '../resources/string_manager.dart';
import '../viewmodels/bookmark_viewmodel.dart';
import '../viewmodels/recent_search_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';

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
          create: (_) => BrowserDatabaseService(),
          dispose: (_, service) => service.close(),
        ),

        // ===== REPOSITORIES =====

        /// Bookmark Repository
        ProxyProvider<BrowserDatabaseService, BookmarkRepository>(
          create: (_) => throw UnimplementedError(AppStrings.repositoryNotInitialized),
          update: (_, dbService, __) => BookmarkRepositoryImpl(dbService),
        ),

        /// Recent Search Repository
        ProxyProvider<BrowserDatabaseService, RecentSearchRepository>(
          create: (_) => throw UnimplementedError(AppStrings.repositoryNotInitialized),
          update: (_, dbService, __) => RecentSearchRepositoryImpl(dbService),
        ),

        // ===== APP-LEVEL VIEWMODELS =====

        /// Theme Management ViewModel
        ChangeNotifierProvider<ThemeViewModel>(
          create: (_) => ThemeViewModel(),
        ),

        /// Language Management ViewModel
        ChangeNotifierProvider<LanguageViewModel>(
          create: (_) => LanguageViewModel(),
        ),

        // ===== FEATURE VIEWMODELS =====

        /// Bookmark Management ViewModel
        ChangeNotifierProxyProvider<BookmarkRepository, BookmarkViewModel>(
          create: (_) => throw UnimplementedError(AppStrings.viewModelNotInitialized),
          update: (_, bookmarkRepo, __) => BookmarkViewModel(
            repository: bookmarkRepo,
          ),
        ),

        /// Recent Search Management ViewModel
        ChangeNotifierProxyProvider<RecentSearchRepository, RecentSearchViewModel>(
          create: (_) => throw UnimplementedError(AppStrings.viewModelNotInitialized),
          update: (_, searchRepo, __) => RecentSearchViewModel(
            repository: searchRepo,
          ),
        ),

        // ===== BROWSER-SPECIFIC PROVIDERS =====

        /// Web View State Provider (if needed)
        // ChangeNotifierProvider<WebViewViewModel>(
        //   create: (_) => WebViewViewModel(),
        // ),

        /// Tab Management Provider (if implementing tabs)
        // ChangeNotifierProvider<TabViewModel>(
        //   create: (_) => TabViewModel(),
        // ),
      ],
      child: child,
    );
  }
}