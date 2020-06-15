import 'package:arab_canada_new/Animations/fadeanimation.dart';
import 'package:arab_canada_new/Screens/details/detailview.dart';
import 'package:arab_canada_new/Services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../Tools/globals.dart' as g;
import 'FeaturedView.dart';
import 'widget_1.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
    ScrollController scrollController,
    this.data,
    this.isLoading,
    this.physics,
    this.curruntPage,
    int atId,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Posts> data;
  final bool isLoading;
  final ScrollPhysics physics;
  final int curruntPage;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  ScrollController _scrollController = ScrollController();
  List<Posts> data = [];
  bool isLoading = false;
  int currentPage = 1;
  ScrollPhysics physics;

  bool _goUP;
  bool isBottom = false;
  ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('BOTOM HOME');
      _goUP = true;
      fetchMore(currentPage);
      if (this.mounted) {
        setState(() {});
      }
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      if (this.mounted) {
        setState(() {
          _goUP = false;
        });
      }

      print('TOP HOME');
      HapticFeedback.mediumImpact();
    }
  }

  @override
  void initState() {
    HapticFeedback.mediumImpact();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    super.initState();
    _goUP = false;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    fetchMore(currentPage);
  }

  Future<Null> refreshAll() async {
    await Future.delayed(Duration(seconds: 1));
    //vibrate();
    HapticFeedback.mediumImpact();

    setState(() {
      refreshKey = GlobalKey<RefreshIndicatorState>();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  fetch() {
    ApiService()
      ..getLatest(currentPage).then((value) {
        for (var item in value['data']['latest']['data']) {
          if (this.mounted) {
            setState(() {
              // print(item['category']['title'] );
              data.add(Posts(
                imageUrl: ApiService().getImage(item['image']),
                id: item['id'],
                // time: 'غير متوفر',
                time: item['time'] == null ? 'غير متوفر' : item['time'],
                // categoryTitle:'غير متوفر',
                categoryTitle: item['category']['title'] == null
                    ? 'غير متوفر'
                    : item['category']['title'],
                title: item['title'] == null ? 'غير متوفر' : item['title'],
              ));
              isLoading = false;
              HapticFeedback.mediumImpact();
            });
          }
        }
      });
  }

  fetchMore(int page) {
    if (!isLoading) {
      if (this.data.length > 0) {
        if (this.mounted) {
          setState(() {
            isLoading = true;
            HapticFeedback.mediumImpact();
          });
        }
      }
    } else {
      return;
    }
    fetch();
    print(currentPage);
    currentPage += 1;
  }

  @override
  Widget build(BuildContext context) {
// refreshKey.currentState.show(atTop: true);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0), // here the desired height
          child: AppBar(leading: Container())),
      floatingActionButton: _goUP
          ? FloatingActionButton(
              backgroundColor: g.dark,
              onPressed: () {
                HapticFeedback.mediumImpact();
                _controller.animateTo(_controller.offset - 1600,
                    curve: Curves.linear,
                    duration: Duration(milliseconds: 500));
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Color(0xffeef4f8),
      body: SafeArea(
        top: true,
        bottom: false,
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await refreshAll();
          },
          child: all(),
        ),
      ),
    );
  }

  all() {
    return SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 0),
              itemCount: 1,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    FeaturedView(),
                    SizedBox(height: 10),
                    ThirdNews(),
                    SizedBox(height: 10),
                    latestNews()
                  ],
                );
              },
            ),
          ],
        ));
  }

  ListView latestNews() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 0),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: data.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0 && data.length > 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Container(
                height: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: g.dark.withOpacity(0.2),
                      blurRadius: 1.0,
                      spreadRadius: 0.1,
                      offset: Offset(
                        0.0,
                        0.2,
                      ),
                    )
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();

                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.downToUp,
                            child: DetailView(data[index].id)));
                  },
                  child: FadeAnimation(
                    0.5,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/loader.gif',
                          image: data[index].imageUrl,
                        ),
                        FadeAnimation(
                          0.5,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Container(
                              height: 70,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index].title,
                                    style: TextStyle(
                                        fontFamily: "sst-arabic-bold",
                                        fontSize: 18,
                                        height: 1.3),
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                  ),
                                  Container(
                                    color: Colors.grey.shade100,
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      data[index].time,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        } else {
          if (index == data.length) {
            return Container(
              height: 70,
              child: Visibility(
                  visible: isLoading,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 0),
                      Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          )),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Container(
                              height: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  'جاري تحميل المزيد ...',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )),
            );
          }
          return FadeAnimation(
            0.4,
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: g.dark.withOpacity(0.2),
                        blurRadius: 1.0,
                        spreadRadius: 0.1,
                        offset: Offset(
                          0.0,
                          0.2,
                        ),
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.downToUp,
                              child: DetailView(data[index].id)));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeInImage.assetNetwork(
                            width: 160,
                            height: 105,
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/loader.gif',
                            image: data[index].imageUrl,
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.red.shade900,
                                      width: 3,
                                      height: 10,
                                    ),
                                    Container(
                                      color: Colors.yellow.shade900,
                                      width: 2,
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data[index].categoryTitle,
                                      style: TextStyle(
                                          fontFamily: "SST-Arabic-Medium",
                                          fontSize: 12,
                                          color: Colors.grey.shade500),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10, left: 0),
                                width: MediaQuery.of(context).size.width - 200,
                                child: Text(
                                  data[index].title,
                                  style: TextStyle(
                                      fontFamily: "SST-Arabic-Medium",
                                      fontSize: 14,
                                      height: 1.5),
                                  textAlign: TextAlign.right,
                                  maxLines: 3,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, right: 10, left: 0),
                                child: Container(
                                  color: Colors.grey.shade100,
                                  padding: EdgeInsets.all(3),
                                  child: Text(
                                    data[index].time,
                                    style: TextStyle(
                                        fontFamily: "SST-Arabic-Medium",
                                        fontSize: 12,
                                        color: Colors.grey.shade600),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        }
      },
    );
  }
}

// posts model map
class Posts {
  String title;
  String imageUrl;
  String categoryTitle;
  String time;
  int id;

  Posts({this.id, this.imageUrl, this.title, this.categoryTitle, this.time});
}
// end posts model map
