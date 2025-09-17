import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import '../../model/BookmarkModel.dart';
import '../../model/RecentSearchModel.dart';
import '../../resources/string_manager.dart';

class BrowserDatabaseService {
  Database? _db;
  final _uuid = const Uuid();

  /// Initialize the local SQLite database with all required tables.
  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppStrings.databaseName);

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Categories table (existing)
        await db.execute('''
        CREATE TABLE IF NOT EXISTS categories (
          id TEXT PRIMARY KEY,
          title TEXT,
          icon TEXT
        )
      ''');

        // Transactions table (existing)
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

        // Bookmarks table (new)
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

        // Recent searches table (new)
        await db.execute('''
        CREATE TABLE IF NOT EXISTS recent_searches (
          id TEXT PRIMARY KEY,
          query TEXT NOT NULL,
          searchedAt TEXT NOT NULL
        )
      ''');
      },
    );
  }

  // ===== BOOKMARK METHODS (new) =====

  /// Insert a new bookmark
  Future<void> insertBookmark(BookmarkModel bookmark) async {
    await _db?.insert(
      AppStrings.bookmarksTable,
      bookmark.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete bookmark by ID
  Future<void> deleteBookmark(String id) async {
    await _db?.delete(
      AppStrings.bookmarksTable,
      where: '${AppStrings.idField} = ?',
      whereArgs: [id],
    );
  }

  /// Get all bookmarks
  Future<List<BookmarkModel>> getAllBookmarks() async {
    final List<Map<String, dynamic>>? maps = await _db?.query(
      AppStrings.bookmarksTable,
      orderBy: '${AppStrings.updatedAtField} DESC',
    );

    if (maps == null || maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return BookmarkModel.fromJson(maps[i]);
    });
  }

  /// Delete all bookmarks
  Future<void> clearAllBookmarks() async {
    await _db?.delete(AppStrings.bookmarksTable);
  }

  // ===== RECENT SEARCH METHODS (new) =====

  /// Insert a new recent search
  Future<void> insertRecentSearch(RecentSearchModel search) async {
    // First, delete existing search with same query to avoid duplicates
    await _db?.delete(
      AppStrings.recentSearchesTable,
      where: '${AppStrings.queryField} = ?',
      whereArgs: [search.query],
    );

    // Then insert the new/updated search
    await _db?.insert(
      AppStrings.recentSearchesTable,
      search.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Keep only the most recent searches (limit to 10)
    await _limitRecentSearches();
  }

  /// Delete recent search by ID
  Future<void> deleteRecentSearch(String id) async {
    await _db?.delete(
      AppStrings.recentSearchesTable,
      where: '${AppStrings.idField} = ?',
      whereArgs: [id],
    );
  }

  /// Get all recent searches ordered by most recent first
  Future<List<RecentSearchModel>> getAllRecentSearches() async {
    final List<Map<String, dynamic>>? maps = await _db?.query(
      AppStrings.recentSearchesTable,
      orderBy: '${AppStrings.searchedAtField} DESC',
      limit: 10, // Limit to 10 most recent
    );

    if (maps == null || maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return RecentSearchModel.fromJson(maps[i]);
    });
  }

  /// Delete all recent searches
  Future<void> clearAllRecentSearches() async {
    await _db?.delete(AppStrings.recentSearchesTable);
  }

  /// Limit recent searches to 10 most recent entries
  Future<void> _limitRecentSearches() async {
    if (_db == null) return;

    final countResult = await _db!.rawQuery(
        'SELECT COUNT(*) FROM ${AppStrings.recentSearchesTable}'
    );
    final count = Sqflite.firstIntValue(countResult) ?? 0;

    if (count > 10) {
      await _db!.rawDelete('''
        DELETE FROM ${AppStrings.recentSearchesTable} 
        WHERE ${AppStrings.idField} NOT IN (
          SELECT ${AppStrings.idField} FROM ${AppStrings.recentSearchesTable} 
          ORDER BY ${AppStrings.searchedAtField} DESC 
          LIMIT 10
        )
      ''');
    }
  }

  /// Close the database
  Future<void> close() async {
    await _db?.close();
  }
}