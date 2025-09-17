import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:flutter/material.dart';
import '../../data/repository/recent_search_repository.dart';
import '../../model/RecentSearchModel.dart';
import '../../resources/string_manager.dart';

class RecentSearchViewModel extends ChangeNotifier {
  final RecentSearchRepository _repository;

  // Loading states
  bool _isLoading = false;
  bool _isOperationLoading = false;

  // Error state
  String? _error;

  // Data state
  List<RecentSearchModel> _recentSearches = [];
  List<RecentSearchModel> _filteredSearches = [];

  List<RecentSearchModel> get recentSearches =>
      List.unmodifiable(_recentSearches);

  List<RecentSearchModel> get filteredSearches =>
      _filteredSearches.isEmpty ? _recentSearches : _filteredSearches;

  // Constructor
  RecentSearchViewModel({required RecentSearchRepository repository})
      : _repository = repository;

  // Getters
  bool get isLoading => _isLoading;
  bool get isOperationLoading => _isOperationLoading;
  String? get error => _error;

  bool get hasRecentSearches => _recentSearches.isNotEmpty;
  int get recentSearchCount => _recentSearches.length;

  /// Get recent search queries as string list (for UI convenience)
  List<String> get recentSearchQueries =>
      _recentSearches.map((search) => search.query).toList();

  // Initialize
  Future<void> init() async {
    _setLoading(true);
    _clearError();

    try {
      debugPrint("🟡[RecentSearchViewModel] Initializing RecentSearchRepository...");
      await _repository.init();
      debugPrint("✅[RecentSearchViewModel] Repository initialized successfully");
      await loadRecentSearches();
    } catch (e) {
      debugPrint("❌[RecentSearchViewModel] Repository initialization failed: $e");
      _setError(AppStrings.initializationError);
    } finally {
      _setLoading(false);
    }
  }

  /// Load all recent searches
  Future<void> loadRecentSearches() async {
    _setLoading(true);
    _clearError();

    try {
      debugPrint("🟡[RecentSearchViewModel] Loading recent searches from DB...");
      _recentSearches = await _repository.getAllRecentSearches();
      debugPrint("✅[RecentSearchViewModel] Loaded ${_recentSearches.length} recent searches");
      notifyListeners();
    } catch (e) {
      debugPrint("❌[RecentSearchViewModel] Failed to load recent searches: $e");
      _setError(AppStrings.loadRecentSearchesError);
    } finally {
      _setLoading(false);
    }
  }

  /// Add a new recent search
  Future<bool> addRecentSearch(String query) async {
    _setOperationLoading(true);
    _clearError();

    try {
      debugPrint("🟡[RecentSearchViewModel] Adding recent search: $query");
      final search = RecentSearchModel(
        query: query,
        timestamp: DateTime.now(),
      );
      await _repository.insertRecentSearch(search);
      debugPrint("✅[RecentSearchViewModel] Recent search added: $query");
      await loadRecentSearches(); // Refresh the list
      return true;
    } catch (e) {
      debugPrint("❌[RecentSearchViewModel] Failed to add recent search: $e");
      _setError(AppStrings.addRecentSearchError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Add recent search by query string (convenience method)
  Future<bool> addRecentSearchByQuery(String query) async {
    if (query.trim().isEmpty) return false;

    if (_recentSearches.isNotEmpty &&
        _recentSearches.first.query.toLowerCase() ==
            query.trim().toLowerCase()) {
      debugPrint("ℹ️[RecentSearchViewModel] Skipping duplicate recent search: $query");
      return true;
    }

    return await addRecentSearch(query.trim());
  }

  /// Delete a recent search
  Future<bool> deleteRecentSearch(String query) async {
    _setOperationLoading(true);
    _clearError();

    try {
      debugPrint("🟡[RecentSearchViewModel] Deleting recent search: $query");
      await _repository.deleteRecentSearch(query);
      debugPrint("✅[RecentSearchViewModel] Deleted recent search: $query");
      await loadRecentSearches(); // Refresh the list
      return true;
    } catch (e) {
      debugPrint("❌[RecentSearchViewModel] Failed to delete recent search: $e");
      _setError(AppStrings.deleteRecentSearchError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Delete recent search by query
  Future<bool> deleteRecentSearchByQuery(String query) async {
    final search = _recentSearches
        .where((s) => s.query.toLowerCase() == query.toLowerCase())
        .firstOrNull;

    if (search == null) {
      debugPrint("ℹ️[RecentSearchViewModel] No search found for query: $query");
      return false;
    }

    return await deleteRecentSearch(search.query);
  }

  /// Clear all recent searches
  Future<bool> clearAllRecentSearches() async {
    _setOperationLoading(true);
    _clearError();

    try {
      debugPrint("🟡[RecentSearchViewModel] Clearing all recent searches...");
      await _repository.clearAllRecentSearches();
      _recentSearches = [];
      _filteredSearches = [];
      debugPrint("✅[RecentSearchViewModel] Cleared all recent searches");
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("❌[RecentSearchViewModel] Failed to clear recent searches: $e");
      _setError(AppStrings.clearRecentSearchesError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// 🔹 Filter recent searches and update state
  void getFilteredSearches(String filter) {
    if (filter.trim().isEmpty) {
      _filteredSearches = [];
      debugPrint("ℹ️[RecentSearchViewModel] Filter cleared → showing all recent searches");
    } else {
      final lowercaseFilter = filter.toLowerCase();
      _filteredSearches = _recentSearches.where((search) {
        return search.query.toLowerCase().contains(lowercaseFilter);
      }).toList();
      debugPrint(
          "🔍[RecentSearchViewModel] Filter applied: \"$filter\" → ${_filteredSearches.length} matches found");
    }
    notifyListeners();
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

  void clearError() {
    _clearError();
    notifyListeners();
  }

  @override
  void dispose() {
    debugPrint("🛑[RecentSearchViewModel] Disposing RecentSearchViewModel");
    super.dispose();
  }
}