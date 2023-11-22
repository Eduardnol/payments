import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payments/models/SaveInformation.dart';
import 'package:payments/services/authenticate/Wrapper.dart';
import 'package:payments/services/authenticate/auth.dart';
import 'package:payments/utils/Save.dart';
import 'package:payments/utils/Utils.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/Session.dart';
import 'models/UserLocal.dart';

//TODO iOS firebase cloud messaging
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SaveInformation.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserLocal?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        ChangeNotifierProvider<Session>.value(
          value: Session(SaveFile.decodeJson()),
        ),
      ],
      child: MaterialApp(
        navigatorObservers: [
          // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es'), // Español
        ],
        title: 'Payments',
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
//        cupertinoOverrideTheme: CupertinoThemeData(textTheme: GoogleFonts.indieFlowerTextTheme()),
          textTheme: GoogleFonts.montserratTextTheme(),
          dividerTheme: DividerThemeData(
            thickness: Borders.thickness,
            space: Borders.space,
//          indent: 20,
//          endIndent: 20,
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          primaryColor: ColorsApp.primary,
          hintColor: ColorsApp.secondary,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
              .copyWith(background: ColorsApp.background),
        ),
        home: Wrapper(), //MyHomePage(c),
      ),
    );
  }
}
