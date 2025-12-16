import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData _theme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF6750A4),
        secondary: Colors.white,
      ),
      primaryColor: Color(0xFF6750A4),

      scaffoldBackgroundColor: const Color(0xFF250A29),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,

        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.manrope(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -1,
        ),
        centerTitle: false,
      ),
      textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(30),
        ),
        labelStyle: const TextStyle(fontSize: 16),
        floatingLabelStyle: const TextStyle(fontSize: 16),
      ),
    );
  }

  ThemeData get theme => _theme();
}
