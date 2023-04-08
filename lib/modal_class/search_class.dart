class search {
  String? status;
  List<Data>? data;

  search({this.status, this.data});

  search.fromJson(Map<String, dynamic> json) {
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
  String? prodId;
  String? prodName;
  String? color;
  String? prodImgDefault;
  String? prodImgMen;
  String? prodImgWomen;
  int? minPrice;
  int? maxPrice;

  Data(
      {this.prodId,
        this.prodName,
        this.color,
        this.prodImgDefault,
        this.prodImgMen,
        this.prodImgWomen,
        this.minPrice,
        this.maxPrice});

  Data.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    prodName = json['prod_name'];
    color = json['color'];
    prodImgDefault = json['prod_img_default'];
    prodImgMen = json['prod_img_men'];
    prodImgWomen = json['prod_img_women'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_id'] = this.prodId;
    data['prod_name'] = this.prodName;
    data['color'] = this.color;
    data['prod_img_default'] = this.prodImgDefault;
    data['prod_img_men'] = this.prodImgMen;
    data['prod_img_women'] = this.prodImgWomen;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    return data;
  }
}