import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData _theme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      primaryColor: Color(0xFF6750A4),

      scaffoldBackgroundColor: const Color(0xFF250A29),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: false,
      ),
      textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
    );
  }

  ThemeData get theme => _theme();
}
