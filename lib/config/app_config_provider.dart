import 'package:flutter/material.dart';
import 'package:nytimes/config/app_config.dart';
import 'package:nytimes/config/base_config.dart';

/// Provides App's configurations down the widgets tree.
/// It should wrap the top widget in the tree when possible.
class AppConfigProvider extends InheritedWidget {
  const AppConfigProvider({
    required this.appConfig,
    required super.child,
    super.key,
  });

  final BaseConfig appConfig;

  static BaseConfig of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<AppConfigProvider>()?.appConfig ??
      AppConfig();

  @override
  bool updateShouldNotify(AppConfigProvider oldWidget) => false;
}
