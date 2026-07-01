import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextTheme getTextTheme(TextTheme base) {
    return GoogleFonts.interTextTheme(base).copyWith(
      displayLarge: GoogleFonts.inter(
        textStyle: base.displayLarge,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),

      displayMedium: GoogleFonts.inter(
        textStyle: base.displayMedium,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),

      displaySmall: GoogleFonts.inter(
        textStyle: base.displaySmall,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),

      headlineMedium: GoogleFonts.inter(
        textStyle: base.headlineMedium,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),

      titleLarge: GoogleFonts.inter(
        textStyle: base.titleLarge,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),

      bodyLarge: GoogleFonts.inter(
        textStyle: base.bodyLarge,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),

      bodyMedium: GoogleFonts.inter(
        textStyle: base.bodyMedium,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),

      labelMedium: GoogleFonts.inter(
        textStyle: base.labelMedium,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}