import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = Colors.indigo;
  static const Color accent = Colors.amber;
  static const Color background = Color(0xFFF5F5F5);
  static const Color sidebar = Color(0xFF1F4E8C);
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: AppColors.primarySwatch,
  colorScheme: ColorScheme.light(
    primary: AppColors.primarySwatch,
    secondary: AppColors.accent,
    surface: AppColors.background,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primarySwatch,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primarySwatch,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
  ),
);
