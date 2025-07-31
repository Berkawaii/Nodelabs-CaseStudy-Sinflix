import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.darkText,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.darkText,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText,
        error: AppColors.error,
        onError: AppColors.darkText,
        outline: AppColors.darkBorder,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h5.copyWith(color: AppColors.darkText),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFillDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTextStyles.inputLabel.copyWith(color: AppColors.grey),
        hintStyle: AppTextStyles.input.copyWith(color: AppColors.grey),
        prefixIconColor: AppColors.grey,
        suffixIconColor: AppColors.grey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.darkText,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkText,
          side: const BorderSide(color: AppColors.inputBorderDark),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.h1.copyWith(color: AppColors.darkText),
        headlineMedium: AppTextStyles.h2.copyWith(color: AppColors.darkText),
        headlineSmall: AppTextStyles.h3.copyWith(color: AppColors.darkText),
        titleLarge: AppTextStyles.h4.copyWith(color: AppColors.darkText),
        titleMedium: AppTextStyles.h5.copyWith(color: AppColors.darkText),
        titleSmall: AppTextStyles.h6.copyWith(color: AppColors.darkText),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.darkText),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkText,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.darkText),
        labelLarge: AppTextStyles.button.copyWith(color: AppColors.darkText),
        labelMedium: AppTextStyles.label.copyWith(color: AppColors.darkText),
        labelSmall: AppTextStyles.caption.copyWith(color: AppColors.grey),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.lightBackground,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightText,
        error: AppColors.error,
        onError: AppColors.lightBackground,
        outline: AppColors.lightBorder,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h5.copyWith(color: AppColors.lightText),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFillLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTextStyles.inputLabel.copyWith(
          color: AppColors.greyDark,
        ),
        hintStyle: AppTextStyles.input.copyWith(color: AppColors.grey),
        prefixIconColor: AppColors.grey,
        suffixIconColor: AppColors.grey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightBackground,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightText,
          side: const BorderSide(color: AppColors.inputBorderLight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.h1.copyWith(color: AppColors.lightText),
        headlineMedium: AppTextStyles.h2.copyWith(color: AppColors.lightText),
        headlineSmall: AppTextStyles.h3.copyWith(color: AppColors.lightText),
        titleLarge: AppTextStyles.h4.copyWith(color: AppColors.lightText),
        titleMedium: AppTextStyles.h5.copyWith(color: AppColors.lightText),
        titleSmall: AppTextStyles.h6.copyWith(color: AppColors.lightText),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.lightText),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightText,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.lightText),
        labelLarge: AppTextStyles.button.copyWith(color: AppColors.lightText),
        labelMedium: AppTextStyles.label.copyWith(color: AppColors.lightText),
        labelSmall: AppTextStyles.caption.copyWith(color: AppColors.grey),
      ),
    );
  }
}
