class order_detail {
  String? status;
  List<Data>? data;
  OrderData? orderData;

  order_detail({this.status, this.data, this.orderData});

  order_detail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    orderData = json['order_data'] != null
        ? new OrderData.fromJson(json['order_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.orderData != null) {
      data['order_data'] = this.orderData!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? ordId;
  String? productId;
  String? gender;
  String? colourName;
  String? categoryId;
  String? price1;
  String? price2;
  String? xs;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? xxl;
  String? s3xl;
  String? s4xl;
  String? s5xl;
  String? total;
  String? createdTime;

  Data(
      {this.id,
        this.ordId,
        this.productId,
        this.gender,
        this.colourName,
        this.categoryId,
        this.price1,
        this.price2,
        this.xs,
        this.s,
        this.m,
        this.l,
        this.xl,
        this.xxl,
        this.s3xl,
        this.s4xl,
        this.s5xl,
        this.total,
        this.createdTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ordId = json['ord_id'];
    productId = json['product_id'];
    gender = json['gender'];
    colourName = json['colour_name'];
    categoryId = json['category_id'];
    price1 = json['price1'];
    price2 = json['price2'];
    xs = json['xs'];
    s = json['s'];
    m = json['m'];
    l = json['l'];
    xl = json['xl'];
    xxl = json['xxl'];
    s3xl = json['3xl'];
    s4xl = json['4xl'];
    s5xl = json['5xl'];
    total = json['total'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ord_id'] = this.ordId;
    data['product_id'] = this.productId;
    data['gender'] = this.gender;
    data['colour_name'] = this.colourName;
    data['category_id'] = this.categoryId;
    data['price1'] = this.price1;
    data['price2'] = this.price2;
    data['xs'] = this.xs;
    data['s'] = this.s;
    data['m'] = this.m;
    data['l'] = this.l;
    data['xl'] = this.xl;
    data['xxl'] = this.xxl;
    data['3xl'] = this.s3xl;
    data['4xl'] = this.s4xl;
    data['5xl'] = this.s5xl;
    data['total'] = this.total;
    data['created_time'] = this.createdTime;
    return data;
  }
}

class OrderData {
  String? id;
  String? ordNo;
  String? productId;
  String? distributorId;
  String? price;
  String? gstPrice;
  String? status;
  String? createdTime;

  OrderData(
      {this.id,
        this.ordNo,
        this.productId,
        this.distributorId,
        this.price,
        this.gstPrice,
        this.status,
        this.createdTime});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ordNo = json['ord_no'];
    productId = json['product_id'];
    distributorId = json['distributor_id'];
    price = json['price'];
    gstPrice = json['gst_price'];
    status = json['status'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ord_no'] = this.ordNo;
    data['product_id'] = this.productId;
    data['distributor_id'] = this.distributorId;
    data['price'] = this.price;
    data['gst_price'] = this.gstPrice;
    data['status'] = this.status;
    data['created_time'] = this.createdTime;
    return data;
  }
}
