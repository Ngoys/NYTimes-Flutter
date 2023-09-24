import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:nytimes/service/drift_db/dao/article_dao.dart';
import 'package:nytimes/service/drift_db/dao/document_article_dao.dart';
import 'package:nytimes/service/drift_db/entity/article_entity.dart';
import 'package:nytimes/service/drift_db/entity/document_article_entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'drift_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dbFolder.path, 'nytimes.sqlite'));
    return NativeDatabase(file);
  });
}

@singleton
@DriftDatabase(
  tables: <Type>[
    ArticleEntity,
    DocumentArticleEntity,
  ],
  daos: <Type>[
    ArticleDao,
    DocumentArticleDao,
  ],
)
class DriftDB extends _$DriftDB {
  DriftDB() : super(_openConnection());

  DriftDB.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
