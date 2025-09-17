import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import '../../model/BookmarkModel.dart';
import '../../model/RecentSearchModel.dart';
import '../../model/TabModel.dart';
import '../../resources/string_manager.dart';

class BrowserDatabaseService {
  Database? _db;
  /// Initialize the local SQLite database with all required tables.
  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppStrings.databaseName);

    debugPrint("🟡[BrowserDatabaseService] Opening database at path: $path");

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        debugPrint("🟢[BrowserDatabaseService] Creating new database schema (version $version)");

        await db.execute('''
        CREATE TABLE IF NOT EXISTS categories (
          id TEXT PRIMARY KEY,
          title TEXT,
          icon TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          categoryId TEXT,
          title TEXT,
          amount TEXT,
          date TEXT,
          type INTEGER,
          FOREIGN KEY (categoryId) REFERENCES categories (id)
        )
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS bookmarks (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          url TEXT NOT NULL,
          favicon TEXT,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL
        )
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS recent_searches (
          id TEXT PRIMARY KEY,
          query TEXT NOT NULL,
          timestamp TEXT NOT NULL
        )
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS tabs (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          url TEXT NOT NULL,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL
        )
      ''');

        debugPrint("✅[BrowserDatabaseService] Database schema created");
      },
    );

    debugPrint("✅[BrowserDatabaseService] Database opened successfully");
  }

  // ===== BOOKMARK METHODS =====

  Future<void> insertBookmark(BookmarkModel bookmark) async {
    debugPrint("🟡[BrowserDatabaseService] Inserting bookmark: ${bookmark.title} (${bookmark.url})");
    final result = await _db?.insert(
      AppStrings.bookmarksTable,
      bookmark.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("✅[BrowserDatabaseService] Bookmark inserted with result: $result");
  }

  Future<void> deleteBookmark(String id) async {
    debugPrint("🟡[BrowserDatabaseService] Deleting bookmark with id: $id");
    final result = await _db?.delete(
      AppStrings.bookmarksTable,
      where: '${AppStrings.idField} = ?',
      whereArgs: [id],
    );
    debugPrint("✅[BrowserDatabaseService] Deleted $result bookmark(s)");
  }

  Future<List<BookmarkModel>> getAllBookmarks() async {
    debugPrint("🟡[BrowserDatabaseService] Fetching all bookmarks...");
    final maps = await _db?.query(
      AppStrings.bookmarksTable,
      orderBy: '${AppStrings.updatedAtField} DESC',
    );
    debugPrint("✅[BrowserDatabaseService] Found ${maps?.length ?? 0} bookmark(s)");
    return (maps ?? []).map((e) => BookmarkModel.fromJson(e)).toList();
  }

  Future<void> clearAllBookmarks() async {
    debugPrint("🟡[BrowserDatabaseService] Clearing all bookmarks...");
    final result = await _db?.delete(AppStrings.bookmarksTable);
    debugPrint("✅[BrowserDatabaseService] Cleared $result bookmark(s)");
  }

  // ===== RECENT SEARCH METHODS =====

  Future<void> insertRecentSearch(RecentSearchModel search) async {
    debugPrint("🟡[BrowserDatabaseService] Inserting recent search: '${search.query}' with id=${search.id}");

    final deleted = await _db?.delete(
      AppStrings.recentSearchesTable,
      where: '${AppStrings.queryField} = ?',
      whereArgs: [search.query],
    );
    debugPrint("ℹ️[BrowserDatabaseService] Removed $deleted duplicate(s) for query '${search.query}'");

    final result = await _db?.insert(
      AppStrings.recentSearchesTable,
      search.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("✅[BrowserDatabaseService] Recent search inserted with result: $result (id=${search.id})");

    await _limitRecentSearches();
  }

  Future<void> deleteRecentSearch(String query) async {
    debugPrint("🟡[BrowserDatabaseService] Deleting recent search: $query");
    final result = await _db?.delete(
      AppStrings.recentSearchesTable,
      where: 'query = ?',
      whereArgs: [query],
    );
    debugPrint("✅[BrowserDatabaseService] Deleted $result recent search(es)");
  }

  Future<List<RecentSearchModel>> getAllRecentSearches() async {
    debugPrint("🟡[BrowserDatabaseService] Fetching all recent searches...");
    final maps = await _db?.query(
      AppStrings.recentSearchesTable,
      orderBy: '${AppStrings.timestamp} DESC',
      limit: 10,
    );
    debugPrint("✅[BrowserDatabaseService] Found ${maps?.length ?? 0} recent search(es)");
    return (maps ?? []).map((e) => RecentSearchModel.fromJson(e)).toList();
  }

  Future<void> clearAllRecentSearches() async {
    debugPrint("🟡[BrowserDatabaseService] Clearing all recent searches...");
    final result = await _db?.delete(AppStrings.recentSearchesTable);
    debugPrint("✅[BrowserDatabaseService] Cleared $result recent search(es)");
  }

  Future<void> _limitRecentSearches() async {
    if (_db == null) return;

    final countResult =
    await _db!.rawQuery('SELECT COUNT(*) FROM ${AppStrings.recentSearchesTable}');
    final count = Sqflite.firstIntValue(countResult) ?? 0;

    debugPrint("ℹ️[BrowserDatabaseService] Current recent search count: $count");

    if (count > 10) {
      debugPrint("🟡[BrowserDatabaseService] Trimming recent searches to 10");
      final result = await _db!.rawDelete('''
        DELETE FROM ${AppStrings.recentSearchesTable} 
        WHERE ${AppStrings.idField} NOT IN (
          SELECT ${AppStrings.idField} FROM ${AppStrings.recentSearchesTable} 
          ORDER BY ${AppStrings.timestamp} DESC 
          LIMIT 10
        )
      ''');
      debugPrint("✅[BrowserDatabaseService] Trimmed $result old search(es)");
    }
  }

  // ===== TAB METHODS =====

  Future<void> insertTab(TabModel tab) async {
    debugPrint("🟡[BrowserDatabaseService] Inserting tab: ${tab.title} (${tab.url})");
    final result = await _db?.insert(
      'tabs',
      tab.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("✅[BrowserDatabaseService] Tab inserted with result: $result");
  }

  Future<void> deleteTab(String id) async {
    debugPrint("🟡[BrowserDatabaseService] Deleting tab with id: $id");
    final result = await _db?.delete(
      'tabs',
      where: 'id = ?',
      whereArgs: [id],
    );
    debugPrint("✅[BrowserDatabaseService] Deleted $result tab(s)");
  }

  Future<List<TabModel>> getAllTabs() async {
    debugPrint("🟡[BrowserDatabaseService] Fetching all tabs...");
    final maps = await _db?.query('tabs', orderBy: 'updatedAt DESC');
    debugPrint("✅[BrowserDatabaseService] Found ${maps?.length ?? 0} tab(s)");
    return (maps ?? []).map((e) => TabModel.fromJson(e)).toList();
  }

  Future<void> clearAllTabs() async {
    debugPrint("🟡[BrowserDatabaseService] Clearing all tabs...");
    final result = await _db?.delete('tabs');
    debugPrint("✅[BrowserDatabaseService] Cleared $result tab(s)");
  }

  Future<void> close() async {
    debugPrint("🛑[BrowserDatabaseService] Closing database...");
    await _db?.close();
    debugPrint("✅[BrowserDatabaseService] Database closed");
  }
}