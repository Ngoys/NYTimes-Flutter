import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/service/article_store.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/mapper/article_mapper.dart';
import 'package:nytimes/service/drift_db_store.dart';
import 'package:nytimes/state/article_listing/article_listing_state.dart';

class ArticleListingCubit extends Cubit<ArticleListingState> {
  ArticleListingCubit(
      {required ArticleStore articleStore, required DriftDBStore driftDBStore})
      : _articleStore = articleStore,
        _driftDBStore = driftDBStore,
        super(const ArticleListingInitialState());

  final ArticleStore _articleStore;
  final DriftDBStore _driftDBStore;

  Future<void> fetchArticleListings(
      ArticleListingContentType articleListingContentType) async {
    final List<ArticleDataModel> articleDataModals =
        await _driftDBStore.fetchArticles(articleListingContentType);

    if (articleDataModals.isEmpty) {
      emit(const ArticleListingLoadingState());
    } else {
      final List<Article> articles = articleDataModals
          .map((ArticleDataModel article) => article.mapToModel())
          .toList();

      emit(ArticleListingLoadedState(articles));
    }

    final Either<FailureResponse, List<Article>> result =
        await _articleStore.fetchArticles(articleListingContentType);
    result.fold<void>(
      (FailureResponse failureResponse) {
        if (articleDataModals.isEmpty) {
          emit(const ArticleListingErrorState());
        }
      },
      (List<Article> articles) {
        for (final Article article in articles) {
          _driftDBStore.createOrUpdateArticle(
              article.mapToDataModel(), articleListingContentType);
        }

        emit(ArticleListingLoadedState(articles));
      },
    );
  }
}
