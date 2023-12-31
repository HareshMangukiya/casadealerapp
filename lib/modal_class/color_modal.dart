class colorClass {
  String? status;
  List<Data>? data;
  int? checkGender;

  colorClass({this.status, this.data, this.checkGender});

  colorClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    checkGender = json['check_gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['check_gender'] = this.checkGender;
    return data;
  }
}

class Data {
  String? id;
  String? colorName;
  String? colorImage;

  Data({this.id, this.colorName, this.colorImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colorName = json['color_name'];
    colorImage = json['color_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color_name'] = this.colorName;
    data['color_image'] = this.colorImage;
    return data;
  }
}