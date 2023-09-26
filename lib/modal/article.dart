// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

class Article {
  Article({
    required this.id,
    this.title,
    this.publishedDate,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    publishedDate = DateTime.parse(json['published_date']);
  }

  late final String id;
  late final String? title;
  late final DateTime? publishedDate;

  @override
  bool operator ==(Object other) {
    if (other is! Article) {
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
