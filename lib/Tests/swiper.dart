// import 'package:alroya/Screens/details/detailview.dart';

// import '../services/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:page_transition/page_transition.dart';

// class SwiperView extends StatefulWidget {
//   @override
//   _FeaturedState createState() => _FeaturedState();
// }

// class _FeaturedState extends State<SwiperView> {
//   ApiService _apiService;

//   @override
//   void initState() {
//     super.initState();
//     _apiService = ApiService();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return featuredBuilder();
//   }

//   featuredBuilder() {
//     return FutureBuilder(
//       future: _apiService.getFeatured(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           Map content = snapshot.data;

//           return Container(
//             color: Colors.white,
//             height: 370,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               child: Swiper(
//                 itemBuilder: (BuildContext context, int index) {
//                   String imgurl = "https://arabcanadanews.ca//" +
//                       content['data']['featured'][index]['img'].toString();
//                   return InkWell(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           height: 260,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 fit: BoxFit.cover, image: NetworkImage(imgurl)),
//                           ),
//                           child: Container(
//                               decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.bottomCenter,
//                               end: Alignment
//                                   .topCenter, // 10% of the width, so there are ten blinds.
//                               colors: [
//                                 Colors.black.withOpacity(0.7),
//                                 Colors.black.withOpacity(0.1)
//                               ], // whitish to gray
//                             ),
//                           )),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 20),
//                           child: Text(
//                             content['data']['featured'][index]['title']
//                                 .toString(),
//                             style: TextStyle(
//                                 fontFamily: "sst-arabic-bold",
//                                 fontSize: 23,
//                                 height: 1.3),
//                             textAlign: TextAlign.right,
//                             maxLines: 2,
//                           ),
//                         )
//                       ],
//                     ),
//                     onTap: (){
//                       Navigator.push(
//                             context,
//                             PageTransition(
//                                 type: PageTransitionType.downToUp,
//                                 child: DetailView( content['data']['featured'][index]['id'])));

//                     },
//                   );
//                 },
//                 itemCount: 4,
//                 viewportFraction: 1,
//                 scale: 1,
//                 autoplay: true,
//                 pagination: new SwiperPagination(
//                     alignment: Alignment.centerRight,
//                     margin: EdgeInsets.fromLTRB(0, 90, 20, 0),
//                     builder: SwiperPagination.dots),
//               ),
//             ),
//           );
//         } else {
//           return Container(
//             height: 370,
//             color: Colors.grey,
//             child: Center(
//                 child: Image.asset('assets/images/loading.gif',
//                     width: 163.0, height: 67.0),),
//           );
//         }
//       },
//     );
//   }
// }
