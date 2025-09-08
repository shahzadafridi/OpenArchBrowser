import 'dart:ui';
import 'package:flutter/material.dart';

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