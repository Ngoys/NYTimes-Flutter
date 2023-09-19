import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationEn extends AppLocalization {
  AppLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get titleLandingScreen => 'Get Started';

  @override
  String get actionEnable => 'Enable';

  @override
  String get labelOfflineMode => 'Offline Mode';

  @override
  String get labelOnlineMode => 'Online Mode';
}
