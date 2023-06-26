import 'package:flutter/material.dart';

class SLKTheme {
  static const primaryColor = Color(0xFFC8AA87);
  static const accentColor = Color(0xFF616068);
  static const backgroundColor = Color(0xFFEDEDED);

  static ThemeData get lightTheme =>
      ThemeData.light(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor)
              .copyWith(background: backgroundColor),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)))),
          disabledColor: accentColor);
}
