import 'package:drift/drift.dart';
import 'package:nytimes/modal/document_article.dart' as modal;
import 'package:nytimes/service/drift_db/data_model/document_article_data_model.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';

extension DocumentArticleModalMapper on modal.DocumentArticle {
  DocumentArticleDataModel mapToDataModel() => DocumentArticleDataModel(
        id: id,
        abstractText: abstractText,
        publishedDate: publishedDate,
      );
}

extension DocumentArticleDataModelMapper on DocumentArticleDataModel {
  DocumentArticleEntityCompanion mapToCompanion() =>
      DocumentArticleEntityCompanion(
          id: Value<String>(id),
          abstract: Value<String?>(abstractText),
          publishedDate: Value<DateTime?>(publishedDate));

  modal.DocumentArticle mapToModel() => modal.DocumentArticle(
        id: id,
        abstractText: abstractText,
        publishedDate: publishedDate,
      );
}

extension DocumentArticleMapper on DocumentArticle {
  DocumentArticleDataModel mapToModel() => DocumentArticleDataModel(
        id: id,
        abstractText: abstract,
        publishedDate: publishedDate,
      );
}
