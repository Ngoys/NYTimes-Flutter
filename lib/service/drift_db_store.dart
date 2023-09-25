import 'package:injectable/injectable.dart';
import 'package:nytimes/modal/article.dart' as modal;
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/modal/document_article.dart' as modal;
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/data_model/document_article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';
import 'package:nytimes/service/drift_db/mapper/article_mapper.dart';
import 'package:nytimes/service/drift_db/mapper/document_article_mapper.dart';

@lazySingleton
class DriftDBStore {
  DriftDBStore({
    required this.db,
  });

  final DriftDB db;

  Future<void> createOrUpdateArticle(
    modal.Article article,
    ArticleListingContentType articleListingContentType,
  ) async =>
      db.articleDao
          .createOrUpdate(article.mapToDataModel(), articleListingContentType);

  Future<List<ArticleDataModel>> fetchArticles(
    ArticleListingContentType articleListingContentType,
  ) async =>
      db.articleDao.fetchArticles(articleListingContentType);

  Future<void> createOrUpdateDocumentArticle(
          modal.DocumentArticle documentArticle) async =>
      db.documentArticleDao.createOrUpdate(documentArticle.mapToDataModel());

  Future<List<DocumentArticleDataModel>> fetchDocumentArticles(
    String keyword,
  ) async =>
      db.documentArticleDao.fetchDocumentArticles(keyword);
}
