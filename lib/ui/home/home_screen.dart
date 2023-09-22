import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/modal/home_menu.dart';
import 'package:nytimes/modal/home_menu_section.dart';
import 'package:nytimes/state/home/home_cubit.dart';
import 'package:nytimes/state/home/home_state.dart';
import 'package:nytimes/state/location/location_cubit.dart';
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
    _homeCubit.asd();

    _locationCubit = BlocProvider.of<LocationCubit>(context);
    _locationCubit
      ..subscribeToLocationServiceChange()
      ..subscribeToLocationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.titleHomeScreen),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is HomeLoadedState) {
            return ListView(
              children: <Widget>[
                for (final HomeMenuSection section in state.sections)
                  Column(
                    children: <Widget>[
                      Text(section.type.name),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: section.menus.length,
                        itemBuilder: (BuildContext context, int index) {
                          final HomeMenu menu = section.menus[index];
                          return Text(menu.name);
                        },
                      ),
                    ],
                  )
              ],
            );
          } else {
            return const Text('Empty');
          }
        },
      ),
    );
  }
}
