import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/utils/constants.dart';

extension ApiErrorHandler on DioException {
  FailureResponse processError() {
    if (response != null) {
      String localizedMessage = '';
      if (response?.data == null || response?.data.toString() == '[]') {
        return FailureResponse(
          code: response?.statusCode,
          error: localizedMessage,
          errorDescription: response?.statusMessage ?? '',
        );
      }
      try {
        final dynamic errorResponse =
            json.decode(response?.data.toString() ?? '');
        if (response?.data is! Map<String, dynamic>) {
          localizedMessage = response?.data;
        } else if (errorResponse.containsKey('localizedMessage')) {
          localizedMessage = errorResponse['localizedMessage'] ?? '';
        } else if (errorResponse.containsKey('error')) {
          localizedMessage = errorResponse['error'] ?? '';
        } else {
          localizedMessage = '';
        }
      } on Exception {
        localizedMessage = '';
      }

      return FailureResponse(
        code: (response?.statusCode),
        error: localizedMessage,
        errorDescription: response?.statusMessage ?? '',
      );
    } else if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return FailureResponse(
        code: 500,
        error: connectTimeOut.toString(),
        errorDescription: message,
      );
    } else if (type == DioExceptionType.cancel) {
      return FailureResponse(
        code: 500,
        error: cancelledRequest.toString(),
        errorDescription: message,
      );
    } else if (type == DioExceptionType.unknown) {
      if (error != null && error is SocketException) {
        final SocketException exception = error! as SocketException;
        final OSError? osError = exception.osError;
        int errorCode = notFound;
        if (osError != null) errorCode = osError.errorCode;

        return FailureResponse(
          code: 500,
          error: errorCode.toString(),
          errorDescription: message,
        );
      }
    }
    return FailureResponse(code: null, error: '');
  }
}
