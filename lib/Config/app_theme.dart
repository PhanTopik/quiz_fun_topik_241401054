import 'package:flutter/material.dart';

class AppTheme {
  // Tema Terang
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Baloo2',
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF5CB733),
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Flix',
        fontWeight: FontWeight.w800,
        color: Colors.black,
        fontSize: 22,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.05),
      labelStyle: const TextStyle(color: Colors.black, fontFamily: 'Baloo2'),
      hintStyle: const TextStyle(color: Colors.black54, fontFamily: 'Baloo2'),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Flix', color: Colors.black),
      displayMedium: TextStyle(fontFamily: 'Flix', color: Colors.black),
      displaySmall: TextStyle(fontFamily: 'Flix', color: Colors.black),
      headlineLarge: TextStyle(fontFamily: 'Flix', color: Colors.black),
      headlineMedium: TextStyle(fontFamily: 'Flix', color: Colors.black),
      headlineSmall: TextStyle(fontFamily: 'Flix', color: Colors.black),
      titleLarge: TextStyle(fontFamily: 'Flix', color: Colors.black),
      titleMedium: TextStyle(fontFamily: 'Flix', color: Colors.black),
      titleSmall: TextStyle(fontFamily: 'Flix', color: Colors.black),
      bodyLarge: TextStyle(fontFamily: 'Baloo2', color: Colors.black),
      bodyMedium: TextStyle(fontFamily: 'Baloo2', color: Colors.black54),
      bodySmall: TextStyle(fontFamily: 'Baloo2', color: Colors.black54),
    ),
  );

  // Tema Gelap
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    fontFamily: 'Baloo2',
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF5CB733),
      surface: Color(0xFF121212),
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Flix',
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontSize: 22,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.1),
      labelStyle: const TextStyle(color: Colors.white, fontFamily: 'Baloo2'),
      hintStyle: const TextStyle(color: Colors.white60, fontFamily: 'Baloo2'),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Flix', color: Colors.white),
      displayMedium: TextStyle(fontFamily: 'Flix', color: Colors.white),
      displaySmall: TextStyle(fontFamily: 'Flix', color: Colors.white),
      headlineLarge: TextStyle(fontFamily: 'Flix', color: Colors.white),
      headlineMedium: TextStyle(fontFamily: 'Flix', color: Colors.white),
      headlineSmall: TextStyle(fontFamily: 'Flix', color: Colors.white),
      titleLarge: TextStyle(fontFamily: 'Flix', color: Colors.white),
      titleMedium: TextStyle(fontFamily: 'Flix', color: Colors.white),
      titleSmall: TextStyle(fontFamily: 'Flix', color: Colors.white),
      bodyLarge: TextStyle(fontFamily: 'Baloo2', color: Colors.white),
      bodyMedium: TextStyle(fontFamily: 'Baloo2', color: Colors.white70),
      bodySmall: TextStyle(fontFamily: 'Baloo2', color: Colors.white60),
    ),
  );
}