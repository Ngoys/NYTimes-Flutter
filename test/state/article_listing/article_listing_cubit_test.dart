import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/service/article_store.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/mapper/article_mapper.dart';
import 'package:nytimes/service/drift_db_store.dart';
import 'package:nytimes/state/article_listing/article_listing_cubit.dart';
import 'package:nytimes/state/article_listing/article_listing_state.dart';

import '../../mocks.dart';
import 'article_listing_cubit_test.mocks.dart';

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

  group('', () {
    final List<ArticleListingContentType> articleListingContentTypes = [
      ArticleListingContentType.mostEmailed,
      ArticleListingContentType.mostShared,
      ArticleListingContentType.mostViewed,
    ];

    for (final ArticleListingContentType articleListingContentType
        in articleListingContentTypes) {
      test(
          'for $articleListingContentType, should emit ArticleListingLoadedState on fetchArticles with no Drift stored articles',
          () {
        when(articleStore.fetchArticles(articleListingContentType)).thenAnswer(
            (_) async => Right<FailureResponse, List<Article>>(mockArticles));
        when(driftDBStore.fetchArticles(articleListingContentType))
            .thenAnswer((_) async => <ArticleDataModel>[]);
        when(driftDBStore.createOrUpdateArticle(any, articleListingContentType))
            .thenAnswer((_) => Future<void>.value(null));

        final ArticleListingCubit cubit = ArticleListingCubit(
            articleStore: articleStore, driftDBStore: driftDBStore)
          ..fetchArticleListings(articleListingContentType);

        expectLater(
          cubit.stream,
          emitsInOrder(<ArticleListingState>[
            const ArticleListingLoadingState(),
            ArticleListingLoadedState(mockArticles),
          ]),
        ).timeout(const Duration(seconds: 2));
      });

      //   test(
      //       'for $articleListingContentType, should emit ArticleListingLoadedState twice on fetchArticles with Drift stored articles',
      //       () {
      //     when(articleStore.fetchArticles(articleListingContentType)).thenAnswer(
      //         (_) async => Right<FailureResponse, List<Article>>(mockArticles));
      //     when(driftDBStore.fetchArticles(articleListingContentType)).thenAnswer(
      //         (_) async => mockArticles
      //             .map((Article article) => article.mapToDataModel())
      //             .toList());
      //     when(driftDBStore.createOrUpdateArticle(any, articleListingContentType))
      //         .thenAnswer((_) => Future<void>.value(null));

      //     final ArticleListingCubit cubit = ArticleListingCubit(
      //         articleStore: articleStore, driftDBStore: driftDBStore)
      //       ..fetchArticleListings(articleListingContentType);

      //     expectLater(
      //       cubit.stream,
      //       emitsInOrder(<ArticleListingState>[
      //         ArticleListingLoadedState(mockArticles),
      //         ArticleListingLoadedState(mockArticles),
      //       ]),
      //     ).timeout(const Duration(seconds: 2));
      //   });
    }
  });
}
