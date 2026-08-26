class ModelListKabkot {
  int? code;
  String? message;
  List<String>? data;

  ModelListKabkot({this.code, this.message, this.data});

  ModelListKabkot.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
