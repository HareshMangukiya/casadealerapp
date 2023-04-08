class viewBlockOrder {
  String? status;
  List<Data>? data;

  viewBlockOrder({this.status, this.data});

  viewBlockOrder.fromJson(Map<String, dynamic> json) {
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
  String? imageOne;
  String? fullName;
  String? id;
  String? ordNo;
  String? price;
  String? status;

  Data(
      {this.imageOne,
        this.fullName,
        this.id,
        this.ordNo,
        this.price,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    imageOne = json['image_one'];
    fullName = json['full_name'];
    id = json['id'];
    ordNo = json['ord_no'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_one'] = this.imageOne;
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    data['ord_no'] = this.ordNo;
    data['price'] = this.price;
    data['status'] = this.status;
    return data;
  }
}