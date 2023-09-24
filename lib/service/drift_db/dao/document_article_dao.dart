import 'package:drift/drift.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';
import 'package:nytimes/service/drift_db/entity/document_article_entity.dart';

part 'document_article_dao.g.dart';

@DriftAccessor(tables: <Type>[DocumentArticleEntity])
class DocumentArticleDao extends DatabaseAccessor<DriftDB>
    with _$DocumentArticleDaoMixin {
  DocumentArticleDao(super.db);
}
