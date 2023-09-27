import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nytimes/state/home/home_cubit.dart';
import 'package:nytimes/state/location/location_cubit.dart';
import 'package:nytimes/state/location/location_state.dart';
import 'package:nytimes/state/network/network_cubit.dart';
import 'package:nytimes/state/network/network_state.dart';
import 'package:nytimes/ui/home/home_screen.dart';
import 'package:nytimes/utils/constants.dart';
import 'package:nytimes/widget/app_overlay.dart';

import '../../mock_wrapper_widget.dart';
import '../../mocks.dart';
import 'home_screen_test.mocks.dart';

@GenerateNiceMocks(<MockSpec>[
  MockSpec<NetworkCubit>(),
  MockSpec<LocationCubit>(),
  MockSpec<HomeCubit>(),
])
void main() {
  late MockNetworkCubit networkCubit;
  late MockHomeCubit homeCubit;
  late MockLocationCubit locationCubit;

  setUp(() {
    networkCubit = MockNetworkCubit();
    homeCubit = MockHomeCubit();
    locationCubit = MockLocationCubit();

    when(networkCubit.state).thenReturn(const NetworkConnectedState());
  });

  testWidgets('should navigate to HomeScreen', (WidgetTester tester) async {
    await tester.runAsync(() async {
      reset(networkCubit);

      when(locationCubit.stream).thenAnswer((_) =>
          Stream<LocationState>.fromIterable(
              [LocationLoadedState(mockPosition)]));

      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<NetworkCubit>(
            create: (BuildContext context) => networkCubit,
          ),
        ],
        child: MockWrapperWidget(
          child: AppOverlay(blocProviderList: [
            BlocProvider<HomeCubit>(
              create: (_) => homeCubit,
            ),
            BlocProvider<LocationCubit>(
              create: (_) => locationCubit,
            )
          ], child: const HomeScreen()),
        ),
      ));

      expect(find.byKey(homeScreenKey), findsOneWidget);
    });
  });
}
