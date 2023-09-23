import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/config/stylesheet/app_color.dart';
import 'package:nytimes/config/stylesheet/app_font.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/modal/home_menu.dart';
import 'package:nytimes/modal/home_menu_section.dart';
import 'package:nytimes/state/home/home_cubit.dart';
import 'package:nytimes/state/home/home_state.dart';
import 'package:nytimes/state/location/location_cubit.dart';
import 'package:nytimes/state/location/location_state.dart';
import 'package:nytimes/ui/article_listing/article_listing_screen.dart';
import 'package:nytimes/ui/search/search_screen.dart';
import 'package:nytimes/utils/constants.dart';
import 'package:nytimes/utils/context_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;
  late final LocationCubit _locationCubit;

  @override
  void initState() {
    super.initState();

    _homeCubit = BlocProvider.of<HomeCubit>(context);

    _locationCubit = BlocProvider.of<LocationCubit>(context);
    _locationCubit
      ..requestLocationPermission()
      ..subscribeToLocationServiceChange()
      ..subscribeToLocationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localization.titleHomeScreen,
          style: AppFont.titleLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return BlocListener<LocationCubit, LocationState>(
            listener: (BuildContext context, LocationState state) {
              if (state is LocationLoadedState) {
                _homeCubit.addLocationSection(state.position);
              } else {
                _homeCubit.removeLocationSection();
              }
            },
            child: (state is HomeLoadedState)
                ? ListView(
                    children: <Widget>[
                      for (final HomeMenuSection section in state.sections)
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 16, 0, 8),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  section.type.getName(context),
                                  style: AppFont.bodyMedium,
                                ),
                              ),
                            ),
                            ListView.builder(
                              padding: const EdgeInsets.only(bottom: 24),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: section.menus.length,
                              itemBuilder: (BuildContext context, int index) {
                                final HomeMenu menu = section.menus[index];
                                return TextButton(
                                  onPressed: () {
                                    switch (menu) {
                                      case HomeMenu.mostEmailed:
                                        Navigator.pushNamed(
                                            context, ArticleListingScreen.route,
                                            arguments: <String, dynamic>{
                                              NAV_ARTICLE_LISTING_CONTENT_TYPE:
                                                  ArticleListingContentType
                                                      .mostEmailed,
                                            });
                                      case HomeMenu.mostShared:
                                        Navigator.pushNamed(
                                            context, ArticleListingScreen.route,
                                            arguments: <String, dynamic>{
                                              NAV_ARTICLE_LISTING_CONTENT_TYPE:
                                                  ArticleListingContentType
                                                      .mostShared,
                                            });
                                      case HomeMenu.mostViewed:
                                        Navigator.pushNamed(
                                            context, ArticleListingScreen.route,
                                            arguments: <String, dynamic>{
                                              NAV_ARTICLE_LISTING_CONTENT_TYPE:
                                                  ArticleListingContentType
                                                      .mostViewed,
                                            });
                                      case HomeMenu.searchArticle:
                                        Navigator.pushNamed(
                                          context,
                                          SearchScreen.route,
                                        );
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(12),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    foregroundColor: AppColor.primaryBlue,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      menu.getName(context),
                                      style: AppFont.bodyLarge.copyWith(
                                          color: Colors
                                              .black), // Adjust text color
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
