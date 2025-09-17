import 'dart:ui';
import 'package:flutter/material.dart';

import '../model/RecentSearchModel.dart';

final Map<String, String> siteUrls = {
  'Google': 'https://www.google.com',
  'Wikipedia': 'https://www.wikipedia.org',
  'YouTube': 'https://www.youtube.com',
};

final shortcuts = [
  {
    "title": "Google",
    "prefix": "G",
    "color": const Color(0xFF4285F4),
  },
  {
    "title": "Wikipedia",
    "prefix": "W",
    "color": Colors.black,
  },
  {
    "title": "YouTube",
    "prefix": "",
    "color": const Color(0xFFFF0000),
  },
];
// Dummy recent searches for UI testing
final List<RecentSearchModel> dummyRecentSearches = [
  RecentSearchModel(query: 'Flutter widgets', timestamp: DateTime.now()),
  RecentSearchModel(query: 'Dart async programming', timestamp: DateTime.now()),
  RecentSearchModel(query: 'Material Design 3', timestamp: DateTime.now()),
  RecentSearchModel(query: 'State management Flutter', timestamp: DateTime.now()),
  RecentSearchModel(query: 'Firebase authentication', timestamp: DateTime.now()),
  RecentSearchModel(query: 'REST API integration', timestamp: DateTime.now()),
  RecentSearchModel(query: 'Flutter animations', timestamp: DateTime.now()),
  RecentSearchModel(query: 'Custom painters Flutter', timestamp: DateTime.now()),
];