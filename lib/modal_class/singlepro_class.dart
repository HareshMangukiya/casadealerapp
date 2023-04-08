class color {
  String? status;
  List<String>? coloursdata;
  List<String>? apdId;
  List<Sizes>? sizes;

  color({this.status, this.coloursdata, this.apdId, this.sizes});

  color.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    coloursdata = json['coloursdata'].cast<String>();
    apdId = json['apd_id'].cast<String>();
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['coloursdata'] = this.coloursdata;
    data['apd_id'] = this.apdId;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sizes {
  String? xs;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? xxl;
  String? s3xl;
  String? s4xl;
  String? s5xl;

  Sizes(
      {this.xs,
      this.s,
      this.m,
      this.l,
      this.xl,
      this.xxl,
      this.s3xl,
      this.s4xl,
      this.s5xl});

  Sizes.fromJson(Map<String, dynamic> json) {
    xs = json['xs'];
    s = json['s'];
    m = json['m'];
    l = json['l'];
    xl = json['xl'];
    xxl = json['xxl'];
    s3xl = json['3xl'];
    s4xl = json['4xl'];
    s5xl = json['5xl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xs'] = this.xs;
    data['s'] = this.s;
    data['m'] = this.m;
    data['l'] = this.l;
    data['xl'] = this.xl;
    data['xxl'] = this.xxl;
    data['3xl'] = this.s3xl;
    data['4xl'] = this.s4xl;
    data['5xl'] = this.s5xl;
    return data;
  }
}
