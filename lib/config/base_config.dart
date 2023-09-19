import 'package:flutter/material.dart';

abstract class BaseConfig {
  String appName();

  Map<String, String> endpoints();

  ThemeData lightTheme();

  ThemeData darkTheme();

  Route<dynamic> routeFactory(RouteSettings settings);

  List<Locale> locales();
}
