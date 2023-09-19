import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nytimes/modal/auth_response.dart';
import 'package:nytimes/service/remote/api/api_service.dart';
import 'package:nytimes/service/user_store.dart';
import 'package:nytimes/utils/constants.dart';

@singleton
class EndpointProvider {
  EndpointProvider(this.baseDio, this.userStore) {
    // Add MainDioInterceptors to the main dio
    final bool dioHasInterceptors = baseDio.mainDio.interceptors
        .any((Interceptor interceptor) => interceptor is MainDioInterceptors);
    if (!dioHasInterceptors) {
      baseDio.mainDio.interceptors
          .add(MainDioInterceptors(baseDio.mainDio, userStore));
    }
  }

  final BaseDio baseDio;
  final UserStore userStore;

  Options authOptions = Options(
    contentType: Headers.formUrlEncodedContentType,
  );
}

class MainDioInterceptors extends InterceptorsWrapper {
  MainDioInterceptors(this.dio, this.authStorageService);

  final UserStore authStorageService;
  final Dio dio;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add auth
    final AuthResponse? auth = await authStorageService.getAuthData();
    options.headers.remove('Authorization');
    if (auth != null) {
      options.headers['Authorization'] = 'Bearer ${auth.accessToken}';
    }

    // Add local
    options.headers[HttpHeaders.acceptLanguageHeader] =
        Platform.localeName.substring(0, 2);

    developer.log(
        name: 'REQUEST: ${options.method}',
        '\nPATH => ${options.path} \nBody => ${options.data} '
        '\nParams => ${options.queryParameters}');

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    developer.log(
        name: 'ERROR: ${err.response?.statusCode}',
        '\nPATH => ${err.requestOptions.path} \nBody => ${err.response}');

    if (err.response?.statusCode == 403) {
      await authStorageService.deleteAuthData();
      return handler.reject(err);
    }

    if (err.response?.statusCode == 401) {
      final RequestOptions options = err.requestOptions;
      if ((options.headers['retry_count'] ?? 0) >= maxRetryCount) {
        // The user is required to login
        await authStorageService.deleteAuthData();
        return handler.reject(err..response?.statusCode = 403);
      }

      // proceed refreshing token, then retry main request
      try {
        await refreshToken();
        final dynamic response = await _retry(options);
        return handler.resolve(response);
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    developer.log(
        name: 'RESPONSE: ${response.statusCode}',
        '\nPATH => ${response.requestOptions.path} \nBody => $response');
    return super.onResponse(response, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions rOptions) async {
    // Increment retry count in the headers
    rOptions.headers['retry_count'] =
        (rOptions.headers['retry_count'] ?? 0) + 1;

    final AuthResponse? auth = await authStorageService.getAuthData();
    rOptions.headers.remove('Authorization');
    if (auth != null) {
      rOptions.headers['Authorization'] = 'Bearer ${auth.accessToken}';
    }

    final Options options = Options(
      method: rOptions.method,
      headers: rOptions.headers,
    );
    return dio.request<dynamic>(
      rOptions.path,
      data: rOptions.data,
      queryParameters: rOptions.queryParameters,
      options: options,
    );
  }

  Future<void> refreshToken() async {
    try {
      final dynamic response = await dio.post<dynamic>(
        'token',
        data: <String, dynamic>{
          'refresh_token':
              (await authStorageService.getAuthData())?.refreshToken,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      final AuthResponse auth =
          AuthResponse.fromJson(json.decode(response.toString()));
      await authStorageService.saveAuthData(auth);
    } on DioException {
      await authStorageService.deleteAuthData();
    }
  }
}
