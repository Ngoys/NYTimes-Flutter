import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nytimes/generated/app_localizations.dart';
import 'package:nytimes/ui/route/route_manager.dart';
import 'package:nytimes/utils/app_navigator_observer.dart';

import 'mock_navigator_observer.dart';

class MockWrapperWidget extends StatelessWidget {
  const MockWrapperWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate>[
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: routeManager,
      navigatorObservers: <NavigatorObserver>[
        MockNavigatorObserver(),
        AppNavigatorObserver()
      ],
      home: child);
}
