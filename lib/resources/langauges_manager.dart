import 'package:flutter/material.dart';

// Supported Locales
const Locale ARABIC_LOCALE = Locale('ar', 'SA');
const Locale ENGLISH_LOCALE = Locale('en', 'US');

// Asset Path for Localizations
const String ASSET_PATH_LOCALISATIONS = 'assets/translations';

// Language Codes
class LanguageType {
  static const String ENGLISH = 'en';
  static const String ARABIC = 'ar';
}

// Language Manager Class
class LanguagesManager {
  static const List<Locale> supportedLocales = [
    ENGLISH_LOCALE,
    ARABIC_LOCALE,
  ];

  static Locale getLocale(String languageCode) {
    switch (languageCode) {
      case LanguageType.ENGLISH:
        return ENGLISH_LOCALE;
      case LanguageType.ARABIC:
        return ARABIC_LOCALE;
      default:
        return ENGLISH_LOCALE;
    }
  }

  static bool isRTL(Locale locale) {
    return locale.languageCode == LanguageType.ARABIC;
  }

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case LanguageType.ENGLISH:
        return 'English';
      case LanguageType.ARABIC:
        return 'العربية';
      default:
        return 'English';
    }
  }

  static String getFlagAsset(String languageCode) {
    switch (languageCode) {
      case LanguageType.ENGLISH:
        return 'assets/images/flags/us.png';
      case LanguageType.ARABIC:
        return 'assets/images/flags/sa.png';
      default:
        return 'assets/images/flags/us.png';
    }
  }
}