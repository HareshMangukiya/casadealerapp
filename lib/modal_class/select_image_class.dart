class selectColorImageClass {
  String? status;
  List<String>? imageData;

  selectColorImageClass({this.status, this.imageData});

  selectColorImageClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
   imageData = (json['image_data'] == null ) ? []:json['image_data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['image_data'] = this.imageData;
    return data;
  }
}