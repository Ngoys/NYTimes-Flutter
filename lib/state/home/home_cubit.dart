import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nytimes/modal/home_menu.dart';
import 'package:nytimes/modal/home_menu_section.dart';
import 'package:nytimes/state/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const UnknownHomeState()) {
    const HomeMenuSection searchSection = HomeMenuSection(
        type: HomeMenuSectionType.search,
        menus: <HomeMenu>[HomeMenu.searchArticle]);
    const HomeMenuSection popularSection = HomeMenuSection(
        type: HomeMenuSectionType.popular,
        menus: <HomeMenu>[
          HomeMenu.mostViewed,
          HomeMenu.mostShared,
          HomeMenu.mostEmailed
        ]);

    const List<HomeMenuSection> sections = <HomeMenuSection>[
      searchSection,
      popularSection
    ];

    emit(const HomeLoadedState(sections));
  }

  void addLocationSection(Position position) {
    if (state is HomeLoadedState) {
      List<HomeMenuSection> sections = (state as HomeLoadedState).sections;

      final HomeMenuSection locationSection = HomeMenuSection(
          type: HomeMenuSectionType.location,
          menus: <HomeMenu>[HomeMenu.location(position)]);
      final int index = sections.indexWhere((HomeMenuSection element) =>
          element.type == HomeMenuSectionType.location);
      if (index == -1) {
        sections = <HomeMenuSection>[...sections, locationSection];
      } else {
        sections[index] = locationSection;
      }

      emit(const HomeIsLoadingState());
      emit(HomeLoadedState(sections));
    }
  }

  void removeLocationSection() {
    if (state is HomeLoadedState) {
      final List<HomeMenuSection> sections = (state as HomeLoadedState).sections
        ..removeWhere((HomeMenuSection element) =>
            element.type == HomeMenuSectionType.location);

      emit(const HomeIsLoadingState());
      emit(HomeLoadedState(sections));
    }
  }
}
