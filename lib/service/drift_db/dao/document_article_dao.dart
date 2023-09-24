import 'package:drift/drift.dart';
import 'package:nytimes/service/drift_db/data_model/document_article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';
import 'package:nytimes/service/drift_db/entity/document_article_entity.dart';
import 'package:nytimes/service/drift_db/mapper/document_article_mapper.dart';

part 'document_article_dao.g.dart';

@DriftAccessor(tables: <Type>[DocumentArticleEntity])
class DocumentArticleDao extends DatabaseAccessor<DriftDB>
    with _$DocumentArticleDaoMixin {
  DocumentArticleDao(super.db);

  Future<DocumentArticleDataModel> createOrUpdate(
      DocumentArticleDataModel model) async {
    final DocumentArticle user =
        await into(documentArticleEntity).insertReturning(
      model.mapToCompanion(),
      mode: InsertMode.insertOrReplace,
    );

    return user.mapToModel();
  }

  Future<List<DocumentArticleDataModel>> fetchDocumentArticles(
      String keyword) async {
    final List<DocumentArticle> documentArticles =
        await (select(documentArticleEntity)
              ..where(($DocumentArticleEntityTable t) =>
                  t.abstract.contains(keyword)))
            .get();

    final List<DocumentArticleDataModel> documentArticleDataModels =
        documentArticles.map((DocumentArticle documentArticle) {
      return documentArticle.mapToModel();
    }).toList();

    return documentArticleDataModels;
  }
}
