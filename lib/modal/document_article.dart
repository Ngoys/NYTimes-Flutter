// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

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

  @override
  bool operator ==(Object other) {
    if (other is! DocumentArticle) {
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
