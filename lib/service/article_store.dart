import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/service/remote/api/api_error_handler.dart';

@lazySingleton
class UserStore {
  UserStore({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  Future<Either<FailureResponse, Article>>
      getInspectionTypes(String? eTag) async {
    try {
      final Response<dynamic> response = await baseDio.mainDio.get<dynamic>(
        inspectionTypesUrl,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: <String, dynamic>{HttpHeaders.ifNoneMatchHeader: eTag},
        ),
      );
      if (response.statusCode != 200) {
        return Left<FailureResponse, Article>(
            FailureResponse(
                code: response.statusCode.toString(),
                error: response.statusCode.toString()));
      } else {
        return Right<FailureResponse, Article>(
            Article(
          eTag: response.headers.value(HttpHeaders.etagHeader),
          inspectionTypes: jsonEncode(response.data),
        ));
      }Art
    } on DioException catch (ex) {
      developer.log(ex.message ?? '');
      return Left<FailureResponse, Article>(
          ex.processError());
    }
  }
}
