import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nytimes/service/article_store.dart';
import 'package:nytimes/state/article_listing/article_listing_cubit.dart';
import 'package:nytimes/ui/article_listing/article_listing_screen.dart';
import 'package:nytimes/ui/home/home_screen.dart';
import 'package:nytimes/ui/landing/landing_screen.dart';
import 'package:nytimes/widget/app_overlays.dart';

Route<dynamic> routeManager(RouteSettings settings) {
  late Widget screen;
  late List<BlocProvider<dynamic>> blocProviderList;
  final GetIt getIt = GetIt.instance;

  switch (settings.name) {
    case LandingScreen.route:
      screen = const LandingScreen();
      blocProviderList = <BlocProvider<dynamic>>[];
      break;
    case HomeScreen.route:
      screen = const HomeScreen();
      blocProviderList = <BlocProvider<dynamic>>[];
      break;
    case ArticleListingScreen.route:
      screen = const ArticleListingScreen();
      blocProviderList = <BlocProvider<dynamic>>[
        BlocProvider<ArticleListingCubit>(
            create: (BuildContext context) =>
                ArticleListingCubit(articleStore: getIt<ArticleStore>())),
      ];
      break;
    default:
      throw Exception('This route name does not exist');
  }

  return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return AppOverlay(
          blocProviderList: blocProviderList,
          child: screen,
        );
      },
      settings: settings);
}
