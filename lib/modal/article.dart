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
}
