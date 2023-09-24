import 'package:drift/drift.dart';
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';
import 'package:nytimes/service/drift_db/entity/article_entity.dart';
import 'package:nytimes/service/drift_db/mapper/article_mapper.dart';

part 'article_dao.g.dart';

@DriftAccessor(tables: <Type>[ArticleEntity])
class ArticleDao extends DatabaseAccessor<DriftDB> with _$ArticleDaoMixin {
  ArticleDao(super.db);

  Future<ArticleDataModel> createOrUpdate(
    ArticleDataModel model,
    ArticleListingContentType articleListingContentType,
  ) async {
    final Article article = await into(articleEntity).insertReturning(
      model.mapToCompanion(
          articleListingContentType: articleListingContentType),
      mode: InsertMode.insertOrReplace,
    );

    return article.mapToModel();
  }

  Future<List<ArticleDataModel>> fetchArticles(
    ArticleListingContentType articleListingContentType,
  ) async {
    final List<Article> articles = await (select(articleEntity)
          ..where(($ArticleEntityTable t) => t.articleListingContentType
              .equals(articleListingContentType.toString())))
        .get();

    final List<ArticleDataModel> articleDataModels =
        articles.map((Article article) {
      return article.mapToModel();
    }).toList();

    return articleDataModels;
  }
}
