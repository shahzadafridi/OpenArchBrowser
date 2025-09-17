import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {

  // Loading states
  bool _isLoading = false;
  bool _isInitialized = false;

  // Error state
  String? _error;

  // Getters
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  String? get error => _error;

  /// Initialize the main application
  Future<void> init() async {
    if (_isInitialized) return; // Prevent double initialization

    _setLoading(true);
    _clearError();
  }

  /// Refresh application state
  Future<void> refresh() async {
    await init();
  }

  /// Reset application state
  void reset() {
    _isInitialized = false;
    _clearError();
    notifyListeners();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
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