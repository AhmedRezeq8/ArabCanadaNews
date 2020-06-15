// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';


 HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
    bool status;
    Data data;

    HomePageModel({
        this.status,
        this.data,
    });

    factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    List<Featured> featured;
    Widget1 widget1;
    Latest latest;

    Data({
        this.featured,
        this.widget1,
        this.latest,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        featured: List<Featured>.from(json["featured"].map((x) => Featured.fromJson(x))),
        widget1: Widget1.fromJson(json["widget_1"]),
        latest: Latest.fromJson(json["latest"]),
    );

    Map<String, dynamic> toJson() => {
        "featured": List<dynamic>.from(featured.map((x) => x.toJson())),
        "widget_1": widget1.toJson(),
        "latest": latest.toJson(),
    };
}

class Widget1 {
    int id;
    String title;
    dynamic description;
    dynamic icon;
    List<Featured> posts;

    Widget1({
        this.id,
        this.title,
        this.description,
        this.icon,
        this.posts,
    });

    factory Widget1.fromJson(Map<String, dynamic> json) => Widget1(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
        posts: json["posts"] == null ? null : List<Featured>.from(json["posts"].map((x) => Featured.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "icon": icon,
        "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toJson())),
    };
}

List<Featured> featuredFromJson(String str) {
  final data = json.decode(str);
  return List<Featured>.from(data.map((item) => Featured.fromJson(item)));
}
String featuredToJson(Featured data) => json.encode(data.toJson());

class Featured {
    int id;
    String title;
    dynamic caption;
    String img;
    String description;
    DateTime publishedAt;
    Widget1 category;

    Featured({
        this.id,
        this.title,
        this.caption,
        this.img,
        this.description,
        this.publishedAt,
        this.category,
    });

    factory Featured.fromJson(Map<String, dynamic> json) => Featured(
        id: json["id"],
        title: json["title"],
        caption: json["caption"],
        img: json["img"],
        description: json["description"],
        publishedAt: DateTime.parse(json["published_at"]),
        category: json["category"] == null ? null : Widget1.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "caption": caption,
        "img": img,
        "description": description,
        "published_at": publishedAt.toIso8601String(),
        "category": category == null ? null : category.toJson(),
    };
}

class Latest {
    int currentPage;
    List<Featured> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    String nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    Latest({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Latest.fromJson(Map<String, dynamic> json) => Latest(
        currentPage: json["current_page"],
        data: List<Featured>.from(json["data"].map((x) => Featured.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}
