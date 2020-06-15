import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Screens/SplashScreen.dart';
import 'Screens/tabbar.dart';
import 'Tools/globals.dart' as g;

// import 'Screens/SplashScreen.dart'; //

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
            child: child,
          );
        },
        navigatorObservers: [BotToastNavigatorObserver()],
        darkTheme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            brightness: Brightness.light,
            fontFamily: "SST-Arabic-Medium",
            primaryColor: g.dark,
            accentColor: g.dark),
        theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            brightness: Brightness.light,
            fontFamily: "SST-Arabic-Medium",
            primaryColor: g.dark,
            accentColor: g.dark),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar'), // arabic
        ],
        debugShowCheckedModeBanner: false,
        home: MyTabBar(),
        // routes: {
        //   '/': (ctx) => SplashScreen(),
        //   "/MyTabBar": (ctx) => MyTabBar(),
        // },
        // home: FadeAnimation(0.5, MyTabBar()),
      ),
    );
  }
}
