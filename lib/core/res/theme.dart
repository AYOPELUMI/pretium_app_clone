import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PretiumTheme {
  final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF15645E),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF15645E),
      secondary: Color(0xFF03DAC6),
      surface: Colors.white,
      background: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.2,
      ),
      headlineMedium: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: const TextStyle(
        fontSize: 18,
        color: Color(0xFF666666),
        height: 1.5,
      ),
      bodyMedium: const TextStyle(
        fontSize: 16,
        color: Color(0xFF666666),
      ),
      labelLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.transparent),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.5,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1.5,
          )),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFF15645E),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      hintStyle: TextStyle(
        color: Colors.grey.withOpacity(0.8),
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF15645E),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xFF15645E),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF15645E),
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFF1E1E1E),
      background: Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.2,
      ),
      headlineMedium: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: const TextStyle(
        fontSize: 18,
        color: Color(0xFFA0A0A0),
        height: 1.5,
      ),
      bodyMedium: const TextStyle(
        fontSize: 16,
        color: Color(0xFFA0A0A0),
      ),
      labelLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.5,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1.5,
          )),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFF15645E),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      hintStyle: TextStyle(
        color: Colors.grey.withOpacity(0.8),
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
    ),
  );
}

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Convenience methods
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get textColor =>
      Theme.of(this).textTheme.bodyMedium?.color ?? Colors.black;
  Color get hintColor => Theme.of(this).hintColor;
}
