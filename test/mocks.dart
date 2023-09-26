import 'package:geolocator/geolocator.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/document_article.dart';
import 'package:nytimes/modal/failure_response.dart';
import 'package:nytimes/modal/home_menu.dart';
import 'package:nytimes/modal/home_menu_section.dart';
import 'package:nytimes/utils/constants.dart';

DateTime mockDateTime = DateTime(2095, 9, 24, 15, 30);

Position mockPosition = Position(
  longitude: 1,
  latitude: 2,
  timestamp: mockDateTime,
  accuracy: 5,
  altitude: 100,
  heading: 45,
  speed: 10,
  speedAccuracy: 2,
);

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

List<DocumentArticle> mockDocumentArticles1 = <DocumentArticle>[
  DocumentArticle(
    id: '1',
    abstractText: 'abstractText1',
    publishedDate: mockDateTime,
  ),
  DocumentArticle(
    id: '2',
    abstractText: 'abstractText2',
    publishedDate: mockDateTime.add(const Duration(days: 1)),
  ),
  DocumentArticle(
    id: '3',
    abstractText: 'abstractText3',
    publishedDate: mockDateTime.add(const Duration(days: 10)),
  )
];

List<DocumentArticle> mockDocumentArticles2 = <DocumentArticle>[
  DocumentArticle(
    id: '4',
    abstractText: 'abstractText4',
    publishedDate: mockDateTime,
  ),
  DocumentArticle(
    id: '5',
    abstractText: 'abstractText5',
    publishedDate: mockDateTime.add(const Duration(days: 1)),
  ),
  DocumentArticle(
    id: '6',
    abstractText: 'abstractText6',
    publishedDate: mockDateTime.add(const Duration(days: 10)),
  )
];

HomeMenuSection mockSearchSection = const HomeMenuSection(
    type: HomeMenuSectionType.search,
    menus: <HomeMenu>[HomeMenu.searchArticle]);

HomeMenuSection mockPopularSection = const HomeMenuSection(
    type: HomeMenuSectionType.popular,
    menus: <HomeMenu>[
      HomeMenu.mostViewed,
      HomeMenu.mostShared,
      HomeMenu.mostEmailed
    ]);

HomeMenuSection mockLocationSection = HomeMenuSection(
    type: HomeMenuSectionType.location,
    menus: <HomeMenu>[HomeMenu.location(mockPosition)]);

FailureResponse mockFailureResponse = FailureResponse(
    code: notFound, error: 'notFound', errorDescription: 'notFoundDescription');
