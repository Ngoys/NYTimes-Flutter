import 'package:flutter/material.dart';
import 'package:nytimes/modal/route_stack_item.dart';

class AppNavigatorObserver extends NavigatorObserver {
  static final List<RouteStackItem> navigationStack = <RouteStackItem>[];

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      navigationStack.removeLast();
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    navigationStack.add(RouteStackItem.fromRoute(route));
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      navigationStack.removeLast();
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) {
      navigationStack.removeLast();
    }
    if (newRoute != null) {
      navigationStack.add(RouteStackItem.fromRoute(newRoute));
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
