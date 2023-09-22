import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/modal/home_menu.dart';
import 'package:nytimes/modal/home_menu_section.dart';
import 'package:nytimes/state/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const UnknownHomeState()) {
    const HomeMenuSection searchSection = HomeMenuSection(
        type: HomeMenuSectionType.search, menus: [HomeMenu.searchArticle]);
    const HomeMenuSection popularSection = HomeMenuSection(
        type: HomeMenuSectionType.popular,
        menus: [
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

  void asd() {
    const HomeMenuSection searchSection = HomeMenuSection(
        type: HomeMenuSectionType.search, menus: [HomeMenu.searchArticle]);
    const HomeMenuSection popularSection = HomeMenuSection(
        type: HomeMenuSectionType.popular,
        menus: [
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
}
