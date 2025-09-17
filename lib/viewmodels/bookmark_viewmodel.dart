import 'package:flutter/material.dart';
import '../../data/repository/bookmark_repository.dart';
import '../../model/BookmarkModel.dart';
import '../../resources/string_manager.dart';

class BookmarkViewModel extends ChangeNotifier {
  final BookmarkRepository _repository;

  // Loading states
  bool _isLoading = false;
  bool _isOperationLoading = false;

  // Error state
  String? _error;

  // Data state
  List<BookmarkModel> _bookmarks = [];

  // Constructor
  BookmarkViewModel({required BookmarkRepository repository})
      : _repository = repository;

  // Getters
  bool get isLoading => _isLoading;
  bool get isOperationLoading => _isOperationLoading;
  String? get error => _error;
  List<BookmarkModel> get bookmarks => List.unmodifiable(_bookmarks);
  bool get hasBookmarks => _bookmarks.isNotEmpty;
  int get bookmarkCount => _bookmarks.length;

  // Initialize
  Future<void> init() async {
    _setLoading(true);
    _clearError();

    try {
      await _repository.init();
      await loadBookmarks();
    } catch (e) {
      _setError(AppStrings.initializationError);
    } finally {
      _setLoading(false);
    }
  }

  /// Load all bookmarks
  Future<void> loadBookmarks() async {
    _setLoading(true);
    _clearError();

    try {
      _bookmarks = await _repository.getAllBookmarks();
      notifyListeners();
    } catch (e) {
      _setError(AppStrings.loadBookmarksError);
    } finally {
      _setLoading(false);
    }
  }

  /// Add a new bookmark
  Future<bool> addBookmark(BookmarkModel bookmark) async {
    _setOperationLoading(true);
    _clearError();

    try {
      await _repository.insertBookmark(bookmark);
      await loadBookmarks(); // Refresh the list
      return true;
    } catch (e) {
      _setError(AppStrings.addBookmarkError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Create and add bookmark from URL and title
  Future<bool> addBookmarkFromUrl(String url, String title, {String? favicon}) async {
    if (url.trim().isEmpty || title.trim().isEmpty) return false;

    final bookmark = BookmarkModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      url: url.trim(),
      favicon: favicon,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await addBookmark(bookmark);
  }

  /// Check if URL is already bookmarked
  bool isBookmarked(String url) {
    return _bookmarks.any((bookmark) => bookmark.url == url);
  }

  /// Get bookmark by URL
  BookmarkModel? getBookmarkByUrl(String url) {
    try {
      return _bookmarks.firstWhere((bookmark) => bookmark.url == url);
    } catch (e) {
      return null;
    }
  }

  /// Delete a bookmark
  Future<bool> deleteBookmark(String id) async {
    _setOperationLoading(true);
    _clearError();

    try {
      await _repository.deleteBookmark(id);
      await loadBookmarks(); // Refresh the list
      return true;
    } catch (e) {
      _setError(AppStrings.deleteBookmarkError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Delete bookmark by URL
  Future<bool> deleteBookmarkByUrl(String url) async {
    final bookmark = getBookmarkByUrl(url);
    if (bookmark == null) return false;

    return await deleteBookmark(bookmark.id);
  }

  /// Toggle bookmark (add if not exists, remove if exists)
  Future<bool> toggleBookmark(String url, String title, {String? favicon}) async {
    if (isBookmarked(url)) {
      return await deleteBookmarkByUrl(url);
    } else {
      return await addBookmarkFromUrl(url, title, favicon: favicon);
    }
  }

  /// Clear all bookmarks
  Future<bool> clearAllBookmarks() async {
    _setOperationLoading(true);
    _clearError();

    try {
      await _repository.clearAllBookmarks();
      _bookmarks = [];
      notifyListeners();
      return true;
    } catch (e) {
      _setError(AppStrings.clearBookmarksError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Search bookmarks by title or URL
  List<BookmarkModel> searchBookmarks(String query) {
    if (query.trim().isEmpty) return bookmarks;

    final lowercaseQuery = query.toLowerCase();
    return _bookmarks.where((bookmark) {
      return bookmark.title.toLowerCase().contains(lowercaseQuery) ||
          bookmark.url.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setOperationLoading(bool loading) {
    _isOperationLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  /// Clear error manually
  void clearError() {
    _clearError();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}