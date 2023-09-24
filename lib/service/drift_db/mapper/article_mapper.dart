import 'package:drift/drift.dart';
import 'package:nytimes/modal/article.dart' as modal;
import 'package:nytimes/modal/article_listing_content_type.dart';
import 'package:nytimes/service/drift_db/data_model/article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';

extension ArticleModalMapper on modal.Article {
  ArticleDataModel mapToDataModel() => ArticleDataModel(
        id: id,
        title: title,
        publishedDate: publishedDate,
      );
}

extension ArticleDataModelMapper on ArticleDataModel {
  ArticleEntityCompanion mapToCompanion(
          {required ArticleListingContentType articleListingContentType}) =>
      ArticleEntityCompanion(
        id: Value<String>(id),
        title: Value<String?>(title),
        publishedDate: Value<DateTime?>(publishedDate),
        articleListingContentType:
            Value<String>(articleListingContentType.toString()),
      );

  modal.Article mapToModel() => modal.Article(
        id: id,
        title: title,
        publishedDate: publishedDate,
      );
}

extension ArticleMapper on Article {
  ArticleDataModel mapToModel() => ArticleDataModel(
        id: id,
        title: title,
        publishedDate: publishedDate,
      );
}
