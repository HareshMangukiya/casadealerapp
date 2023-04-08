class colorDisplayClass {
  String? status;
  List<MumbaiStock>? mumbaiStock;
  List<TripurStock>? tripurStock;
  List<PriceArray>? priceArray;

  colorDisplayClass(
      {this.status, this.mumbaiStock, this.tripurStock, this.priceArray});

  colorDisplayClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['mumbai_stock'] != null) {
      mumbaiStock = <MumbaiStock>[];
      json['mumbai_stock'].forEach((v) {
        mumbaiStock!.add(new MumbaiStock.fromJson(v));
      });
    }
    if (json['Tripur_stock'] != null) {
      tripurStock = <TripurStock>[];
      json['Tripur_stock'].forEach((v) {
        tripurStock!.add(new TripurStock.fromJson(v));
      });
    }
    if (json['price_array'] != null) {
      priceArray = <PriceArray>[];
      json['price_array'].forEach((v) {
        priceArray!.add(new PriceArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.mumbaiStock != null) {
      data['mumbai_stock'] = this.mumbaiStock!.map((v) => v.toJson()).toList();
    }
    if (this.tripurStock != null) {
      data['Tripur_stock'] = this.tripurStock!.map((v) => v.toJson()).toList();
    }
    if (this.priceArray != null) {
      data['price_array'] = this.priceArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MumbaiStock {
  String? xs;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? xxl;
  String? s3xl;
  String? s4xl;
  String? s5xl;
  String? mApId;
  String? mApdId;
  String? sizeChart;
  String? videoSpecification;
  String? catalogue;
  List<String>? menImageArray;

  MumbaiStock(
      {this.xs,
        this.s,
        this.m,
        this.l,
        this.xl,
        this.xxl,
        this.s3xl,
        this.s4xl,
        this.s5xl,
        this.mApId,
        this.mApdId,
        this.sizeChart,
        this.videoSpecification,
        this.catalogue,
        this.menImageArray});

  MumbaiStock.fromJson(Map<String, dynamic> json) {
    xs = json['xs'];
    s = json['s'];
    m = json['m'];
    l = json['l'];
    xl = json['xl'];
    xxl = json['xxl'];
    s3xl = json['3xl'];
    s4xl = json['4xl'];
    s5xl = json['5xl'];
    mApId = json['m_ap_id'];
    mApdId = json['m_apd_id'];
    sizeChart = json['size_chart'];
    videoSpecification = json['video_specification'];
    catalogue = json['catalogue'];
    menImageArray = json['Men_image_array']!=null ?  json['Men_image_array'].cast<String>() : [];
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
    data['m_ap_id'] = this.mApId;
    data['m_apd_id'] = this.mApdId;
    data['size_chart'] = this.sizeChart;
    data['video_specification'] = this.videoSpecification;
    data['catalogue'] = this.catalogue;
    data['Men_image_array'] = this.menImageArray;
    return data;
  }
}

class TripurStock {
  String? xs;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? xxl;
  String? s3xl;
  String? s4xl;
  String? s5xl;
  String? tApId;
  String? tApdId;
  String? sizeChart;
  String? videoSpecification;
  String? catalogue;
  List<String>? menImageArray;

  TripurStock(
      {this.xs,
        this.s,
        this.m,
        this.l,
        this.xl,
        this.xxl,
        this.s3xl,
        this.s4xl,
        this.s5xl,
        this.tApId,
        this.tApdId,
        this.sizeChart,
        this.videoSpecification,
        this.catalogue,
        this.menImageArray});

  TripurStock.fromJson(Map<String, dynamic> json) {
    xs = json['xs'];
    s = json['s'];
    m = json['m'];
    l = json['l'];
    xl = json['xl'];
    xxl = json['xxl'];
    s3xl = json['3xl'];
    s4xl = json['4xl'];
    s5xl = json['5xl'];
    tApId = json['t_ap_id'];
    tApdId = json['t_apd_id'];
    sizeChart = json['size_chart'];
    videoSpecification = json['video_specification'];
    catalogue = json['catalogue'];
    menImageArray =json['Men_image_array']!=null ?  json['Men_image_array'].cast<String>() : [];
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
    data['t_ap_id'] = this.tApId;
    data['t_apd_id'] = this.tApdId;
    data['size_chart'] = this.sizeChart;
    data['video_specification'] = this.videoSpecification;
    data['catalogue'] = this.catalogue;
    data['Men_image_array'] = this.menImageArray;
    return data;
  }
}

class PriceArray {
  int? minPrice;
  int? maxPrice;

  PriceArray({this.minPrice, this.maxPrice});

  PriceArray.fromJson(Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    return data;
  }
}