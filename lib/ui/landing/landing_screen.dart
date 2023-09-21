import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nytimes/ui/home/home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  static const String route = '/';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        Navigator.pushReplacementNamed(context, HomeScreen.route);
        return const Text('Landing');
      }),
    );
  }
}
