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

  // Constructor
  RecentSearchViewModel({required RecentSearchRepository repository})
      : _repository = repository;

  // Getters
  bool get isLoading => _isLoading;
  bool get isOperationLoading => _isOperationLoading;
  String? get error => _error;
  List<RecentSearchModel> get recentSearches => List.unmodifiable(_recentSearches);
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
      await _repository.init();
      await loadRecentSearches();
    } catch (e) {
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
      _recentSearches = await _repository.getAllRecentSearches();
      notifyListeners();
    } catch (e) {
      _setError(AppStrings.loadRecentSearchesError);
    } finally {
      _setLoading(false);
    }
  }

  /// Add a new recent search
  Future<bool> addRecentSearch(RecentSearchModel search) async {
    _setOperationLoading(true);
    _clearError();

    try {
      await _repository.insertRecentSearch(search);
      await loadRecentSearches(); // Refresh the list
      return true;
    } catch (e) {
      _setError(AppStrings.addRecentSearchError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Add recent search by query string (convenience method)
  Future<bool> addRecentSearchByQuery(String query) async {
    if (query.trim().isEmpty) return false;

    // Don't add if it's the same as the most recent search
    if (_recentSearches.isNotEmpty &&
        _recentSearches.first.query.toLowerCase() == query.trim().toLowerCase()) {
      return true; // Consider it successful, just don't add duplicate
    }

    final search = RecentSearchModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      query: query.trim(),
      timestamp: DateTime.now(),
    );

    return await addRecentSearch(search);
  }

  /// Delete a recent search
  Future<bool> deleteRecentSearch(String id) async {
    _setOperationLoading(true);
    _clearError();

    try {
      await _repository.deleteRecentSearch(id);
      await loadRecentSearches(); // Refresh the list
      return true;
    } catch (e) {
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

    if (search == null) return false;

    return await deleteRecentSearch(search.id);
  }

  /// Clear all recent searches
  Future<bool> clearAllRecentSearches() async {
    _setOperationLoading(true);
    _clearError();

    try {
      await _repository.clearAllRecentSearches();
      _recentSearches = [];
      notifyListeners();
      return true;
    } catch (e) {
      _setError(AppStrings.clearRecentSearchesError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Get filtered recent searches
  List<RecentSearchModel> getFilteredSearches(String filter) {
    if (filter.trim().isEmpty) return recentSearches;

    final lowercaseFilter = filter.toLowerCase();
    return _recentSearches.where((search) {
      return search.query.toLowerCase().contains(lowercaseFilter);
    }).toList();
  }

  /// Get recent searches from a specific time period
  List<RecentSearchModel> getRecentSearchesFromPeriod(Duration period) {
    final cutoffTime = DateTime.now().subtract(period);
    return _recentSearches.where((search) {
      return search.timestamp.isAfter(cutoffTime);
    }).toList();
  }

  /// Get today's searches
  List<RecentSearchModel> getTodaySearches() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    return _recentSearches.where((search) {
      return search.timestamp.isAfter(startOfDay);
    }).toList();
  }

  /// Get most popular searches (by frequency)
  Map<String, int> getSearchFrequency() {
    final frequency = <String, int>{};

    for (final search in _recentSearches) {
      final query = search.query.toLowerCase();
      frequency[query] = (frequency[query] ?? 0) + 1;
    }

    return frequency;
  }

  /// Get top N most frequent searches
  List<String> getMostFrequentSearches({int limit = 5}) {
    final frequency = getSearchFrequency();

    final sortedEntries = frequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedEntries
        .take(limit)
        .map((entry) => entry.key)
        .toList();
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