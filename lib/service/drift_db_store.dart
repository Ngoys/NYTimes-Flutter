import 'package:injectable/injectable.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';

@lazySingleton
class DriftDBStore {
  DriftDBStore({
    required this.db,
  });

  final DriftDB db;

  Future<ArticleDataModel> createOrUpdateArticle(
    ArticleDataModel model,
    ArticleListingContentType articleListingContentType,
  ) async =>
      db.articleDao.createOrUpdate(model, articleListingContentType);

  Future<List<ArticleDataModel>> fetchArticles(
    ArticleListingContentType articleListingContentType,
  ) async =>
      db.articleDao.fetchArticles(articleListingContentType);
}
