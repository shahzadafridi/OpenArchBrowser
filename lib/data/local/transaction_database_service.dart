import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import '../../model/TransactionModel.dart';

class TransactionDatabaseService {
  Database? _db;
  final _uuid = Uuid();

  /// Initialize the local SQLite database with `categories` and `transactions` tables.
  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
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
      },
    );
  }

  /// Insert a new transaction
  Future<void> insertTransaction(TransactionModel transaction) async {
    await _db?.insert(
      'transactions',
      transaction.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete transaction by title (you may change to use an ID instead)
  Future<void> deleteTransaction(String title) async {
    await _db?.delete(
      'transactions',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  /// Delete all transactions
  Future<void> clearAllTransactions() async {
    await _db?.delete('transactions');
  }

  /// Close the database
  Future<void> close() async {
    await _db?.close();
  }
}
