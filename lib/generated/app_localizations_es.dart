import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationEs extends AppLocalization {
  AppLocalizationEs([String locale = 'es']) : super(locale);

  @override
  String get titleLandingScreen => 'Empezar';

  @override
  String get actionEnable => 'Permitir';

  @override
  String get labelOfflineMode => 'Offline Mode';

  @override
  String get labelOnlineMode => 'Online Mode';
}
