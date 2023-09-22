import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nytimes/utils/context_extension.dart';

class HomeMenu {
  const HomeMenu(this.key, {this.position});
  final String key;
  final Position? position;

  static const String _searchArticleKey = 'searchArticle';
  static const String _mostViewedKey = 'mostViewed';
  static const String _mostSharedKey = 'mostShared';
  static const String _mostEmailedKey = 'mostEmailed';
  static const String _locationKey = 'location';

  static const HomeMenu searchArticle = HomeMenu(_searchArticleKey);
  static const HomeMenu mostViewed = HomeMenu(_mostViewedKey);
  static const HomeMenu mostShared = HomeMenu(_mostSharedKey);
  static const HomeMenu mostEmailed = HomeMenu(_mostEmailedKey);
  // ignore: prefer_constructors_over_static_methods
  static HomeMenu location(Position position) {
    return HomeMenu(_locationKey, position: position);
  }

  String getName(BuildContext context) {
    switch (key) {
      case _searchArticleKey:
        return context.localization.homeMenuSearchArticleTitle;
      case _mostViewedKey:
        return context.localization.homeMenuMostViewedTitle;
      case _mostSharedKey:
        return context.localization.homeMenuMostSharedTitle;
      case _mostEmailedKey:
        return context.localization.homeMenuMostEmailedTitle;
      case _locationKey:
        if (position != null) {
          return '$position';
        }
        break;
    }
    return '';
  }
}
