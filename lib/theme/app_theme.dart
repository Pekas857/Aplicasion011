import 'package:flutter/material.dart';

class AppColors {
  // Primary dark background
  static const Color background = Color(0xFF1A1209);
  static const Color surface = Color(0xFF2A1F10);
  static const Color surfaceLight = Color(0xFF3A2D18);
  static const Color cardBackground = Color(0xFF2D2215);

  // Golden / amber accent
  static const Color gold = Color(0xFFD4A843);
  static const Color goldLight = Color(0xFFE8C860);
  static const Color goldDark = Color(0xFFB8922E);
  static const Color goldMuted = Color(0xFF8B7340);

  // Text colors
  static const Color textPrimary = Color(0xFFF5EFE0);
  static const Color textSecondary = Color(0xFFB0A58E);
  static const Color textMuted = Color(0xFF7A7060);

  // Tag / badge colors
  static const Color mayaTag = Color(0xFF5A7A3A);
  static const Color mayaTagText = Color(0xFFC0D4A0);
  static const Color mexTag = Color(0xFFD4A843);
  static const Color incaTag = Color(0xFF4A8B8B);
  static const Color olmecaTag = Color(0xFF8B6040);

  // Chip colors
  static const Color chipSelected = Color(0xFF3A2D18);
  static const Color chipBorder = Color(0xFF5A4D30);
  static const Color chipUnselected = Colors.transparent;

  // Bottom nav
  static const Color navInactive = Color(0xFF7A7060);
  static const Color navActive = Color(0xFFD4A843);

  // Divider
  static const Color divider = Color(0xFF3A2D18);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        secondary: AppColors.goldLight,
        surface: AppColors.surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Serif',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 3.0,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.gold),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.textMuted,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: AppColors.gold,
        ),
      ),
    );
  }
}
