import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationEn extends AppLocalization {
  AppLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get titleLandingScreen => 'Get Started';

  @override
  String get titleHomeScreen => 'New York Times';

  @override
  String get actionEnable => 'Enable';

  @override
  String get article => 'Article';

  @override
  String get ok => 'ok';

  @override
  String get homeMenuSearchTitle => 'Search';

  @override
  String get homeMenuPopularTitle => 'Popular';

  @override
  String get homeMenuLocationTitle => 'Location';

  @override
  String get homeMenuSearchArticleTitle => 'Search Articles';

  @override
  String get homeMenuMostViewedTitle => 'Most Viewed';

  @override
  String get homeMenuMostSharedTitle => 'Most Shared';

  @override
  String get homeMenuMostEmailedTitle => 'Most Emailed';

  @override
  String get labelOfflineMode => 'Offline Mode';

  @override
  String get labelOnlineMode => 'Online Mode';

  @override
  String get labelSomethingWentWrong => 'Something went wrong';

  @override
  String get labelPleaseTryAgain => 'Please try again later';
}
