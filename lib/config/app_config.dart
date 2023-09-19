import 'package:flutter/material.dart';
import 'package:nytimes/config/base_config.dart';
import 'package:nytimes/config/stylesheet/app_theme.dart';
import 'package:nytimes/ui/route/routes_manager.dart';

class AppConfig extends BaseConfig {
  @override
  String appName() => 'New York Times';

  @override
  Map<String, String> endpoints() => <String, String>{
        'baseUrl': const String.fromEnvironment('BASE_URL',
            defaultValue: 'https://newh-sqa1.ocs-support.com/')
      };

  @override
  List<Locale> locales() => <Locale>[
        const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        const Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
      ];

  @override
  Route<dynamic> routeFactory(RouteSettings settings) =>
      routesManager(settings);

  @override
  ThemeData lightTheme() {
    return AppTheme.lightTheme;
  }

  @override
  ThemeData darkTheme() {
    return AppTheme.darkTheme;
  }
}
