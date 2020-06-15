// import 'package:alroya/Animations/fadeanimation.dart';
// import 'package:alroya/Services/api_service.dart';
// import 'package:flutter/services.dart';
// import 'package:share/share.dart';

// import '../services/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CustomScrollViewTestRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
//     //Material Design 默认的样式风格,我们使用Material作为本路由的根。
//     return Material(
//       child: CustomScrollView(
//         slivers: <Widget>[
//           //AppBar，包含一个导航栏
//           SliverAppBar(
//             pinned: true,
//             expandedHeight: 250.0,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Image.asset(
//                 'assets/images/placeholder_big.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           FutureBuilder(
//               future: ApiService().getdetail(widget.id),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData) {
//                   Map content = snapshot.data;
//                   String imgurl =
//                       ApiService().getImage(content['data']['img'].toString());
//                   return Stack(
//                     children: <Widget>[
//                       Positioned(
//                         top: 0,
//                         left: 0,
//                         right: 0,
//                         height: 300,
//                         child: FadeAnimation(
//                           0.4,
//                           Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: NetworkImage(imgurl)),
//                             ),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Colors.black.withOpacity(0.3),
//                                   Colors.black.withOpacity(0)
//                                 ],
//                               ),
//                             )),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 0,
//                         left: 10,
//                         right: 10,
//                         child: FadeAnimation(
//                           0.5,
//                           Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 InkWell(
//                                   onTap: () {
//                                     Share.share(
//                                         'https://arabcanadanews.ca//post/' +
//                                             widget.id.toString(),
//                                         subject: content['data']['details']
//                                             ['title']);
//                                     HapticFeedback.mediumImpact();
//                                   },
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.white,
//                                     radius: 20,
//                                     child: Icon(
//                                       SFSymbols.square_arrow_up,
//                                       size: 20,
//                                       color: Color(0xff17202c),
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     HapticFeedback.mediumImpact();
//                                     Navigator.pop(context);
//                                   },
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.white,
//                                     radius: 20,
//                                     child: Icon(
//                                       SFSymbols.arrow_left,
//                                       size: 20,
//                                       color: Color(0xff17202c),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 10,
//                         right: 10,
//                         bottom: 0,
//                         height: MediaQuery.of(context).size.height - 310,
//                         child: Container(
//                           width: 400,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(8),
//                               topRight: Radius.circular(8),
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius:
//                                     20.0, // has the effect of softening the shadow
//                                 spreadRadius:
//                                     5.0, // has the effect of extending the shadow
//                                 offset: Offset(
//                                   0.0, // horizontal, move right 10
//                                   2.0, // vertical, move down 10
//                                 ),
//                               )
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   SizedBox(height: 20),
//                                   FadeAnimation(
//                                     0.4,
//                                     Text(
//                                       content['data']['title'],
//                                       style: TextStyle(
//                                           fontFamily: "sst-arabic-bold",
//                                           fontSize: 23,
//                                           height: 1.3),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ),
//                                   SizedBox(height: 20),
//                                   FadeAnimation(
//                                     0.5,
//                                     Text(
//                                       content['data']['published_at'],
//                                       style: TextStyle(
//                                           fontFamily: "sst-roman",
//                                           fontSize: 10,
//                                           height: 1.3),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Directionality(
//                                     textDirection: TextDirection.rtl,
//                                     child: FadeAnimation(
//                                       0.6,
//                                       Html(
//                                           linkStyle: const TextStyle(
//                                             color: Colors.redAccent,
//                                           ),
//                                           data: content['data']['details']
//                                               ['body'],
//                                           onLinkTap: (url) {
//                                             print("Opening $url...");
//                                             _launchURL(url);
//                                           },
//                                           customTextAlign: (_) =>
//                                               TextAlign.right),
//                                     ),
//                                   ),
//                                   Footer(),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//                 } else {
//                   return Container(
//                     height: MediaQuery.of(context).size.height,
//                     child: Center(
//                         child: Image.asset('assets/images/loading.gif',
//                             width: 200)),
//                   );
//                 }
//               })
//           // SliverPadding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   sliver: new SliverGrid( //Grid
//           //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//           //       crossAxisCount: 2, //Grid按两列显示
//           //       mainAxisSpacing: 10.0,
//           //       crossAxisSpacing: 10.0,
//           //       childAspectRatio: 4.0,
//           //     ),
//           //     delegate: new SliverChildBuilderDelegate(
//           //           (BuildContext context, int index) {
//           //         //创建子widget
//           //         return new Container(
//           //           alignment: Alignment.center,
//           //           color: Colors.cyan[100 * (index % 9)],
//           //           child: new Text('grid item $index'),
//           //         );
//           //       },
//           //       childCount: 20,
//           //     ),
//           //   ),
//           // ),
//           // //List
//           // new SliverFixedExtentList(
//           //   itemExtent: 50.0,
//           //   delegate: new SliverChildBuilderDelegate(
//           //           (BuildContext context, int index) {
//           //         //创建列表项
//           //         return new Container(
//           //           alignment: Alignment.center,
//           //           color: Colors.lightBlue[100 * (index % 9)],
//           //           child: new Text('list item $index'),
//           //         );
//           //       },
//           //       childCount: 50 //50个列表项
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
