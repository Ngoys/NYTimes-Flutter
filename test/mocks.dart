import 'package:nytimes/modal/article.dart';

DateTime mockDateTime = DateTime(2023, 9, 24, 15, 30);

List<Article> mockArticles1 = <Article>[
  Article(
    id: '1',
    title: 'title1',
    publishedDate: mockDateTime,
  ),
  Article(
    id: '2',
    title: 'title2',
    publishedDate: mockDateTime.add(const Duration(days: 1)),
  ),
  Article(
    id: '3',
    title: 'title3',
    publishedDate: mockDateTime.add(const Duration(days: 10)),
  )
];

List<Article> mockArticles2 = <Article>[
  Article(
    id: '4',
    title: 'title4',
    publishedDate: mockDateTime,
  ),
  Article(
    id: '5',
    title: 'title5',
    publishedDate: mockDateTime.add(const Duration(days: 1)),
  ),
  Article(
    id: '6',
    title: 'title6',
    publishedDate: mockDateTime.add(const Duration(days: 10)),
  )
];
