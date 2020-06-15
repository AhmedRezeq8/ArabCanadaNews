import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class VideoPlay extends StatefulWidget {
  const VideoPlay({Key key, this.title, this.description, this.path, this.type})
      : super(key: key);

  final String description;
  final  String path;
  final String title;
  final String type;

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {

var embad;
var link;
var facebook;
var video;

@override
  void initState() {
    HapticFeedback.mediumImpact();
    super.initState();
 RegExp regExp = new RegExp(r'.*(?:(?:youtu\.be\/|youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
    caseSensitive: false,
    multiLine: false,
  );

  
    link = widget.path;
    facebook = '<iframe src="https://www.facebook.com/plugins/post.php?href=$link"></iframe>';


    print(' $embad');

    print('type:' + widget.type);
    print('path:' + widget.path);

    print('<iframe src="https://www.facebook.com/plugins/post.php?href=$link&height=50" height="50" ></iframe>');



    switch (widget.type) {
      case 'youtube':
       final match = regExp.firstMatch(widget.path).group(1); 
   

    embad = 'https://www.youtube.com/embed/' + match;
        video = '<iframe width="560" height="315" src="$embad" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>';
        break;
      case 'file':
        video = facebook;
        break;  
      default:
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Color(0xffeef4f8),
      appBar: AppBar(
        title: Text('الفيديو'),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,height: 1.3)),
            ),
            HtmlWidget(
           video,
              webView: true,
              webViewJs: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.description,style: TextStyle(fontSize: 17),textAlign: TextAlign.right,),
            ),
          ],
        ),
      ),
    );
  }
}

