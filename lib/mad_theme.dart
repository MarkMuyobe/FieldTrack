import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MadTheme {
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14, 
      fontWeight: FontWeight.w400,
      color: Colors.white
      ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 12, 
      fontWeight: FontWeight.normal, 
      color: Colors.white70
      ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 30,
      fontWeight: FontWeight.bold, 
      color: Colors.white
      ),
    titleMedium: GoogleFonts.openSans(
      fontSize: 18, 
      fontWeight: FontWeight.w500,
      color: Colors.white
      ),
    titleSmall: GoogleFonts.openSans(
      fontSize: 16, 
      fontWeight: FontWeight.w400, 
      color: Colors.white
      ),
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
