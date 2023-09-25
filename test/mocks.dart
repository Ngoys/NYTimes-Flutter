import 'package:nytimes/modal/article.dart';

List<Article> mockArticles = [
  Article(
    id: '1',
    title: 'title1',
    publishedDate: DateTime.now(),
  ),
  Article(
    id: '2',
    title: 'title2',
    publishedDate: DateTime.now().add(const Duration(days: 1)),
  ),
  Article(
    id: '3',
    title: 'title3',
    publishedDate: DateTime.now().add(const Duration(days: 10)),
  )
];
