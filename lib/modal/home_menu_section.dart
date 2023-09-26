import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nytimes/modal/home_menu.dart';
import 'package:nytimes/utils/context_extension.dart';

class HomeMenuSection extends Equatable {
  const HomeMenuSection({
    required this.type,
    required this.menus,
  });
  final HomeMenuSectionType type;
  final List<HomeMenu> menus;

  @override
  List<Object?> get props => <Object?>[type, menus];

  @override
  bool operator ==(Object other) {
    if (other is! HomeMenuSection) {
      return false;
    }
    return type == other.type;
  }

  @override
  int get hashCode => type.hashCode;
}

enum HomeMenuSectionType {
  search,
  popular,
  location,
}

extension HomeMenuSectionTypeExtension on HomeMenuSectionType {
  String getName(BuildContext context) {
    switch (this) {
      case HomeMenuSectionType.search:
        return context.localization.homeMenuSearchTitle;
      case HomeMenuSectionType.popular:
        return context.localization.homeMenuPopularTitle;
      case HomeMenuSectionType.location:
        return context.localization.homeMenuLocationTitle;
    }
  }
}
