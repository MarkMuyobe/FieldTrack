import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MadTheme {
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.openSans(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  static ThemeData dark() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      appBarTheme: const AppBarTheme(
        foregroundColor: Color(0xFF1E1E1E),
        backgroundColor: Color(0xFF00FF7F),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF4ECB71),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF4ECB71),
      ),
      textTheme: darkTextTheme,
      primaryColor: const Color(0xFF4ECB71),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF4ECB71),
        secondary: Color(0xFF3DAF5C),
      ),
      cardColor: const Color(0xFF2C2C2C),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF4ECB71)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
