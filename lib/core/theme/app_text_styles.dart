import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Headings
  static TextStyle get h1 =>
      GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2);

  static TextStyle get h2 =>
      GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, height: 1.2);

  static TextStyle get h3 =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get h4 =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get h5 =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, height: 1.4);

  static TextStyle get h6 =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, height: 1.4);

  // Body Text
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Button Text
  static TextStyle get button =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, height: 1.2);

  static TextStyle get buttonSmall =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, height: 1.2);

  // Caption and Labels
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );

  static TextStyle get label =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, height: 1.2);

  // Input Field
  static TextStyle get input => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  static TextStyle get inputLabel =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, height: 1.2);

  // Link
  static TextStyle get link => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    decoration: TextDecoration.underline,
  );
}
