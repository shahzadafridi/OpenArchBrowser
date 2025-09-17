import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../resources/langauges_manager.dart';

class LanguageViewModel extends ChangeNotifier {
  Locale _currentLocale = ENGLISH_LOCALE;
  bool _isInitialized = false;

  // Getters
  Locale get currentLocale => _currentLocale;
  List<Locale> get supportedLocales => LanguagesManager.supportedLocales;
  bool get isRTL => LanguagesManager.isRTL(_currentLocale);
  String get currentLanguageName => LanguagesManager.getLanguageName(_currentLocale.languageCode);
  String get currentFlagAsset => LanguagesManager.getFlagAsset(_currentLocale.languageCode);
  bool get isInitialized => _isInitialized;

  /// Initialize language from saved preferences
  Future<void> init(BuildContext context) async {
    _currentLocale = context.locale;
    _isInitialized = true;
    notifyListeners();
  }

  /// Change app language
  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    final newLocale = LanguagesManager.getLocale(languageCode);

    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;

      // Change EasyLocalization locale
      await context.setLocale(newLocale);

      notifyListeners();
      _saveLanguagePreference(languageCode);
    }
  }

  /// Toggle between Arabic and English
  Future<void> toggleLanguage(BuildContext context) async {
    final newLanguageCode = _currentLocale.languageCode == LanguageType.ENGLISH
        ? LanguageType.ARABIC
        : LanguageType.ENGLISH;

    await changeLanguage(context, newLanguageCode);
  }

  /// Set English language
  Future<void> setEnglish(BuildContext context) async {
    await changeLanguage(context, LanguageType.ENGLISH);
  }

  /// Set Arabic language
  Future<void> setArabic(BuildContext context) async {
    await changeLanguage(context, LanguageType.ARABIC);
  }

  /// Get all available languages for UI
  List<LanguageOption> getLanguageOptions() {
    return [
      LanguageOption(
        code: LanguageType.ENGLISH,
        name: LanguagesManager.getLanguageName(LanguageType.ENGLISH),
        nativeName: 'English',
        flagAsset: LanguagesManager.getFlagAsset(LanguageType.ENGLISH),
        locale: ENGLISH_LOCALE,
      ),
      LanguageOption(
        code: LanguageType.ARABIC,
        name: LanguagesManager.getLanguageName(LanguageType.ARABIC),
        nativeName: 'العربية',
        flagAsset: LanguagesManager.getFlagAsset(LanguageType.ARABIC),
        locale: ARABIC_LOCALE,
      ),
    ];
  }

  /// Check if given language is current
  bool isCurrentLanguage(String languageCode) {
    return _currentLocale.languageCode == languageCode;
  }

  /// Save language preference (implement with SharedPreferences)
  Future<void> _saveLanguagePreference(String languageCode) async {
    // TODO: Save to SharedPreferences
    // await SharedPreferences.getInstance().then((prefs) {
    //   prefs.setString('language_code', languageCode);
    // });
  }

  /// Load language preference (implement with SharedPreferences)
  Future<String?> _loadLanguagePreference() async {
    // TODO: Load from SharedPreferences
    // return await SharedPreferences.getInstance().then((prefs) {
    //   return prefs.getString('language_code');
    // });
    return null;
  }
}

/// Language option model for UI
class LanguageOption {
  final String code;
  final String name;
  final String nativeName;
  final String flagAsset;
  final Locale locale;

  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flagAsset,
    required this.locale,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageOption && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}