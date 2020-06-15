import 'package:arab_canada_new/Animations/fadeanimation.dart';
import 'package:arab_canada_new/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:page_transition/page_transition.dart';

import '../details/detailview.dart';
import '../../Tools/globals.dart' as g;

class ThirdNews extends StatelessWidget {
  const ThirdNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
      child: FadeAnimation(
        1,
        Column(children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      width: 4,
                      height: 20,
                      color: g.dark,
                    ),
                    Text(
                      g.widget_1_title,
                      style: TextStyle(
                          fontFamily: "sst-arabic-bold",
                          fontSize: 23,
                          height: 1.3),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: Widget1News(),
          ),
        ]),
      ),
    );
  }
}

class Widget1News extends StatefulWidget {
  const Widget1News({Key key}) : super(key: key);

  @override
  _Widget1NewsState createState() => _Widget1NewsState();
}

class _Widget1NewsState extends State<Widget1News> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return widget1Builder();
  }

  widget1Builder() {
    return FutureBuilder(
      future: ApiService().getWidget_1(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: content['data']['widget_1'][0]['news'].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                String imageurl = ApiService().getImage(content['data']
                        ['widget_1'][0]['news'][index]['image']
                    .toString());
                return Container(
                    width: 170,
                    height: 180,
                    margin: EdgeInsets.only(left: 0, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.downToUp,
                                  child: DetailView(content['data']['widget_1']
                                      [0]['news'][index]['id'])));
                          HapticFeedback.mediumImpact();
                        },
                        child: Column(
                          children: <Widget>[
                            FadeInImage.assetNetwork(
                              height: 105,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: 'assets/images/loader.gif',
                              image: imageurl,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                content['data']['widget_1'][0]['news'][index]
                                        ['title']
                                    .toString(),
                                style: TextStyle(
                                  fontFamily: "SST-Arabic-Medium",
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.right,
                                maxLines: 3,
                              ),
                            )
                          ],
                        )));
              },
            ),
          );
        } else {
          return Container(
              height: 100,
              child: Center(
                  child: Image.asset('assets/images/loading.gif',
                      width: 100.0, height: 100.0)));
        }
      },
    );
  }
}
