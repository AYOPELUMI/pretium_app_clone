import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF6200EE),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFF03DAC6),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: const TextStyle(
        fontSize: 18,
        color: Colors.grey,
      ),
    ),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xFFBB86FC),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFF03DAC6),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: const TextStyle(
        fontSize: 18,
        color: Colors.grey,
      ),
    ),
  );
}
