import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';

class AppTheme {
  // ignore: non_constant_identifier_names
  static ThemeData CustomeDarkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark.withValues(alpha: 0.5),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        //color: AppColors.primary,
      ),
    ),

    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   //backgroundColor: AppColors.primary,
    //   foregroundColor: AppColors.white,
    //   // shape: CircleBorder(side: BorderSide(width: 5, color: AppColors.white)),
    // ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.gray,
      ),
      enabledBorder: OutlineInputBorder(
        // borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        // borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        //borderSide: BorderSide(color: AppColors.red),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    textTheme: TextTheme(
      // headlineSmall: TextStyle(
      //   fontSize: 24,
      //   fontWeight: FontWeight.bold,
      //   color: AppColors.white,
      // ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.gray,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        //foregroundColor: AppColors.primary,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    ),

    //primaryColor: AppColors.primary,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white,
      // backgroundColor: AppColors.primary,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // ignore: non_constant_identifier_names
  static ThemeData CustomeLightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark,
  );
}
