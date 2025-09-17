import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  // App Info
  static const String appName = "Arch Browser";
  static const String appVersion = "1.0.0";

  // Theme Strings
  static const String lightTheme = "Light Theme";
  static const String darkTheme = "Dark Theme";
  static const String systemTheme = "System Theme";
  static const String themeSettings = "Theme Settings";
  static const String changeTheme = "Change Theme";

  // Language Strings
  static const String languageSettings = "Language Settings";
  static const String changeLanguage = "Change Language";
  static const String currentLanguage = "Current Language";
  static const String selectLanguage = "Select Language";

  // Provider Error Messages
  static const String repositoryNotInitialized = "Repository not initialized";
  static const String viewModelNotInitialized = "ViewModel not initialized";
  static const String serviceNotAvailable = "Service not available";

  // Settings Categories
  static const String generalSettings = "General";
  static const String appearanceSettings = "Appearance";
  static const String languageAndRegion = "Language & Region";
  static const String privacySettings = "Privacy";
  static const String aboutApp = "About";

  // Common Actions
  static const String apply = "Apply";
  static const String cancel = "Cancel";
  static const String reset = "Reset";
  static const String save = "Save";
  static const String done = "Done";
  static const String close = "Close";


  static const String noRouteFound = "no_route_found";

  static const String next = "Next";
  static const String new_label = "New";

  // Browser Widget
  static const String currentUrl = "https://www.youtube.com";
  static const String defaultNewTabUrl = "https://www.google.com";

  // Arch Mini Window Widget
  static const String searchHint = "Search or type URL";
  static const String listTileTitlePlaceholder1 = "YouTube";
  static const String listTileTitlePlaceholder2 = "Contact the Team";


  static const String newTab = "New Tab";
  static const String mySection = "My Section";
  static const String enterUrl = "Enter URL";

  // Google Search URL
  static const String googleSearchUrl = "https://www.google.com/search?q=";

  // Default WebView URL
  static const String defaultWebViewUrl = "https://flutter.dev";

  // Recent Searches (for demo/testing)
  static const String recentSearchFlutter = "Flutter development";
  static const String recentSearchDart = "Dart programming";
  static const String recentSearchMobile = "Mobile app design";
  static const String recentSearchState = "State management";
  static const String recentSearchApi = "API integration";

  // Mini Window Strings
  static const String recentSearchesTitle = "Recent Searches";
  static const String demoLabel = "Demo";

  // Database
  static const String databaseName = "browser.db";

  // Table names
  static const String transactionsTable = "transactions";
  static const String bookmarksTable = "bookmarks";
  static const String recentSearchesTable = "recent_searches";
  static const String categoriesTable = "categories";

  // Common field names
  static const String idField = "id";
  static const String titleField = "title";
  static const String urlField = "url";
  static const String queryField = "query";
  static const String createdAtField = "createdAt";
  static const String updatedAtField = "updatedAt";
  static const String timestamp = "timestamp";
  static const String faviconField = "favicon";

  // Error Messages
  static const String initializationError = "Failed to initialize application";
  static const String loadBookmarksError = "Failed to load bookmarks";
  static const String addBookmarkError = "Failed to add bookmark";
  static const String deleteBookmarkError = "Failed to delete bookmark";
  static const String clearBookmarksError = "Failed to clear bookmarks";
  static const String loadRecentSearchesError = "Failed to load recent searches";
  static const String addRecentSearchError = "Failed to add recent search";
  static const String deleteRecentSearchError = "Failed to delete recent search";
  static const String clearRecentSearchesError = "Failed to clear recent searches";

  // Success Messages
  static const String bookmarkAdded = "Bookmark added successfully";
  static const String bookmarkDeleted = "Bookmark deleted successfully";
  static const String bookmarksCleared = "All bookmarks cleared";
  static const String recentSearchesCleared = "Recent searches cleared";

  static String deleteTabError = "Failed to delete tab";
  static String addTabError = "Failed to add tab";
  static String clearTabsError = "Failed to clear tabs";
  static String loadTabsError = "Failed to load tabs";

}