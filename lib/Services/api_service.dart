import 'dart:convert';

import 'package:arab_canada_new/model/contactUs.dart';
import 'package:http/http.dart' as http;

import '../Tools/globals.dart' as g;

class ApiService {
// general future

  Future<Map> getData() async {
    String myUrl = g.baseUrl + '/home';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

// end

  Future<Map> getFeatured() async {
    String myUrl = g.baseUrl + '/home';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getBreakNews() async {
    String myUrl = g.baseUrl + '/breaking';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getdetail(int id) async {
    String myUrl = g.baseUrl + '/post/$id';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getWidget_1() async {
    String myUrl = g.baseUrl + '/home';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getCats() async {
    String myUrl = g.baseUrl + '/nav';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getPosts(int catId, int page) async {
    String myUrl;

    myUrl = g.baseUrl + '/category/$catId?page=$page';

    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      String pagess = 'get data from $page';
      print(pagess);
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getLatest(int page) async {
    String myUrl = g.baseUrl + '/latest?page=$page';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      String pagess = 'get data from $page';
      print(pagess);
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getVideos(int pageId) async {
    String myUrl = g.baseUrl + '/videos?page=$pageId';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getOP(int pageId) async {
    String myUrl = g.baseUrl + '/category/2?page=$pageId';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<bool> contactUs(ContactUs body) async {
    final response = await http.post(
      g.baseUrl + "/contact",
      headers: {"content-type": "application/json"},
      body: userToJson(body),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  String userToJson(ContactUs data) => json.encode(data.toJson());

  // return imge url

  String getImage(String img) {
    return "https://arabcanadanews.ca/" + img;
  }
}
