import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalization
/// returned by `AppLocalization.of(context)`.
///
/// Applications need to include `AppLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalization.localizationsDelegates,
///   supportedLocales: AppLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalization.supportedLocales
/// property.
abstract class AppLocalization {
  AppLocalization(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @titleLandingScreen.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get titleLandingScreen;

  /// No description provided for @titleHomeScreen.
  ///
  /// In en, this message translates to:
  /// **'New York Times'**
  String get titleHomeScreen;

  /// No description provided for @actionEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get actionEnable;

  /// No description provided for @article.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get article;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{An hour ago} other{{count} hours ago}}'**
  String hoursAgo(num count);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 minute ago} other{{count} minutes ago}}'**
  String minutesAgo(num count);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Start searching...'**
  String get searchPlaceholder;

  /// No description provided for @homeMenuSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get homeMenuSearchTitle;

  /// No description provided for @homeMenuPopularTitle.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get homeMenuPopularTitle;

  /// No description provided for @homeMenuLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get homeMenuLocationTitle;

  /// No description provided for @homeMenuSearchArticleTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Articles'**
  String get homeMenuSearchArticleTitle;

  /// No description provided for @homeMenuMostViewedTitle.
  ///
  /// In en, this message translates to:
  /// **'Most Viewed'**
  String get homeMenuMostViewedTitle;

  /// No description provided for @homeMenuMostSharedTitle.
  ///
  /// In en, this message translates to:
  /// **'Most Shared'**
  String get homeMenuMostSharedTitle;

  /// No description provided for @homeMenuMostEmailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Most Emailed'**
  String get homeMenuMostEmailedTitle;

  /// No description provided for @labelOfflineMode.
  ///
  /// In en, this message translates to:
  /// **'Offline Mode'**
  String get labelOfflineMode;

  /// No description provided for @labelOnlineMode.
  ///
  /// In en, this message translates to:
  /// **'Online Mode'**
  String get labelOnlineMode;

  /// No description provided for @labelTooManyRequest.
  ///
  /// In en, this message translates to:
  /// **'Too many request'**
  String get labelTooManyRequest;

  /// No description provided for @labelSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get labelSomethingWentWrong;

  /// No description provided for @labelPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get labelPleaseTryAgain;
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(lookupAppLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}

AppLocalization lookupAppLocalization(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationEn();
  }

  throw FlutterError(
    'AppLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
