import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:my_profile/dependencies_injection/module_container.dart';
import 'package:my_profile/presentation/localization/app_localizations.dart';
import 'package:my_profile/presentation/localization/string_keys.dart';
import 'package:my_profile/presentation/providers/loader/loader_provider.dart';
import 'package:my_profile/presentation/providers/login/login_provider.dart';
import 'package:my_profile/presentation/providers/user/user_provider.dart';
import 'package:my_profile/presentation/screens/home/home_screen.dart';
import 'package:my_profile/presentation/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  ModuleContainer().initialise(Injector());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFAA538),
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LoginProvider()),
        ChangeNotifierProvider(create: (ctx) => LoaderProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // accentColor: Colors.amber,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'QuickSand',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                bodyText2: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                button: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            appBarTheme: AppBarTheme(
                // textTheme: ThemeData.light().textTheme.copyWith(
                //     headline6: TextStyle(
                //         fontFamily: 'OpenSans',
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold))
                )),
        supportedLocales: [
          Locale(StringKeys.SUPPORTED_LANGUAGES[StringKeys.ENGLISH], ''),
          Locale(StringKeys.SUPPORTED_LANGUAGES[StringKeys.HEBREW], ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode ||
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        home: Consumer<LoaderProvider>(builder: (context, value, child) {
          return AbsorbPointer(
            absorbing: value.isShowLoader ? true : false,
            child: LoginScreen(),
          );
        }),
      ),
    );
  }
}
