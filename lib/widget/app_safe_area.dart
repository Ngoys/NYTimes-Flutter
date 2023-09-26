import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/state/network/network_cubit.dart';
import 'package:nytimes/state/network/network_state.dart';

class AppSafeArea extends StatelessWidget {
  const AppSafeArea({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
        builder: (BuildContext context, NetworkState state) {
      return SafeArea(bottom: state is NetworkConnectedState, child: child);
    });
  }
}
