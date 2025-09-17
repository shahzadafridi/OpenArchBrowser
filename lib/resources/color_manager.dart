import 'package:flutter/material.dart';

class ColorManager {
  // Dark Theme Colors
  static Color darkBackground = HexColor.fromHex("#121212"); // Dark background
  static Color darkSurface = HexColor.fromHex("#1E1E1E"); // Dark surface
  static Color darkCard = HexColor.fromHex("#2C2C2C"); // Dark card
  static Color lightGrey =
      HexColor.fromHex("#E0E0E0"); // Light grey for dark theme text
  static Color mediumGrey = HexColor.fromHex("#9E9E9E"); // Medium grey

  // Additional dark theme variants
  static Color darkPrimary =
      HexColor.fromHex("#1976D2"); // Dark theme primary variant
  static Color darkSecondary =
      HexColor.fromHex("#03DAC6"); // Dark theme secondary
  static Color darkError = HexColor.fromHex("#CF6679"); // Dark theme error

  // Status bar colors
  static Color darkStatusBar = HexColor.fromHex("#000000"); // Dark status bar
  static Color lightStatusBar = HexColor.fromHex("#FFFFFF"); // Light status bar

  // Border colors for dark theme
  static Color darkBorder = HexColor.fromHex("#333333"); // Dark border
  static Color lightBorder = HexColor.fromHex("#E0E0E0"); // Light border

  static Color primary = const Color(0xff3F8782);
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);

  static Color lightPrimary = const Color(0xff69AEA9); // color with 80% opacity
  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static Color error = const Color(0xffe61f34);

  static Color orange = const Color(0xffef6c00);
  static Color orangeLight = const Color(0xffffe0b2);

  static Color black = const Color(0xff000000);
  static Color green = const Color(0xff25A969);
  static Color red = const Color(0xffF96251);

  static const Color gradientStart = Color(0xFF69AEA9);
  static const Color gradientEnd = Color(0xFF3F8782);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color lineChartGradientStart = Color(0x4D438883);
  static const Color lineChartGradientend = Color(0x3F8782);
  static const LinearGradient lineChartGradient = LinearGradient(
    colors: [lineChartGradientStart, lineChartGradientend],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// Helper extension if you don't have it
extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
