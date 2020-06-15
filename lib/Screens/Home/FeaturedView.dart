import 'package:arab_canada_new/Animations/fadeanimation.dart';
import 'package:arab_canada_new/Services/api_service.dart';
import 'package:flutter/services.dart';

import '../../Screens/details/detailview.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../Tools/globals.dart' as g;

class FeaturedView extends StatefulWidget {
  FeaturedView({Key key}) : super(key: key);

  @override
  _FeaturedViewState createState() => _FeaturedViewState();
}

class _FeaturedViewState extends State<FeaturedView> {
  ApiService _apiService;
  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    // return FeaturedWidget();
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _apiService.getFeatured(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map content = snapshot.data;
                String imageurl = ApiService().getImage(
                    content['data']['featured'][0]['image'].toString());
                return Container(
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
                    height: 390,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.downToUp,
                                child: DetailView(
                                    content['data']['featured'][0]['id'])));
                        HapticFeedback.mediumImpact();
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
                              image: imageurl,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                content['data']['featured'][0]['title'],
                                style: TextStyle(
                                    fontFamily: "sst-arabic-bold",
                                    fontSize: 15,
                                    height: 1.3),
                                textAlign: TextAlign.right,
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 20),
                              child: Text(
                                content['data']['featured'][0]['time'] == null
                                    ? 'غير متوفر'
                                    : content['data']['featured'][0]['time'],
                                style: TextStyle(
                                    fontFamily: "SST-Arabic-Medium",
                                    fontSize: 12,
                                    color: Colors.grey.shade600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              } else {
                //  print(widget.catId);
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child:
                          Image.asset('assets/images/loading.gif', width: 200)),
                );
              }
            }),
        SizedBox(height: 10),
        latestNews(context)
      ],
    );
  }

  latestNews(context) {
    return FutureBuilder(
        future: _apiService.getFeatured(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              height: 535,
              child: ListView.builder(
                physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  String imageurl = ApiService().getImage(content['data']
                          ['featured'][index + 1]['image']
                      .toString());

                  return FadeAnimation(
                    0.6,
                    Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.downToUp,
                                    child: DetailView(content['data']
                                        ['featured'][index + 1]['id'])));
                            HapticFeedback.mediumImpact();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
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
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FadeInImage.assetNetwork(
                                    width: 160,
                                    height: 105,
                                    fit: BoxFit.cover,
                                    placeholder: 'assets/images/loader.gif',
                                    image: imageurl,
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              200,
                                          child: Text(
                                            content['data']['featured']
                                                [index + 1]['title'],
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
                                          content['data']['featured'][index + 1]
                                                      ['time'] ==
                                                  null
                                              ? 'غير متوفر'
                                              : content['data']['featured']
                                                  [index + 1]['time'],
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
                },
              ),
            );
          } else {
            // print(widget.catId);
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child: Image.asset('assets/images/loading.gif', width: 100)),
            );
          }
        });
  }
}
