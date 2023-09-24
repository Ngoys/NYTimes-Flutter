import 'package:drift/drift.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';
import 'package:nytimes/service/drift_db/entity/article_entity.dart';

part 'article_dao.g.dart';

@DriftAccessor(tables: <Type>[ArticleEntity])
class ArticleDao extends DatabaseAccessor<DriftDB> with _$ArticleDaoMixin {
  ArticleDao(super.db);

  // Future<ArticleDataModel> createOrUpdate(
  //   ArticleDataModel model,
  // ) async {
  //   final Article? existingUser = await (select(articleEntity)
  //         ..where(($ArticleEntityTable t) =>
  //             t.preferredUsername.equals(model.preferredUsername)))
  //       .getSingleOrNull();

  //   final Article user = await into(articleEntity).insertReturning(
  //     model.mapToCompanion(
  //         encryptedAuthKey:
  //             await encryptAuthKey(authKey, model.preferredUsername),
  //         isBiometricLoginEnabledForUser:
  //             existingUser?.isBiometricLoginEnabled ?? false),
  //     mode: InsertMode.insertOrReplace,
  //   );

  //   return user.mapToModel();
  // }
}
