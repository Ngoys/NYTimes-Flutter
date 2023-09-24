import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/modal/document_article.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/service/article_store.dart';
import 'package:nytimes/service/drift_db_store.dart';
import 'package:nytimes/state/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
      {required ArticleStore articleStore, required DriftDBStore driftDBStore})
      : _articleStore = articleStore,
        _driftDBStore = driftDBStore,
        super(const SearchInitialState());

  final ArticleStore _articleStore;
  final DriftDBStore _driftDBStore;

  String _keyword = '';
  int _pageNumber = 1;
  List<DocumentArticle> _documentArticles = <DocumentArticle>[];

  Future<void> updateKeyword(String keyword) async {
    _keyword = keyword;
  }

  List<DocumentArticle> getDocumentArticles() {
    return _documentArticles;
  }

  Future<void> startSearchDocumentArticle() async {
    _pageNumber = 1;
    _documentArticles = <DocumentArticle>[];

    emit(const SearchLoadingState());
    await _searchDocumentArticle();
  }

  Future<void> loadMoreDocumentArticle() async {
    if (state is SearchLoadedState) {
      _pageNumber++;
      emit(const SearchLoadingNextPageState());
      await _searchDocumentArticle();
    }
  }

  Future<void> _searchDocumentArticle() async {
    final Either<FailureResponse, List<DocumentArticle>> result =
        await _articleStore.searchDocumentArticles(
      _keyword,
      pageNumber: _pageNumber,
    );
    result.fold<void>(
      (FailureResponse failureResponse) {
        emit(SearchErrorState(failureResponse));
        _pageNumber--;
      },
      (List<DocumentArticle> newDocumentArticles) {
        _documentArticles = _documentArticles + newDocumentArticles;
        emit(SearchLoadedState(_documentArticles));
      },
    );
  }
}
