import 'package:equatable/equatable.dart';
import 'package:nytimes/modal/home_menu.dart';

class HomeMenuSection extends Equatable {
  const HomeMenuSection({
    required this.type,
    required this.menus,
  });
  final HomeMenuSectionType type;
  final List<HomeMenu> menus;

  @override
  List<Object?> get props => [type, menus];
}

enum HomeMenuSectionType {
  search,
  popular,
  location,
}

extension HomeMenuSectionTypeExtension on HomeMenuSectionType {
  String get name {
    switch (this) {
      case HomeMenuSectionType.search:
        return 'Search';

      case HomeMenuSectionType.popular:
        return 'Popular';

      case HomeMenuSectionType.location:
        return 'Location';
    }
  }
}
