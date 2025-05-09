import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF4E81C1, // Color base: rgb(78, 129, 193)
    <int, Color>{
      50: Color(0xFFE1F0F8),
      100: Color(0xFFB3D1E8),
      200: Color(0xFF80B5D9),
      300: Color(0xFF4D99C9),
      400: Color(0xFF2F89C2),
      500: Color(0xFF4E81C1), // Base
      600: Color(0xFF4371B2),
      700: Color(0xFF3960A3),
      800: Color(0xFF2F4F94),
      900: Color(0xFF263F86),
    },
  ); // Primary color: rgb(63, 81, 181)
  static const Color accent = Colors.amber;
  static const Color background = Color(0xFFF5F5F5);
  static const Color sidebar = Color(0xFF1F4E8C);
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: AppColors.primarySwatch,
  colorScheme: ColorScheme.light(
    primary: AppColors.primarySwatch,
    secondary: const Color.fromARGB(255, 28, 255, 7),
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
