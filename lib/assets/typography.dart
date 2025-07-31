import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komik/assets/palette.dart';

class KomikTypography {
  static TextStyle get base => GoogleFonts.poppins(
    fontSize: 16,
    color: Palette.white,
  );

  static TextStyle get title => GoogleFonts.poppins(
    fontSize: 18,
    color: Palette.white,
    fontWeight: FontWeight.w900
  );

  static TextStyle get toolbar_title => GoogleFonts.poppins(
    fontSize: 24,
    color: Palette.white,
    fontWeight: FontWeight.w900
  );

  static TextStyle get label => GoogleFonts.poppins(
    fontSize: 12,
    color: Palette.white,
    fontWeight: FontWeight.w600
  );

  static TextStyle get subtitles => GoogleFonts.poppins(
    fontSize: 12,
    color: Palette.subtitles,
  );
}