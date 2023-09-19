import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nytimes/config/app_injector.config.dart';
import 'package:nytimes/config/base_config.dart';
import 'package:nytimes/service/remote/api/base_dio.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(initializerName: 'init')
Future<void> configureDependencies(BaseConfig config) async {
  getIt
    ..init()
    ..registerSingleton<BaseDio>(
        BaseDio(baseUrl: config.endpoints()['baseUrl']!));
}
