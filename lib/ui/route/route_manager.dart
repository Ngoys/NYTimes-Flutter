import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/ui/landing/landing_screen.dart';

Route<dynamic> routeManager(RouteSettings settings) {
  late Widget screen;
  late List<BlocProvider<dynamic>> blocProviderList;

  switch (settings.name) {
    case LandingScreen.route:
      screen = const LandingScreen();
      blocProviderList = <BlocProvider<dynamic>>[];
      break;
    default:
      throw Exception('This route name does not exist');
  }

  return MaterialPageRoute<dynamic>(builder: (_) => screen, settings: settings);
}
