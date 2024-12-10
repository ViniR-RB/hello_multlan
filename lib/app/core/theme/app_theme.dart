import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';

sealed class AppTheme {
  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  );
  static BoxShadow boxShadowDefault = BoxShadow(
    color: AppColors.primaryColor,
    spreadRadius: 0,
    blurRadius: 12,
    offset: const Offset(0, 0),
  );
  static final ThemeData _lighTheme = ThemeData(
    fontFamily: "Montserrat",
    scaffoldBackgroundColor: AppColors.primaryColor,
    colorSchemeSeed: AppColors.primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
        textStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(centerTitle: true),
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
        border: _border.copyWith(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: _border.copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        iconSize: 48,
        foregroundColor: AppColors.cardColor),
  );

  static final ThemeData _darkTheme = _lighTheme.copyWith(
    brightness: Brightness.dark,
  );

  static ThemeData get darkTheme => _darkTheme;

  static ThemeData get lighTheme => _lighTheme;

  static TextStyle labelInput = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xFF262626),
      letterSpacing: 1.5);
}
