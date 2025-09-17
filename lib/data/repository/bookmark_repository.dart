import '../../model/BookmarkModel.dart';

abstract class BookmarkRepository {
  Future<void> init();
  Future<void> insertBookmark(BookmarkModel bookmark);
  Future<void> deleteBookmark(String id);
  Future<List<BookmarkModel>> getAllBookmarks();
  Future<void> clearAllBookmarks();
}

