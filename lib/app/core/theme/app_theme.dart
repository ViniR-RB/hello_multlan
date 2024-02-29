import 'package:flutter/material.dart';

sealed class AppTheme {
  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );
  static final ThemeData _lighTheme = ThemeData(
    colorSchemeSeed: Colors.blue[300],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: _border,
        errorBorder: _border.copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        )),
  );

  static final ThemeData _darkTheme = _lighTheme.copyWith(
    brightness: Brightness.dark,
  );

  static ThemeData get darkTheme => _darkTheme;

  static ThemeData get lighTheme => _lighTheme;
}
