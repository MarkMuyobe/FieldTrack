import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MadTheme {
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
    bodyMedium: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white70),
    titleLarge: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
    titleMedium: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.orangeAccent),
    titleSmall: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.yellowAccent),
    labelLarge: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.greenAccent),
    labelMedium: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.cyanAccent),
    labelSmall: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.blueAccent),
  );

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
