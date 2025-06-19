import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_page_app/utils/app_colors.dart';

class AppStyles {
  static TextStyle headline1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle headline2 = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle subtitle1 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static TextStyle bodyText1 = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static TextStyle bodyText2 = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textColor,
  );

  static TextStyle buttonTextStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}