import '../../model/BookmarkModel.dart';
import '../local/browser_database_service.dart';
import '../repository/bookmark_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BrowserDatabaseService _databaseService;

  BookmarkRepositoryImpl(this._databaseService);

  @override
  Future<void> init() async {
    await _databaseService.init();
  }

  @override
  Future<void> insertBookmark(BookmarkModel bookmark) async {
    await _databaseService.insertBookmark(bookmark);
  }

  @override
  Future<void> deleteBookmark(String id) async {
    await _databaseService.deleteBookmark(id);
  }

  @override
  Future<List<BookmarkModel>> getAllBookmarks() async {
    return await _databaseService.getAllBookmarks();
  }

  @override
  Future<void> clearAllBookmarks() async {
    await _databaseService.clearAllBookmarks();
  }
}