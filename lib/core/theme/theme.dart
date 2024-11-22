import 'package:aifer_task/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Pallete.greenColor, // Selected icon color
        unselectedItemColor: Pallete.greyColor, // Unselected icon color
        selectedLabelStyle: GoogleFonts.poppins(
          color: Pallete.greenColor, // Selected label color
          fontSize: 16,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          color: Pallete.greyColor, // Unselected label color
          fontSize: 14,
        ),
      ));
}
