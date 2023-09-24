import 'package:drift/drift.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';

extension ArticleEntityMapper on Article {
  ArticleDataModel mapToDataModel() => ArticleDataModel(
        id: id,
        title: title,
        publishedDate: publishedDate,
      );
}

extension ArticleDataModelMapper on ArticleDataModel {
  ArticleEntityCompanion mapToCompanion() => ArticleEntityCompanion(
        id: Value<String>(id),
        title: Value<String?>(title),
        publishedDate: Value<DateTime?>(publishedDate),
      );

  Article mapToModel() => Article(
        id: id,
        title: title,
        publishedDate: publishedDate,
      );
}
