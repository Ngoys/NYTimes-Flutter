import 'package:dio/dio.dart';
import 'package:nytimes/utils/constants.dart';

class BaseDio {
  BaseDio({required String baseUrl}) {
    mainDio = Dio()
      ..options = BaseOptions(
        headers: <String, String>{'cache-control': cacheControl},
        sendTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        connectTimeout: const Duration(milliseconds: 30000),
        baseUrl: baseUrl,
      );
  }

  late final Dio mainDio;
}
