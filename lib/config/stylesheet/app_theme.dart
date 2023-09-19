import 'package:flutter/material.dart';
import 'package:nytimes/config/stylesheet/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _getThemeData(Brightness.light);

  static ThemeData get darkTheme => _getThemeData(Brightness.dark);

  static ThemeData _getThemeData(Brightness brightness) {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primaryBlue,
        brightness: brightness,
      ),
      useMaterial3: true,
    );
  }
}
