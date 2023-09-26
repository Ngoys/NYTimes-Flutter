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
}
