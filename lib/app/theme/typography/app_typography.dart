import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextTheme textTheme = GoogleFonts.interTextTheme().copyWith(
    displayLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),

    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),

    titleLarge:  GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    bodyLarge:  GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),

    bodyMedium:  GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    labelMedium:  GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
}