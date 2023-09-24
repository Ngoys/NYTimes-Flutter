// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_db.dart';

// ignore_for_file: type=lint
class $ArticleEntityTable extends ArticleEntity
    with TableInfo<$ArticleEntityTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticleEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedDateMeta =
      const VerificationMeta('publishedDate');
  @override
  late final GeneratedColumn<DateTime> publishedDate =
      GeneratedColumn<DateTime>('published_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _articleListingContentTypeMeta =
      const VerificationMeta('articleListingContentType');
  @override
  late final GeneratedColumn<String> articleListingContentType =
      GeneratedColumn<String>(
          'article_listing_content_type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, publishedDate, articleListingContentType];
  @override
  String get aliasedName => _alias ?? 'article_entity';
  @override
  String get actualTableName => 'article_entity';
  @override
  VerificationContext validateIntegrity(Insertable<Article> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('published_date')) {
      context.handle(
          _publishedDateMeta,
          publishedDate.isAcceptableOrUnknown(
              data['published_date']!, _publishedDateMeta));
    }
    if (data.containsKey('article_listing_content_type')) {
      context.handle(
          _articleListingContentTypeMeta,
          articleListingContentType.isAcceptableOrUnknown(
              data['article_listing_content_type']!,
              _articleListingContentTypeMeta));
    } else if (isInserting) {
      context.missing(_articleListingContentTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      publishedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}published_date']),
      articleListingContentType: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}article_listing_content_type'])!,
    );
  }

  @override
  $ArticleEntityTable createAlias(String alias) {
    return $ArticleEntityTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final String id;
  final String? title;
  final DateTime? publishedDate;
  final String articleListingContentType;
  const Article(
      {required this.id,
      this.title,
      this.publishedDate,
      required this.articleListingContentType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || publishedDate != null) {
      map['published_date'] = Variable<DateTime>(publishedDate);
    }
    map['article_listing_content_type'] =
        Variable<String>(articleListingContentType);
    return map;
  }

  ArticleEntityCompanion toCompanion(bool nullToAbsent) {
    return ArticleEntityCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      publishedDate: publishedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedDate),
      articleListingContentType: Value(articleListingContentType),
    );
  }

  factory Article.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      publishedDate: serializer.fromJson<DateTime?>(json['publishedDate']),
      articleListingContentType:
          serializer.fromJson<String>(json['articleListingContentType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'publishedDate': serializer.toJson<DateTime?>(publishedDate),
      'articleListingContentType':
          serializer.toJson<String>(articleListingContentType),
    };
  }

  Article copyWith(
          {String? id,
          Value<String?> title = const Value.absent(),
          Value<DateTime?> publishedDate = const Value.absent(),
          String? articleListingContentType}) =>
      Article(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        publishedDate:
            publishedDate.present ? publishedDate.value : this.publishedDate,
        articleListingContentType:
            articleListingContentType ?? this.articleListingContentType,
      );
  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('publishedDate: $publishedDate, ')
          ..write('articleListingContentType: $articleListingContentType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, publishedDate, articleListingContentType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.title == this.title &&
          other.publishedDate == this.publishedDate &&
          other.articleListingContentType == this.articleListingContentType);
}

