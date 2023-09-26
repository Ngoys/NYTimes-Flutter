import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nytimes/modal/document_article.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/service/article_store.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/data_model/document_article_data_model.dart';
import 'package:nytimes/service/drift_db/mapper/document_article_mapper.dart';
import 'package:nytimes/service/drift_db_store.dart';
import 'package:nytimes/state/article_listing/article_listing_cubit.dart';
import 'package:nytimes/state/article_listing/article_listing_state.dart';
import 'package:nytimes/state/search/search_cubit.dart';
import 'package:nytimes/state/search/search_state.dart';

import '../../mocks.dart';
import 'search_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  ArticleStore,
  DriftDBStore,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockArticleStore articleStore;
  late MockDriftDBStore driftDBStore;

  setUp(() {
    articleStore = MockArticleStore();
    driftDBStore = MockDriftDBStore();

    GetIt.instance.registerSingleton(articleStore);
    GetIt.instance.registerSingleton(driftDBStore);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  test(
    'cubit.keyword should return correctly when cubit.updateKeyword',
    () {
      final SearchCubit cubit =
          SearchCubit(articleStore: articleStore, driftDBStore: driftDBStore);

      expect(cubit.keyword, '');

      expectLater(
        cubit.stream,
        emitsInOrder(<SearchState>[]),
      ).timeout(const Duration(seconds: 1));

      cubit.updateKeyword('hello');

      expect(cubit.keyword, 'hello');
    },
  );

  test(
    'should emit SearchLoadingState on startSearchDocumentArticle without Drift stored articles',
    () {
      const String keyword = 'hello';

      when(articleStore.searchDocumentArticles(keyword)).thenAnswer((_) async =>
          Right<FailureResponse, List<DocumentArticle>>(mockDocumentArticles1));
      when(driftDBStore.fetchDocumentArticles(keyword))
          .thenAnswer((_) async => <DocumentArticleDataModel>[]);
      when(driftDBStore.createOrUpdateDocumentArticle(any))
          .thenAnswer((_) => Future<void>.value(null));

      final SearchCubit cubit =
          SearchCubit(articleStore: articleStore, driftDBStore: driftDBStore)
            ..updateKeyword(keyword);

      expectLater(
        cubit.stream,
        emitsInOrder(<SearchState>[
          const SearchLoadingState(),
          SearchLoadedState(mockDocumentArticles1),
        ]),
      ).timeout(const Duration(seconds: 2));

      cubit.startSearchDocumentArticle();
    },
  );

  test(
    'should emit SearchLoadedState twice on startSearchDocumentArticle with Drift stored articles',
    () {
      const String keyword = 'hello';

      when(articleStore.searchDocumentArticles(keyword)).thenAnswer((_) async =>
          Right<FailureResponse, List<DocumentArticle>>(mockDocumentArticles1));
      when(driftDBStore.fetchDocumentArticles(keyword)).thenAnswer((_) async =>
          mockDocumentArticles1
              .map((DocumentArticle documentArticle) =>
                  documentArticle.mapToDataModel())
              .toList());
      when(driftDBStore.createOrUpdateDocumentArticle(any))
          .thenAnswer((_) => Future<void>.value(null));

      final SearchCubit cubit =
          SearchCubit(articleStore: articleStore, driftDBStore: driftDBStore)
            ..updateKeyword(keyword);

      expectLater(
        cubit.stream,
        emitsInOrder(<SearchState>[
          SearchLoadedState(mockDocumentArticles1),
          SearchLoadedState(mockDocumentArticles1 + mockDocumentArticles1),
        ]),
      ).timeout(const Duration(seconds: 2));

      cubit.startSearchDocumentArticle();
    },
  );

  test(
    'should emit SearchErrorState on startSearchDocumentArticle error without Drift stored articles',
    () {
      const String keyword = 'hello';

      when(articleStore.searchDocumentArticles(keyword)).thenAnswer((_) async =>
          Left<FailureResponse, List<DocumentArticle>>(mockFailureResponse));
      when(driftDBStore.fetchDocumentArticles(keyword))
          .thenAnswer((_) async => <DocumentArticleDataModel>[]);
      when(driftDBStore.createOrUpdateDocumentArticle(any))
          .thenAnswer((_) => Future<void>.value(null));

      final SearchCubit cubit =
          SearchCubit(articleStore: articleStore, driftDBStore: driftDBStore)
            ..updateKeyword(keyword);

      expectLater(
        cubit.stream,
        emitsInOrder(<SearchState>[
          const SearchLoadingState(),
          SearchErrorState(mockFailureResponse),
        ]),
      ).timeout(const Duration(seconds: 2));

      cubit.startSearchDocumentArticle();
    },
  );

  test(
    'should emit SearchErrorState on startSearchDocumentArticle error with Drift stored articles',
    () {
      const String keyword = 'hello';

      when(articleStore.searchDocumentArticles(keyword)).thenAnswer((_) async =>
          Left<FailureResponse, List<DocumentArticle>>(mockFailureResponse));
      when(driftDBStore.fetchDocumentArticles(keyword)).thenAnswer((_) async =>
          mockDocumentArticles1
              .map((DocumentArticle documentArticle) =>
                  documentArticle.mapToDataModel())
              .toList());
      when(driftDBStore.createOrUpdateDocumentArticle(any))
          .thenAnswer((_) => Future<void>.value(null));

      final SearchCubit cubit =
          SearchCubit(articleStore: articleStore, driftDBStore: driftDBStore)
            ..updateKeyword(keyword);

      expectLater(
        cubit.stream,
        emitsInOrder(<SearchState>[
          SearchLoadedState(mockDocumentArticles1),
          SearchErrorState(mockFailureResponse),
        ]),
      ).timeout(const Duration(seconds: 2));

      cubit.startSearchDocumentArticle();
    },
  );

  test(
    'should emit SearchLoadingNextPageState on pagination without Drift stored articles',
    () {
      const String keyword = 'hello';

      when(articleStore.searchDocumentArticles(keyword, pageNumber: 1))
          .thenAnswer((_) async =>
              Right<FailureResponse, List<DocumentArticle>>(
                  mockDocumentArticles1));
      when(articleStore.searchDocumentArticles(keyword, pageNumber: 2))
          .thenAnswer((_) async =>
              Right<FailureResponse, List<DocumentArticle>>(
                  mockDocumentArticles2));
      when(articleStore.searchDocumentArticles(keyword, pageNumber: 3))
          .thenAnswer((_) async =>
              Right<FailureResponse, List<DocumentArticle>>(
                  <DocumentArticle>[mockDocumentArticles1[1]]));
      when(articleStore.searchDocumentArticles(keyword, pageNumber: 4))
          .thenAnswer((_) async =>
              Right<FailureResponse, List<DocumentArticle>>(
                  <DocumentArticle>[mockDocumentArticles2[2]]));
      when(driftDBStore.fetchDocumentArticles(keyword))
          .thenAnswer((_) async => <DocumentArticleDataModel>[]);
      when(driftDBStore.createOrUpdateDocumentArticle(any))
          .thenAnswer((_) => Future<void>.value(null));

      final SearchCubit cubit =
          SearchCubit(articleStore: articleStore, driftDBStore: driftDBStore)
            ..updateKeyword(keyword);

      expectLater(
        cubit.stream,
        emitsInOrder(<SearchState>[
          const SearchLoadingState(),
          SearchLoadedState(mockDocumentArticles1),
          const SearchLoadingNextPageState(),
          SearchLoadedState(mockDocumentArticles1 + mockDocumentArticles2),
          const SearchLoadingNextPageState(),
          SearchLoadedState(mockDocumentArticles1 +
              mockDocumentArticles2 +
              <DocumentArticle>[mockDocumentArticles1[1]]),
          const SearchLoadingNextPageState(),
          SearchLoadedState(mockDocumentArticles1 +
              mockDocumentArticles2 +
              <DocumentArticle>[mockDocumentArticles1[1]] +
              <DocumentArticle>[mockDocumentArticles2[2]]),
        ]),
      );

      cubit.startSearchDocumentArticle().then((_) {
        cubit.loadMoreDocumentArticle().then((_) {
          cubit.loadMoreDocumentArticle().then((_) {
            cubit.loadMoreDocumentArticle();
          });
        });
      });
    },
  );
}
