import 'package:arab_canada_new/Animations/fadeanimation.dart';
import 'package:arab_canada_new/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class BreakNewsWidget extends StatefulWidget {
  BreakNewsWidget({Key key}) : super(key: key);

  @override
  _BreakNewsState createState() => _BreakNewsState();
}

class _BreakNewsState extends State<BreakNewsWidget> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return lebanonBuilder();
  }

  lebanonBuilder() {
    return FutureBuilder(
      future: _apiService.getBreakNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;

          if (content['data']['posts'].toString() == '[]') {
            return Center(
              child: Container(
                width: 400,
                child: Center(
                  child: Text(
                    'لا يوجد اخبار عاجلة',
                    style: TextStyle(
                        fontFamily: "sst-arabic-bold",
                        fontSize: 18,
                        height: 1.7),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: content['data']['posts'].length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FadeAnimation(
                      0.5,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                SFSymbols.flame_fill,
                                color: Color(0xffeb4e54),
                                size: 15,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                  content['data']['posts'][index]['time']
                                      .toString(),
                                  style: TextStyle(
                                      color: Color(0xffeb4e54),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 400,
                            child: Text(
                              content['data']['posts'][index]['title']
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: "sst-arabic-bold",
                                  fontSize: 14,
                                  height: 1.7),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Image.asset('assets/images/loading.gif', width: 200)),
          );
        }
      },
    );
  }
}
