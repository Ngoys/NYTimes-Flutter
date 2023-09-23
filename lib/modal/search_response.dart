import 'package:nytimes/modal/document_article.dart';

class SearchResponse {
  SearchResponse({
    required this.docs,
  });

  SearchResponse.fromJson(Map<String, dynamic> json) {
    docs = (json['docs'] as List<dynamic>)
        .map((dynamic docJson) => DocumentArticle.fromJson(docJson))
        .toList();
  }

  late final List<DocumentArticle> docs;
}
