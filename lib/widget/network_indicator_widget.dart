import 'package:flutter/material.dart';
import 'package:nytimes/config/stylesheet/app_color.dart';
import 'package:nytimes/config/stylesheet/app_font.dart';
import 'package:nytimes/state/network/network_state.dart';
import 'package:nytimes/utils/context_extension.dart';

class NetworkIndicatorWidget extends StatelessWidget {
  const NetworkIndicatorWidget(this.state, {super.key});

  final NetworkState state;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Material(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            color: state is NetworkConnectedState
                ? Colors.lightGreenAccent
                : Colors.redAccent,
            child: SafeArea(
              top: false,
              child: Center(
                child: Text(
                  state is NetworkConnectedState
                      ? context.localization.labelOnlineMode
                      : context.localization.labelOfflineMode,
                  style: AppFont.bodySmall.copyWith(
                      color: state is NetworkConnectedState
                          ? AppColor.blackCoral
                          : Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
