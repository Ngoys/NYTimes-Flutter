import 'package:drift/drift.dart';
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
  ) async {
    final Article user = await into(articleEntity).insertReturning(
      model.mapToCompanion(),
      mode: InsertMode.insertOrReplace,
    );

    return user.mapToDataModel();
  }
}
