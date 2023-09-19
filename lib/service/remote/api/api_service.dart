import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:nytimes/utils/constants.dart';

class BaseDio {
  BaseDio({required this.mainDio});

  final Dio mainDio;
}

Dio get _getMainDio {
  final Dio dio = Dio()
    ..options = BaseOptions(
      headers: <String, String>{'cache-control': cacheControl},
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      connectTimeout: const Duration(milliseconds: 30000),
      baseUrl: baseUrl,
    );

  return dio;
}
