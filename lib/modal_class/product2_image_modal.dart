class product2Imageclass {
  String? status;
  List<String>? imageData;
  List<ProductData>? productData;

  product2Imageclass({this.status, this.imageData, this.productData});

  product2Imageclass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    imageData = json['image_data']==null?[]:json['image_data'].cast<String>();
    if (json['product_data'] != null) {
      productData = <ProductData>[];
      json['product_data'].forEach((v) {
        productData!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['image_data'] = this.imageData;
    if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? apId;
  String? apName;

  ProductData({this.apId, this.apName});

  ProductData.fromJson(Map<String, dynamic> json) {
    apId = json['ap_id'];
    apName = json['ap_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ap_id'] = this.apId;
    data['ap_name'] = this.apName;
    return data;
  }
}