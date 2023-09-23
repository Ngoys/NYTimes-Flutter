import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nytimes/modal/api_response.dart';
import 'package:nytimes/modal/api_result.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/modal/document_article.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/modal/search_response.dart';
import 'package:nytimes/service/api/api_client.dart';
import 'package:nytimes/service/api/api_error_handler.dart';

@lazySingleton
class ArticleStore {
  ArticleStore({required APIClient apiClient}) : _apiClient = apiClient;

  final APIClient _apiClient;

  Future<Either<FailureResponse, List<DocumentArticle>>> searchDocumentArticles(
      String keyword,
      {int pageNumber = 1}) async {
    const String endPoint = 'search/v2/articlesearch.json';

    try {
      final Response<dynamic> response =
          await _apiClient.appDio.mainDio.get<dynamic>(
        endPoint,
        queryParameters: <String, dynamic>{
          'q': keyword,
          'page': pageNumber.toString()
        },
      );
      if (response.statusCode != 200) {
        return Left<FailureResponse, List<DocumentArticle>>(FailureResponse(
            code: response.statusCode.toString(),
            error: response.statusCode.toString()));
      } else {
        final NYTimesAPIResponse<List<DocumentArticle>> apiResult =
            NYTimesAPIResponse<List<DocumentArticle>>.fromJson(response.data,
                (dynamic json) => (SearchResponse.fromJson(json).docs));
        return Right<FailureResponse, List<DocumentArticle>>(
            apiResult.response);
      }
    } on DioException catch (ex) {
      developer.log(ex.message ?? '');
      return Left<FailureResponse, List<DocumentArticle>>(ex.processError());
    }
  }

  Future<Either<FailureResponse, List<Article>>> fetchArticles(
      ArticleListingContentType articleListingContentType) async {
    String endPoint = '';

    switch (articleListingContentType) {
      case ArticleListingContentType.mostEmailed:
        endPoint = 'mostpopular/v2/emailed/1.json';
      case ArticleListingContentType.mostShared:
        endPoint = 'mostpopular/v2/shared/1/facebook.json';
      case ArticleListingContentType.mostViewed:
        endPoint = 'mostpopular/v2/viewed/7.json';
    }

    try {
      final Response<dynamic> response =
          await _apiClient.appDio.mainDio.get<dynamic>(endPoint);
      if (response.statusCode != 200) {
        return Left<FailureResponse, List<Article>>(FailureResponse(
            code: response.statusCode.toString(),
            error: response.statusCode.toString()));
      } else {
        final NYTimesAPIResult<List<Article>> apiResult =
            NYTimesAPIResult<List<Article>>.fromJson(
          response.data,
          (dynamic json) => (json as List<dynamic>)
              .map((dynamic item) => Article.fromJson(item))
              .toList(),
        );
        return Right<FailureResponse, List<Article>>(apiResult.results);
      }
    } on DioException catch (ex) {
      developer.log(ex.message ?? '');
      return Left<FailureResponse, List<Article>>(ex.processError());
    }
  }
}
