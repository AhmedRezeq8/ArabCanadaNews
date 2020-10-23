import 'package:arab_canada_new/Animations/fadeanimation.dart';
import 'package:arab_canada_new/Screens/details/detailview.dart';
import 'package:arab_canada_new/Services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:page_transition/page_transition.dart';
import '../../Tools/globals.dart' as g;

class CategorieView1 extends StatefulWidget {
  CategorieView1({Key key, this.title, this.catId}) : super(key: key);
  final String title;
  final int catId;
  @override
  _CategorieView1State createState() => _CategorieView1State();
}

class _CategorieView1State extends State<CategorieView1> {
  ScrollController _scrollController = ScrollController();
  List<Posts> data = [];
  bool isLoading = false;
  int currentPage = 1;
  ScrollPhysics physics;

  @override
  void initState() {
    super.initState();
    fetchMore(currentPage);
    _scrollController.addListener(() {
      if (this.mounted) {
        setState(() {
          var isEnd = _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent;
          var isStart = _scrollController.position.pixels ==
              _scrollController.position.minScrollExtent;
          if (isEnd) {
            fetchMore(currentPage);
          }
          if (isStart) {
            print('start');
            physics = ScrollPhysics(parent: NeverScrollableScrollPhysics());
            Future.delayed(const Duration(milliseconds: 2000), () {
              if (this.mounted) {
                setState(() {
                  physics = ScrollPhysics(parent: ClampingScrollPhysics());
                });
              }
            });
          } else {
            physics = ScrollPhysics(parent: ClampingScrollPhysics());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  fetch() {
    ApiService().getBreakNews().then((value) {
      for (var item in value['data']['posts']) {
        if (this.mounted) {
          setState(() {
            if (item['post_type'] == 'ads') {
              print('this is ads');
              data.add(Posts(
                postType: item['post_type'],
                adsimage: 'https://arabcanadanews.ca/' + item['image'],
                link: item['link'],
              ));
            } else {
              print('this is post');
              data.add(Posts(
                postType: item['post_type'],
                imageUrl: 'https://arabcanadanews.ca/' + item['image'],
                id: item['id'],
                time: item['time'],
                title: item['title'],
              ));
            }

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
    return PostsListBuilder(
      scrollController: _scrollController,
      data: data,
      isLoading: isLoading,
      physics: physics,
      curruntPage: currentPage,
      pageTitle: widget.title,
    );
  }
}

// posts model map
class Posts {
  //posts
  String title;
  String imageUrl;
  String time;
  int id;
  //ads
  String postType;
  String link;
  String adsimage;

  Posts(
      {this.id,
      this.imageUrl,
      this.title,
      this.time,
      this.postType,
      this.link,
      this.adsimage});
}
// end posts model map

class PostsListBuilder extends StatefulWidget {
  const PostsListBuilder({
    Key key,
    @required ScrollController scrollController,
    @required this.data,
    @required this.isLoading,
    @required this.physics,
    @required this.curruntPage,
    @required this.pageTitle,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Posts> data;
  final bool isLoading;
  final ScrollPhysics physics;
  final int curruntPage;
  final String pageTitle;

  @override
  _PostsListBuilderState createState() => _PostsListBuilderState();
}

class _PostsListBuilderState extends State<PostsListBuilder> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  Future<Null> refreshAll() async {
    await Future.delayed(Duration(seconds: 1));
    HapticFeedback.mediumImpact();
    setState(() {
      refreshKey = GlobalKey<RefreshIndicatorState>();
    });
  }

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef4f8),
      appBar: AppBar(
        title: Text(widget.pageTitle),
        leading: Container(),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshAll();
        },
        child: ListView.builder(
          controller: widget._scrollController,
          itemCount: widget.data.length + 1,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            if (index == 0 && widget.data.length > 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 0),
                child: Container(
                    height: 350,
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
                                child: DetailView(widget.data[index].id)));
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
                              image: widget.data[index].imageUrl,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                widget.data[index].title,
                                style: TextStyle(
                                    fontFamily: "sst-arabic-bold",
                                    fontSize: 18,
                                    height: 1.3),
                                textAlign: TextAlign.right,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            } else {
              if (index == widget.data.length) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 90,
                  child: Visibility(
                      visible: widget.isLoading,
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
              } else if (widget.data[index].postType == 'post') {
                return FadeAnimation(
                  0.6,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                    child: DetailView(widget.data[index].id)));
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
                                  image: widget.data[index].imageUrl,
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.only(right: 10, left: 0),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                200,
                                        child: Text(
                                          widget.data[index].title,
                                          style: TextStyle(
                                              fontFamily: "SST-Arabic-Medium",
                                              fontSize: 16,
                                              height: 1.5),
                                          textAlign: TextAlign.right,
                                          maxLines: 3,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 10),
                                      child: Text(
                                        widget.data[index].time,
                                        style: TextStyle(
                                            fontFamily: "SST-Arabic-Medium",
                                            fontSize: 12,
                                            color: Colors.grey.shade600),
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
            }
          },
        ),
      ),
    );
  }
}
