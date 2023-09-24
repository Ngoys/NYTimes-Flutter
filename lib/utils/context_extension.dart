import 'package:flutter/material.dart';
import 'package:nytimes/config/app_config_provider.dart';
import 'package:nytimes/config/base_config.dart';
import 'package:nytimes/generated/app_localizations.dart';
import 'package:nytimes/modal/route_stack_item.dart';
import 'package:nytimes/utils/app_navigator_observer.dart';
import 'package:nytimes/widget/app_overlay.dart';

extension ContextExtension on BuildContext {
  BaseConfig get config => AppConfigProvider.of(this);

  ThemeData get theme => Theme.of(this);

  AppOverlay? get appOverlay => AppOverlay.of(this);

  AppLocalization get localization => AppLocalization.of(this)!;

  List<RouteStackItem> get navigationStack =>
      AppNavigatorObserver.navigationStack;
}
