import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/state/network/network_cubit.dart';
import 'package:nytimes/state/network/network_state.dart';
import 'package:nytimes/widget/network_indicator_widget.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          flex: 29,
          child: child,
        ),
        BlocBuilder<NetworkCubit, NetworkState>(
          builder: (BuildContext context, NetworkState state) {
            if (state is NetworkConnectedState) {
              return Flexible(
                flex: 0,
                child: Container(),
              );
            } else {
              return NetworkIndicatorWidget(state);
            }
          },
        ),
      ],
    );
  }
}
