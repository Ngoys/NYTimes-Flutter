import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nytimes/config/stylesheet/app_asset.dart';
import 'package:nytimes/ui/home/home_screen.dart';
import 'package:nytimes/utils/constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  static const String route = '/';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 2200),
        () => Navigator.pushReplacementNamed(context, HomeScreen.route,
                arguments: <String, dynamic>{
                  NAV_SHOULD_PUSH_ANIMATION: false,
                }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              AppAsset.backgroundScreen,
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}
