import 'package:flutter/material.dart';
import '../../data/repository/tab_repository.dart';
import '../../model/TabModel.dart';
import '../../resources/string_manager.dart';

class TabViewModel extends ChangeNotifier {
  final TabRepository _repository;

  // Loading states
  bool _isLoading = false;
  bool _isOperationLoading = false;

  // Error state
  String? _error;

  // Data state
  List<TabModel> _tabs = [];

  // Constructor
  TabViewModel({required TabRepository repository}) : _repository = repository;

  // Getters
  bool get isLoading => _isLoading;
  bool get isOperationLoading => _isOperationLoading;
  String? get error => _error;
  List<TabModel> get tabs => List.unmodifiable(_tabs);
  bool get hasTabs => _tabs.isNotEmpty;
  int get tabCount => _tabs.length;

  // Initialize
  Future<void> init() async {
    _setLoading(true);
    _clearError();
    try {
      await _repository.init();
      await loadTabs();
    } catch (e) {
      _setError(AppStrings.initializationError);
    } finally {
      _setLoading(false);
    }
  }

  /// Load all tabs
  Future<void> loadTabs() async {
    _setLoading(true);
    _clearError();
    try {
      _tabs = await _repository.getAllTabs();
      notifyListeners();
    } catch (e) {
      _setError(AppStrings.loadTabsError);
    } finally {
      _setLoading(false);
    }
  }

  /// Add a new tab
  Future<bool> addTab(TabModel tab) async {
    _setOperationLoading(true);
    _clearError();
    try {
      await _repository.insertTab(tab);
      await loadTabs();
      return true;
    } catch (e) {
      _setError(AppStrings.addTabError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Delete a tab
  Future<bool> deleteTab(String id) async {
    _setOperationLoading(true);
    _clearError();
    try {
      await _repository.deleteTab(id);
      await loadTabs();
      return true;
    } catch (e) {
      _setError(AppStrings.deleteTabError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Clear all tabs
  Future<bool> clearAllTabs() async {
    _setOperationLoading(true);
    _clearError();
    try {
      await _repository.clearAllTabs();
      _tabs = [];
      notifyListeners();
      return true;
    } catch (e) {
      _setError(AppStrings.clearTabsError);
      return false;
    } finally {
      _setOperationLoading(false);
    }
  }

  /// Search tabs by title or URL
  List<TabModel> searchTabs(String query) {
    if (query.trim().isEmpty) return tabs;
    final lowercaseQuery = query.toLowerCase();
    return _tabs.where((tab) {
      return tab.title.toLowerCase().contains(lowercaseQuery) ||
          tab.url.toLowerCase().contains(lowercaseQuery);
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

