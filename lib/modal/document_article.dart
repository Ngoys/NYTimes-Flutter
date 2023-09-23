class DocumentArticle {
  DocumentArticle({
    required this.id,
    this.abstractText,
    this.publishedDate,
  });

  DocumentArticle.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    abstractText = json['abstract'];
    publishedDate = DateTime.parse(json['pub_date']);
  }

  late final String id;
  late final String? abstractText;
  late final DateTime? publishedDate;
}
