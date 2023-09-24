// ignore_for_file: always_specify_types
import 'package:drift/drift.dart';

@DataClassName('Article')
class ArticleEntity extends Table {
  TextColumn get id => text()();

  TextColumn get title => text().nullable()();

  DateTimeColumn get publishedDate => dateTime().nullable()();

  TextColumn get articleListingContentType => text()();

  @override
  Set<Column> get primaryKey => {id};
}
