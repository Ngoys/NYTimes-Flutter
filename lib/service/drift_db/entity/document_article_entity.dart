// ignore_for_file: always_specify_types
import 'package:drift/drift.dart';

@DataClassName('DocumentArticle')
class DocumentArticleEntity extends Table {
  TextColumn get id => text()();

  TextColumn get abstract => text().nullable()();

  DateTimeColumn get publishedDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
