class allcategorydisplay {
  String? status;
  List<Data>? data;

  allcategorydisplay({this.status, this.data});

  allcategorydisplay.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? categoryName;
  String? categoryImg;

  Data({this.id, this.categoryName, this.categoryImg});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    return data;
  }
}