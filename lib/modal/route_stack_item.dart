import 'package:flutter/material.dart';

class RouteStackItem {
  const RouteStackItem({
    required this.name,
    required this.args,
  });

  factory RouteStackItem.fromRoute(Route<dynamic> route) =>
      RouteStackItem(name: route.settings.name, args: route.settings.arguments);
  final String? name;
  final Object? args;
}
