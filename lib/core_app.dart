import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nytimes/config/base_config.dart';
import 'package:nytimes/generated/app_localizations.dart';
import 'package:nytimes/service/geolocation_store.dart';
import 'package:nytimes/ui/landing/landing_screen.dart';
import 'package:nytimes/utils/app_navigator_observer.dart';
import 'package:nytimes/utils/context_extension.dart';

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class CoreApp extends StatefulWidget {
  const CoreApp({required this.config, super.key});

  final BaseConfig config;

  @override
  State<CoreApp> createState() => _CoreAppState();
}

class _CoreAppState extends State<CoreApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    final BaseConfig baseConfig = context.config;

    return MultiBlocProvider(
      providers: const <BlocProvider<dynamic>>[],
      child: MaterialApp(
          scaffoldMessengerKey: snackBarKey,
          navigatorObservers: <NavigatorObserver>[AppNavigatorObserver()],
          title: baseConfig.appName(),
          theme: baseConfig.lightTheme(),
          darkTheme: baseConfig.darkTheme(),
          supportedLocales: baseConfig.locales(),
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback:
              (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
            final Locale locale = supportedLocales.firstWhere(
                (Locale element) =>
                    element.languageCode == deviceLocale?.languageCode,
                orElse: () => const Locale('en'));
            return locale;
          },
          onGenerateRoute: baseConfig.routeFactory,
          initialRoute: LandingScreen.route,
          builder: (BuildContext context, Widget? child) => child!),
    );
  }

  @override
  void dispose() {
    GetIt.instance<GeoLocationStore>().close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
