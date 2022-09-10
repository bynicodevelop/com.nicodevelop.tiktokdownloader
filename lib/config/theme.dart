import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeData {
  static ThemeData themeLight(BuildContext context) {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: kDefaultBackgroundColor,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: kDefaultFontSize * 1.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey[800], // This
        ),
      ),
      textTheme: GoogleFonts.openSansTextTheme(
        base.textTheme.copyWith(
          headline4: base.textTheme.headline4!.copyWith(
            fontSize: kDefaultFontSize * 1.3,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          button: base.textTheme.button!.copyWith(
            color: Colors.grey[800],
            fontSize: 16.0,
            letterSpacing: .9,
            shadows: [],
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDefaultPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 1,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: kDefaultFontSize,
            letterSpacing: 1,
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
