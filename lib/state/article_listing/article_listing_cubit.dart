import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/service/article_store.dart';
import 'package:nytimes/state/article_listing/article_listing_state.dart';

class ArticleListingCubit extends Cubit<ArticleListingState> {
  ArticleListingCubit({required ArticleStore articleStore})
      : _articleStore = articleStore,
        super(const ArticleListingInitialState());

  final ArticleStore _articleStore;

  Future<void> fetchArticleListings(
      ArticleListingContentType articleListingContentType) async {
    final Either<FailureResponse, List<Article>> result =
        await _articleStore.fetchArticles(articleListingContentType);
    result.fold<void>(
      (FailureResponse failureResponse) {
        emit(const ArticleListingErrorState());
      },
      (List<Article> articles) {
        emit(ArticleListingLoadedState(articles));
      },
    );
  }
}
