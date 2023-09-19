import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/config/app_config.dart';
import 'package:nytimes/config/app_config_provider.dart';
import 'package:nytimes/config/app_injector.dart';
import 'package:nytimes/config/base_config.dart';
import 'package:nytimes/core_app.dart';
import 'package:nytimes/utils/cubit_observer.dart';

void main({BaseConfig? baseConfig}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final BaseConfig config = baseConfig ?? AppConfig();
  await configureDependencies(config);

  Bloc.observer = CubitObserver();

  runApp(AppConfigProvider(appConfig: config, child: CoreApp(config: config)));
}
