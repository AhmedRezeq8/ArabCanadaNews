import 'package:arab_canada_new/Animations/fadeanimation.dart';
import 'package:arab_canada_new/Services/api_service.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import '../../Tools/globals.dart' as g;

class AlrayDetail extends StatefulWidget {
  final int id;
  final String img;
  AlrayDetail(this.id, this.img);

  @override
  _AlrayDetailState createState() => _AlrayDetailState();
}

class _AlrayDetailState extends State<AlrayDetail> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(leading: Container())),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          bottom: false,
          child: FutureBuilder(
              future: _apiService.getdetail(widget.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map content = snapshot.data;
                  String imgurl =
                      _apiService.getImage(content['data']['img'].toString());

                  String authImgurl = widget.img;

                  return Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Opacity(
                          opacity: 1,
                          child: FadeAnimation(
                            0.5,
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imgurl)),
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment
                                      .bottomCenter, // 10% of the width, so there are ten blinds.
                                  colors: [
                                    Colors.black.withOpacity(0.2),
                                    Colors.black.withOpacity(0)
                                  ], // whitish to gray
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 10,
                        right: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: FadeAnimation(
                            0.6,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Share.share(
                                            content['data']['title'] +
                                                ' - ' +
                                                'https://arabcanadanews.ca//post/' +
                                                widget.id.toString(),
                                            subject: content['data']['title']);
                                        HapticFeedback.mediumImpact();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: g.dark,
                                        radius: 20,
                                        child: Icon(
                                          SFSymbols.square_arrow_up,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(authImgurl),
                                      radius: 20,
                                      child: Opacity(
                                        opacity: 0.1,
                                        child: Icon(
                                          SFSymbols.person,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xff17202c),
                                    radius: 20,
                                    child: Icon(
                                      SFSymbols.arrow_left,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        right: 15,
                        bottom: -100,
                        height: MediaQuery.of(context).size.height - 140,
                        child: FadeAnimation(
                          0.5,
                          Container(
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius:
                                      20.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      5.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    0.0, // horizontal, move right 10
                                    2.0, // vertical, move down 10
                                  ),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    // first ads here :)
                                    FadeAnimation(
                                      0.6,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                HapticFeedback.mediumImpact();

                                                _openAds(
                                                    content['ads1']['link']);
                                              },
                                              child: Container(
                                                child: Image.network(
                                                  _apiService.getImage(
                                                      content['ads1']['img']
                                                          .toString()),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      content['data']['title'],
                                      style: TextStyle(
                                          fontFamily: "sst-arabic-bold",
                                          fontSize: 23,
                                          height: 1.3),
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      content['data']['time'],
                                      style: TextStyle(
                                          fontFamily: "sst-roman",
                                          fontSize: 10,
                                          height: 1.3),
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(height: 10),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Html(
                                          linkStyle: const TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                          data: content['data']['details']
                                              ['body'],
                                          onLinkTap: (url) {
                                            print("Opening $url...");
                                          },
                                          customTextAlign: (_) =>
                                              TextAlign.right),
                                    ),
                                    FadeAnimation(
                                      0.6,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                HapticFeedback.mediumImpact();

                                                _openAds(
                                                    content['ads2']['link']);
                                              },
                                              child: Container(
                                                child: Image.network(
                                                  _apiService.getImage(
                                                      content['ads2']['img']
                                                          .toString()),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    Footer(),
                                    SizedBox(
                                      height: 80,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                        child: Image.asset('assets/images/loading.gif',
                            width: 200)),
                  );
                }
              })),
    );
  }

  _openAds(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Footer extends StatelessWidget {
  const Footer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          color: g.dark,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "جميع الحقوق محفوظة لـ الرؤية نيوز ©2020",
              style: TextStyle(
                  fontFamily: "sst-arabic-bold",
                  fontSize: 10,
                  height: 1.3,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