class ArticleEntityCompanion extends UpdateCompanion<Article> {
  final Value<String> id;
  final Value<String?> title;
  final Value<DateTime?> publishedDate;
  final Value<String> articleListingContentType;
  final Value<int> rowid;
  const ArticleEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.publishedDate = const Value.absent(),
    this.articleListingContentType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticleEntityCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.publishedDate = const Value.absent(),
    required String articleListingContentType,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        articleListingContentType = Value(articleListingContentType);
  static Insertable<Article> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? publishedDate,
    Expression<String>? articleListingContentType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (publishedDate != null) 'published_date': publishedDate,
      if (articleListingContentType != null)
        'article_listing_content_type': articleListingContentType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticleEntityCompanion copyWith(
      {Value<String>? id,
      Value<String?>? title,
      Value<DateTime?>? publishedDate,
      Value<String>? articleListingContentType,
      Value<int>? rowid}) {
    return ArticleEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      publishedDate: publishedDate ?? this.publishedDate,
      articleListingContentType:
          articleListingContentType ?? this.articleListingContentType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (publishedDate.present) {
      map['published_date'] = Variable<DateTime>(publishedDate.value);
    }
    if (articleListingContentType.present) {
      map['article_listing_content_type'] =
          Variable<String>(articleListingContentType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('publishedDate: $publishedDate, ')
          ..write('articleListingContentType: $articleListingContentType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentArticleEntityTable extends DocumentArticleEntity
    with TableInfo<$DocumentArticleEntityTable, DocumentArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentArticleEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _abstractMeta =
      const VerificationMeta('abstract');
  @override
  late final GeneratedColumn<String> abstract = GeneratedColumn<String>(
      'abstract', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedDateMeta =
      const VerificationMeta('publishedDate');
  @override
  late final GeneratedColumn<DateTime> publishedDate =
      GeneratedColumn<DateTime>('published_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, abstract, publishedDate];
  @override
  String get aliasedName => _alias ?? 'document_article_entity';
  @override
  String get actualTableName => 'document_article_entity';
  @override
  VerificationContext validateIntegrity(Insertable<DocumentArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('abstract')) {
      context.handle(_abstractMeta,
          abstract.isAcceptableOrUnknown(data['abstract']!, _abstractMeta));
    }
    if (data.containsKey('published_date')) {
      context.handle(
          _publishedDateMeta,
          publishedDate.isAcceptableOrUnknown(
              data['published_date']!, _publishedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentArticle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      abstract: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abstract']),
      publishedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}published_date']),
    );
  }

  @override
  $DocumentArticleEntityTable createAlias(String alias) {
    return $DocumentArticleEntityTable(attachedDatabase, alias);
  }
}

class DocumentArticle extends DataClass implements Insertable<DocumentArticle> {
  final String id;
  final String? abstract;
  final DateTime? publishedDate;
  const DocumentArticle({required this.id, this.abstract, this.publishedDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || abstract != null) {
      map['abstract'] = Variable<String>(abstract);
    }
    if (!nullToAbsent || publishedDate != null) {
      map['published_date'] = Variable<DateTime>(publishedDate);
    }
    return map;
  }

  DocumentArticleEntityCompanion toCompanion(bool nullToAbsent) {
    return DocumentArticleEntityCompanion(
      id: Value(id),
      abstract: abstract == null && nullToAbsent
          ? const Value.absent()
          : Value(abstract),
      publishedDate: publishedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedDate),
    );
  }

  factory DocumentArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentArticle(
      id: serializer.fromJson<String>(json['id']),
      abstract: serializer.fromJson<String?>(json['abstract']),
      publishedDate: serializer.fromJson<DateTime?>(json['publishedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'abstract': serializer.toJson<String?>(abstract),
      'publishedDate': serializer.toJson<DateTime?>(publishedDate),
    };
  }

  DocumentArticle copyWith(
          {String? id,
          Value<String?> abstract = const Value.absent(),
          Value<DateTime?> publishedDate = const Value.absent()}) =>
      DocumentArticle(
        id: id ?? this.id,
        abstract: abstract.present ? abstract.value : this.abstract,
        publishedDate:
            publishedDate.present ? publishedDate.value : this.publishedDate,
      );
  @override
  String toString() {
    return (StringBuffer('DocumentArticle(')
          ..write('id: $id, ')
          ..write('abstract: $abstract, ')
          ..write('publishedDate: $publishedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, abstract, publishedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentArticle &&
          other.id == this.id &&
          other.abstract == this.abstract &&
          other.publishedDate == this.publishedDate);
}

class DocumentArticleEntityCompanion extends UpdateCompanion<DocumentArticle> {
  final Value<String> id;
  final Value<String?> abstract;
  final Value<DateTime?> publishedDate;
  final Value<int> rowid;
  const DocumentArticleEntityCompanion({
    this.id = const Value.absent(),
    this.abstract = const Value.absent(),
    this.publishedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentArticleEntityCompanion.insert({
    required String id,
    this.abstract = const Value.absent(),
    this.publishedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<DocumentArticle> custom({
    Expression<String>? id,
    Expression<String>? abstract,
    Expression<DateTime>? publishedDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abstract != null) 'abstract': abstract,
      if (publishedDate != null) 'published_date': publishedDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentArticleEntityCompanion copyWith(
      {Value<String>? id,
      Value<String?>? abstract,
      Value<DateTime?>? publishedDate,
      Value<int>? rowid}) {
    return DocumentArticleEntityCompanion(
      id: id ?? this.id,
      abstract: abstract ?? this.abstract,
      publishedDate: publishedDate ?? this.publishedDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (abstract.present) {
      map['abstract'] = Variable<String>(abstract.value);
    }
    if (publishedDate.present) {
      map['published_date'] = Variable<DateTime>(publishedDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentArticleEntityCompanion(')
          ..write('id: $id, ')
          ..write('abstract: $abstract, ')
          ..write('publishedDate: $publishedDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftDB extends GeneratedDatabase {
  _$DriftDB(QueryExecutor e) : super(e);
  late final $ArticleEntityTable articleEntity = $ArticleEntityTable(this);
  late final $DocumentArticleEntityTable documentArticleEntity =
      $DocumentArticleEntityTable(this);
  late final ArticleDao articleDao = ArticleDao(this as DriftDB);
  late final DocumentArticleDao documentArticleDao =
      DocumentArticleDao(this as DriftDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [articleEntity, documentArticleEntity];
}
