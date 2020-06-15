import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'break_news_widget.dart';

class BreakNews extends StatefulWidget {
  const BreakNews({Key key}) : super(key: key);

  @override
  _BreakNewsState createState() => _BreakNewsState();
}

class _BreakNewsState extends State<BreakNews> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  @override
  void initState() {
    refreshKey = GlobalKey<RefreshIndicatorState>();
    super.initState();
    HapticFeedback.mediumImpact();
  }

  Future<Null> refreshAll() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      refreshKey = GlobalKey<RefreshIndicatorState>();
      HapticFeedback.mediumImpact();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef4f8),
      appBar: AppBar(
        title: Text('عاجل'),
        centerTitle: true,
        // leading: Container(),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await refreshAll();
          },
          child: BreakNewsWidget()),
    );
  }
}
