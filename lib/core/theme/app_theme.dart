import 'package:flutter/material.dart';

class AppTheme {
  // Brand palette
  static const Color primary = Color.fromARGB(255, 241, 216, 23); // deep blue
  static const Color secondary = Color.fromARGB(255, 67, 151, 54); // amber
  static const Color background = Color(0xFFF5F7FA); // light grey
  static const Color surface = Color(
    0xFFFFFFFF,
  ); // white surface for light theme

  // Text styles (customizable)
  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );

  static final ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    error: Colors.red.shade700,
    onError: Colors.white,
    surface: surface,
    onSurface: Colors.black,
    // background/onBackground are deprecated; prefer surface/onSurface.
  );

  static final ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF90CAF9),
    onPrimary: Colors.black,
    secondary: const Color(0xFFFFE082),
    onSecondary: Colors.black,
    error: Colors.red.shade400,
    onError: Colors.black,
    surface: const Color(0xFF0F1720),
    onSurface: Colors.white,
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: _lightScheme,
    textTheme: _textTheme.apply(
      bodyColor: _lightScheme.onSurface,
      displayColor: _lightScheme.onSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _lightScheme.primary,
      titleTextStyle: TextStyle(
        color: _lightScheme.onPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightScheme.secondary,
      foregroundColor: _lightScheme.onSecondary,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: _darkScheme,
    textTheme: _textTheme.apply(
      bodyColor: const Color.fromARGB(255, 33, 32, 32),
      displayColor: const Color.fromARGB(255, 0, 0, 0),
    ),
    scaffoldBackgroundColor: _darkScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkScheme.surface,
      titleTextStyle: TextStyle(
        color: _darkScheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkScheme.secondary,
      foregroundColor: _darkScheme.onSecondary,
    ),
  );
}
