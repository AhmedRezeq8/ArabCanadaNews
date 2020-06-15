import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class LoadMoreWidget extends StatefulWidget {
  LoadMoreWidget({Key key}) : super(key: key);

  @override
  _LoadMoreWidgetState createState() => _LoadMoreWidgetState();
}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  @override
  Widget build(BuildContext context) {
    int count =100;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('load more'),
      ),
      body: Container(
        child: LoadMore(
          isFinish: count >= 60,
          onLoadMore: _loadMore,
          child: ListView.builder(
            
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Text('s'),
                height: 40.0,
                alignment: Alignment.center,
              );
            },
            itemCount: count,
          ),
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    // load();
    return true;
  }
}