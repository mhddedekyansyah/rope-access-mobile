import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const primary = Color(0xFFF1F0F2);
  static const secondary = Color(0xFF504F5E);
  static const background = Colors.white;
  static const background2 = Color(0xFF252836);
  static const background3 = Color(0xFF242231);
  static const purple = Color(0xFF6C5ECF);
  static const formfill = Color(0xFF2B2937);
  static const accent = Color(0xFF38ABBE);
  static const price = Color(0xFF2C96F1);
  static const textDark = Color(0xFF53585A);
  static const textLigth = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF303334);
  static const red = Colors.red;
}

abstract class AppTextStyle {
  static TextStyle primaryStyle = GoogleFonts.poppins(color: AppColors.primary);
  static TextStyle secondaryStyle = GoogleFonts.poppins(
      color: AppColors.secondary, fontWeight: AppFontWeight.regular);
  static TextStyle purpleStyle = GoogleFonts.poppins(
      color: AppColors.purple, fontWeight: AppFontWeight.regular);
  static TextStyle priceStyle = GoogleFonts.poppins(
      color: AppColors.price, fontWeight: AppFontWeight.regular);
}

abstract class AppFontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extrabold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

abstract class _DarkColors {
  static const background = AppColors.background;
  static const card = AppColors.cardDark;
}

class AppTheme {
  static const accentColor = AppColors.accent;
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  final darkBase = ThemeData.dark();

  ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        visualDensity: visualDensity,
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: AppColors.primary,
        ),
        appBarTheme: darkBase.appBarTheme.copyWith(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: AppFontWeight.bold,
            fontSize: 17,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        scaffoldBackgroundColor: _DarkColors.background,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.purple),
        ),
        cardColor: _DarkColors.card,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.textLigth),
        ),
        iconTheme: const IconThemeData(color: AppColors.accent),
        colorScheme: darkBase.colorScheme
            .copyWith(secondary: accentColor)
            .copyWith(background: _DarkColors.background),
      );
}

abstract class AppSpacer {
  static double defaultMargin = 24;
  static double defaultPadding = 24;
}
