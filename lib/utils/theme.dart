import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF964F66),
    //  cardColor: Color(0xFF964F66),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF2E8EB),
      iconTheme: IconThemeData(color: Color(0xFF964F66)),
      titleTextStyle: TextStyle(
        color: Color(0xFF964F66),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: AppColors.black),
      bodyText2: TextStyle(color: AppColors.darkGray, fontSize: 10),
      headline6: TextStyle(
          color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF964F66),
        onPrimary: AppColors.white,
        side: const BorderSide(color: AppColors.iconGray),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.black,
    scaffoldBackgroundColor: AppColors.darkGray,
    appBarTheme: const AppBarTheme(
      color: AppColors.black,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: AppColors.white),
      bodyText2: TextStyle(color: AppColors.lightGray),
      headline6: TextStyle(
          color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryRed,
        onPrimary: AppColors.white,
        side: const BorderSide(color: AppColors.iconGray),
      ),
    ),
  );
}
