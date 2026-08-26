class ModelDetailArtikel {
  bool? success;
  String? message;
  Data? data;

  ModelDetailArtikel({this.success, this.message, this.data});

  ModelDetailArtikel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? author;
  String? authorLink;
  String? date;
  String? dateTime;
  List<Categories>? categories;
  String? thumbnail;
  String? contentHtml;
  String? type;

  Data(
      {this.id,
        this.title,
        this.author,
        this.authorLink,
        this.date,
        this.dateTime,
        this.categories,
        this.thumbnail,
        this.contentHtml,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    authorLink = json['author_link'];
    date = json['date'];
    dateTime = json['date_time'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    thumbnail = json['thumbnail'];
    contentHtml = json['content_html'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['author_link'] = this.authorLink;
    data['date'] = this.date;
    data['date_time'] = this.dateTime;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['thumbnail'] = this.thumbnail;
    data['content_html'] = this.contentHtml;
    data['type'] = this.type;
    return data;
  }
}

class Categories {
  String? name;
  String? url;

  Categories({this.name, this.url});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
