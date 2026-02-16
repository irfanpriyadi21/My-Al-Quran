class ModelListArtikel {
  String? id;
  String? date;
  String? dateTime;
  String? thumbnail;
  String? title;
  String? url;
  String? type;
  List<Categories>? categories;

  ModelListArtikel(
      {this.id,
        this.date,
        this.dateTime,
        this.thumbnail,
        this.title,
        this.url,
        this.type,
        this.categories});

  ModelListArtikel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateTime = json['date_time'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    url = json['url'];
    type = json['type'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_time'] = this.dateTime;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['url'] = this.url;
    data['type'] = this.type;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
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
