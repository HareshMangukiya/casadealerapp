class convertblockorder {
  String? status;
  String? msg;
  String? msgTwo;

  convertblockorder({this.status, this.msg, this.msgTwo});

  convertblockorder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    msgTwo = json['msg_two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['msg_two'] = this.msgTwo;
    return data;
  }
}