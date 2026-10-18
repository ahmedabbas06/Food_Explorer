import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF8A3D),
      secondary: Color(0xFFFF8A3D),
      surface: Color(0xFF1D1D1D),
      onSurface: Colors.white,
      onSurfaceVariant: Color(0xFFB4AAAA),
    ),

    dividerColor: const Color(0xFF2A2A2A),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
    ),

    cardTheme: const CardThemeData(
      color: Color(0xFF1D1D1D),
      elevation: 0,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8F8F8),

    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFF8A3D),
      secondary: Color(0xFFFF8A3D),
      surface: Colors.white,
      onSurface: Color(0xFF121212),
      onSurfaceVariant: Color(0xFF666666),
    ),

    dividerColor: const Color(0xFFE0E0E0),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
    ),

    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 0,
    ),
  );
}