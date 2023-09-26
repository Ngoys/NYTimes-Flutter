import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:nytimes/modal/home_menu_section.dart';
import 'package:nytimes/state/home/home_cubit.dart';
import 'package:nytimes/state/home/home_state.dart';

import '../../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  tearDown(() {
    GetIt.instance.reset();
  });

  test(
    'should emit UnknownHomeState to HomeLoadedState with the default HomeMenuSection',
    () {
      final HomeCubit cubit = HomeCubit();
      expect(
          cubit.state,
          HomeLoadedState(
              <HomeMenuSection>[mockSearchSection, mockPopularSection]));
    },
  );

  test(
    'should emit HomeMenuSection with locationSection upon cubit.addLocationSection',
    () {
      final HomeCubit cubit = HomeCubit();

      expectLater(
        cubit.stream,
        emitsInOrder(<HomeState>[
          const HomeIsLoadingState(),
          HomeLoadedState(<HomeMenuSection>[
            mockSearchSection,
            mockPopularSection,
            mockLocationSection
          ]),
        ]),
      ).timeout(const Duration(seconds: 2));

      cubit.addLocationSection(mockPosition);
    },
  );
  test(
    'should emit HomeMenuSection without locationSection upon cubit.removeLocationSection',
    () {
      final HomeCubit cubit = HomeCubit()..addLocationSection(mockPosition);

      expect(
          cubit.state,
          HomeLoadedState(<HomeMenuSection>[
            mockSearchSection,
            mockPopularSection,
            mockLocationSection
          ]));

      expectLater(
        cubit.stream,
        emitsInOrder(<HomeState>[
          const HomeIsLoadingState(),
          HomeLoadedState(<HomeMenuSection>[
            mockSearchSection,
            mockPopularSection,
          ]),
        ]),
      ).timeout(const Duration(seconds: 2));

      cubit.removeLocationSection();
    },
  );
}
