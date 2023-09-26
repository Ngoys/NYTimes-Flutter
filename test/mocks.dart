import 'package:geolocator/geolocator.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/modal/home_menu.dart';
import 'package:nytimes/modal/home_menu_section.dart';

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
