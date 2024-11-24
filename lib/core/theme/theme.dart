import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: const Color.fromRGBO(118, 85, 250, 1.0),
      secondary: Colors.grey[300]!,
      surface: Colors.white,
      onPrimary: Colors.black,
      tertiary: const Color(0xFFF3F3F3),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.grey),
    ));

final ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: const Color.fromRGBO(118, 85, 250, 1.0),
    secondary: Colors.grey[800]!,
    surface: Colors.grey[900]!,
    onPrimary: Colors.white,
    tertiary: const Color(0xFF1F1F1F),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.grey),
  ),
);
