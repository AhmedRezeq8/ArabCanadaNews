import 'dart:async';

import 'package:flutter/material.dart';
import '../Tools/globals.dart' as g;
import 'tabbar.dart';

class SplashFull extends StatefulWidget {
  SplashFull({Key key}) : super(key: key);

  @override
  _SplashFullState createState() => _SplashFullState();
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}

class _SplashFullState extends State<SplashFull> {
  void navigationPage() {
    Navigator.push(context, MyCustomRoute(builder: (context) => MyTabBar()));
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    print(g.isLoged);
    startTime();

    // setState(() {
    //    print(g.isLoged);
    //    g.isLoged=true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if (g.isLoged== true) {

    //   navigationPage();
    // }
    //  print(g.isLoged);
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/splashscreen.gif',
            fit: BoxFit.cover,
          )),
    );
  }
}
