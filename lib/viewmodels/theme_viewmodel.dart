import 'package:flutter/material.dart';
import '../../resources/theme_manager.dart';
import '../../resources/string_manager.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = false;
  bool _isInitialized = false;

  // Getters
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _isDarkMode;

  bool get isInitialized => _isInitialized;

  ThemeData get lightTheme => getApplicationTheme();

  ThemeData get darkTheme => getDarkApplicationTheme();

  /// Initialize theme from saved preferences
  Future<void> init() async {
    // TODO: Load theme preference from SharedPreferences or similar
    // For now, using system default
    _themeMode = ThemeMode.system;
    _updateDarkModeStatus();
    _isInitialized = true;
    notifyListeners();
  }

  /// Toggle between light and dark theme
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
  }

  /// Set light theme
  void setLightTheme() {
    _themeMode = ThemeMode.light;
    _isDarkMode = false;
    notifyListeners();
    _saveThemePreference();
  }

  /// Set dark theme
  void setDarkTheme() {
    _themeMode = ThemeMode.dark;
    _isDarkMode = true;
    notifyListeners();
    _saveThemePreference();
  }

  /// Set system theme
  void setSystemTheme() {
    _themeMode = ThemeMode.system;
    _updateDarkModeStatus();
    notifyListeners();
    _saveThemePreference();
  }

  /// Update dark mode status based on system
  void _updateDarkModeStatus() {
    // This will be updated by the system when theme changes
    // You can listen to MediaQuery changes in your MaterialApp
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
  }

  /// Save theme preference (implement with SharedPreferences)
  Future<void> _saveThemePreference() async {
    // TODO: Save to SharedPreferences
    // await SharedPreferences.getInstance().then((prefs) {
    //   prefs.setString('theme_mode', _themeMode.toString());
    // });
  }

  /// Get theme mode name for UI
  String get themeModeDisplayName {
    switch (_themeMode) {
      case ThemeMode.light:
        return AppStrings.lightTheme;
      case ThemeMode.dark:
        return AppStrings.darkTheme;
      case ThemeMode.system:
        return AppStrings.systemTheme;
    }
  }

  /// Get theme icon for UI
  IconData get themeIcon {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_brightness;
    }
  }
}
