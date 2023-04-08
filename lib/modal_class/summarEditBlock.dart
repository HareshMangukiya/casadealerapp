class summryEditBlockProduct {
  String? status;

  summryEditBlockProduct({this.status});

  summryEditBlockProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
