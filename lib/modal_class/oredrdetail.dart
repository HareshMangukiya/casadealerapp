class orderdetail {
  String? status;
  List<ProductData>? productData;

  orderdetail({this.status, this.productData});

  orderdetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? productName;
  String? colorName;
  String? warehouseName;
  String? gender;
  String? apId;
  String? apdId;
  String? xs;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? xxl;
  String? s3xl;
  String? s4xl;
  String? s5xl;
  String? minPrice;
  String? maxPrice;

  ProductData(
      {this.productName,
        this.colorName,
        this.warehouseName,
        this.gender,
        this.apId,
        this.apdId,
        this.xs,
        this.s,
        this.m,
        this.l,
        this.xl,
        this.xxl,
        this.s3xl,
        this.s4xl,
        this.s5xl,
        this.minPrice,
        this.maxPrice});

  ProductData.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    colorName = json['color_name'];
    warehouseName = json['warehouse_name'];
    gender = json['gender'];
    apId = json['ap_id'];
    apdId = json['apd_id'];
    xs = json['xs'];
    s = json['s'];
    m = json['m'];
    l = json['l'];
    xl = json['xl'];
    xxl = json['xxl'];
    s3xl = json['3xl'];
    s4xl = json['4xl'];
    s5xl = json['5xl'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['color_name'] = this.colorName;
    data['warehouse_name'] = this.warehouseName;
    data['gender'] = this.gender;
    data['ap_id'] = this.apId;
    data['apd_id'] = this.apdId;
    data['xs'] = this.xs;
    data['s'] = this.s;
    data['m'] = this.m;
    data['l'] = this.l;
    data['xl'] = this.xl;
    data['xxl'] = this.xxl;
    data['3xl'] = this.s3xl;
    data['4xl'] = this.s4xl;
    data['5xl'] = this.s5xl;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    return data;
  }
}