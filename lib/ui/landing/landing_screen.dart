import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/state/network/network_cubit.dart';
import 'package:nytimes/state/network/network_state.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('New York Times'),
        ),
        body: BlocBuilder<NetworkCubit, NetworkState>(
            builder: (BuildContext context, NetworkState state) {
          if (state is NetworkConnectedState) {
            return const Center(child: Text('Connected'));
          } else {
            return const Center(child: Text('No connect'));
          }
        }));
  }
}
