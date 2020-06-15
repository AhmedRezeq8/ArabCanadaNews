import 'package:flutter/services.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Services/api_service.dart';
import './categories/CategorieView.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'breaknews/breaknews.dart';
import 'contactUs/contactUsView.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'video/videoView.dart';

class More extends StatefulWidget {
  More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool show;
  ApiService _apiService;

  _facebook() async {
    const url = 'https://www.facebook.com/arcanadanews';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _twitter() async {
    const url = 'https://twitter.com/arabcanada_news';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _youtube() async {
    const url = 'https://www.youtube.com/channel/UCKTaA2A_rW8cH7Nj-KzGHLg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _instagram() async {
    const url = 'https://www.instagram.com/arabcanadanews/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // _whatsapp() async {
  //   const url = 'https://arabcanadanews.ca/page/2/';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // _soundcloud() async {
  //   const url = 'https://soundcloud.com/alroyapodcasts/';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // _snapchat() async {
  //   const url = 'https://www.instagram.com/alroyanewspaper/';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // _rss() async {
  //   const url = 'https://arabcanadanews.ca/rss';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // _podcastapple() async {
  //   const url =
  //       'https://podcasts.apple.com/om/podcast/alroya-podcasts-%D8%A7%D9%84%D8%B1%D8%A4%D9%8A%D8%A9-%D8%A8%D9%88%D8%AF%D9%83%D8%A7%D8%B3%D8%AA/id1495651008';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // _podcastalroya() async {
  //   const url = 'https://soundcloud.com/alroyapodcasts/';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(leading: Container())),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Color(0xffEFF4F8),
              height: 70,
              child: Center(
                child: Image.asset('assets/images/appbarlogo.png',
                    width: 163.0, height: 30.0),
              ),
            ),
            catsBuilder(),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: VideoView()));
                  HapticFeedback.mediumImpact();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(SFSymbols.camera, size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "فيديو",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: BreakNews()));
                  HapticFeedback.mediumImpact();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(SFSymbols.flame, size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "الأخبار العاجلة",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: ContactUsView()));
                  HapticFeedback.mediumImpact();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/smartphone.png',
                              width: 20.0, height: 20.0),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "تواصل معنا",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 200,
                child: Center(
                  child: Wrap(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            size: 20,
                          ),
                          onPressed: () => _facebook()),
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.twitter,
                            size: 20,
                          ),
                          onPressed: () => _twitter()),
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            size: 20,
                          ),
                          onPressed: () => _instagram()),
                      // IconButton(
                      //     icon: Icon(
                      //       FontAwesomeIcons.snapchat,
                      //       size: 20,
                      //     ),
                      //     onPressed: () => _snapchat()),
                      // IconButton(
                      //     icon: Icon(
                      //       FontAwesomeIcons.whatsapp,
                      //       size: 20,
                      //     ),
                      //     onPressed: () => _whatsapp()),
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.youtube,
                            size: 20,
                          ),
                          onPressed: () => _youtube()),
                      // IconButton(
                      //     icon: Icon(
                      //       FontAwesomeIcons.soundcloud,
                      //       size: 20,
                      //     ),
                      //     onPressed: () => _soundcloud()),
                      // IconButton(
                      //     icon: Icon(
                      //       FontAwesomeIcons.podcast,
                      //       size: 20,
                      //     ),
                      //     onPressed: () => _podcastapple()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  catsBuilder() {
    return FutureBuilder(
      future: _apiService.getCats(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  itemCount: content['data']['menu'].length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    // print(content['data']['menu'][index]['title']);
                    return CatList(
                      img: content['data']['menu'][index]['custom'],
                      title: content['data']['menu'][index]['title'],
                      catId: content['data']['menu'][index]['id'],
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height - 277,
            child: Center(
                child: Column(
              children: <Widget>[
                LinearProgressIndicator(),
                Image.asset('assets/images/loading.gif', width: 80),
                LinearProgressIndicator(),
              ],
            )),
          );
        }
      },
    );
  }
}

class CatList extends StatelessWidget {
  const CatList({Key key, this.img, this.title, this.catId}) : super(key: key);
  final String img;
  final String title;
  final int catId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.downToUp,
                child: CategorieView(title: title, catId: catId)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.network(
                  img,
                  width: 20.0,
                  height: 20.0,
                  headers: null,
                  color: null,
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
