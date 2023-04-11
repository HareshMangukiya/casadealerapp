class ViewCart {
  String? status;
  List<DataProduct>? dataProduct;
  int? addToCartNumber;
  ViewCart({this.status, this.dataProduct});

  ViewCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data_product'] != null) {
      dataProduct = <DataProduct>[];
      json['data_product'].forEach((v) {
        dataProduct!.add(new DataProduct.fromJson(v));
      });
    }
    addToCartNumber = json['add_to_cart_number'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.dataProduct != null) {
      data['data_product'] = this.dataProduct!.map((v) => v.toJson()).toList();
    }
    data['add_to_cart_number'] = this.addToCartNumber;
    return data;
  }
}

class DataProduct {
  String? colorName;
  String? productName;
  String? gender;
  List<MumbaiStock>? mumbaiStock;
  List<TirupurStock>? tirupurStock;

  DataProduct(
      {this.colorName,
        this.productName,
        this.gender,
        this.mumbaiStock,
        this.tirupurStock});

  DataProduct.fromJson(Map<String, dynamic> json) {
    colorName = json['color_name'];
    productName = json['product_name'];
    gender = json['gender'];
    if (json['mumbai_stock'] != null) {
      mumbaiStock = <MumbaiStock>[];
      json['mumbai_stock'].forEach((v) {
        mumbaiStock!.add(new MumbaiStock.fromJson(v));
      });
    }
    if (json['tirupur_stock'] != null) {
      tirupurStock = <TirupurStock>[];
      json['tirupur_stock'].forEach((v) {
        tirupurStock!.add(new TirupurStock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_name'] = this.colorName;
    data['product_name'] = this.productName;
    data['gender'] = this.gender;
    if (this.mumbaiStock != null) {
      data['mumbai_stock'] = this.mumbaiStock!.map((v) => v.toJson()).toList();
    }
    if (this.tirupurStock != null) {
      data['tirupur_stock'] =
          this.tirupurStock!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MumbaiStock {
  String? xsBlock;
  String? sBlock;
  String? mBlock;
  String? lBlock;
  String? xlBlock;
  String? xxlBlock;
  String? s3xlBlock;
  String? s4xlBlock;
  String? s5xlBlock;
  List<Price>? price;
  String? mApId;
  String? mApdId;

  MumbaiStock(
      {this.xsBlock,
        this.sBlock,
        this.mBlock,
        this.lBlock,
        this.xlBlock,
        this.xxlBlock,
        this.s3xlBlock,
        this.s4xlBlock,
        this.s5xlBlock,
        this.price,
        this.mApId,
        this.mApdId});

  MumbaiStock.fromJson(Map<String, dynamic> json) {
    xsBlock = json['xs_block'];
    sBlock = json['s_block'];
    mBlock = json['m_block'];
    lBlock = json['l_block'];
    xlBlock = json['xl_block'];
    xxlBlock = json['xxl_block'];
    s3xlBlock = json['3xl_block'];
    s4xlBlock = json['4xl_block'];
    s5xlBlock = json['5xl_block'];
    if (json['price'] != null) {
      price = <Price>[];
      json['price'].forEach((v) {
        price!.add(new Price.fromJson(v));
      });
    }
    mApId = json['m_ap_id'];
    mApdId = json['m_apd_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xs_block'] = this.xsBlock;
    data['s_block'] = this.sBlock;
    data['m_block'] = this.mBlock;
    data['l_block'] = this.lBlock;
    data['xl_block'] = this.xlBlock;
    data['xxl_block'] = this.xxlBlock;
    data['3xl_block'] = this.s3xlBlock;
    data['4xl_block'] = this.s4xlBlock;
    data['5xl_block'] = this.s5xlBlock;
    if (this.price != null) {
      data['price'] = this.price!.map((v) => v.toJson()).toList();
    }
    data['m_ap_id'] = this.mApId;
    data['m_apd_id'] = this.mApdId;
    return data;
  }
}

class Price {
  int? minPrice;
  int? maxPrice;

  Price({this.minPrice, this.maxPrice});

  Price.fromJson(Map<String, dynamic> json) {
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

class TirupurStock {
  String? xsBlock;
  String? sBlock;
  String? mBlock;
  String? lBlock;
  String? xlBlock;
  String? xxlBlock;
  String? s3xlBlock;
  String? s4xlBlock;
  String? s5xlBlock;
  List<Price>? price;
  String? tApId;
  String? tApdId;

  TirupurStock(
      {this.xsBlock,
        this.sBlock,
        this.mBlock,
        this.lBlock,
        this.xlBlock,
        this.xxlBlock,
        this.s3xlBlock,
        this.s4xlBlock,
        this.s5xlBlock,
        this.price,
        this.tApId,
        this.tApdId});

  TirupurStock.fromJson(Map<String, dynamic> json) {
    xsBlock = json['xs_block'];
    sBlock = json['s_block'];
    mBlock = json['m_block'];
    lBlock = json['l_block'];
    xlBlock = json['xl_block'];
    xxlBlock = json['xxl_block'];
    s3xlBlock = json['3xl_block'];
    s4xlBlock = json['4xl_block'];
    s5xlBlock = json['5xl_block'];
    if (json['price'] != null) {
      price = <Price>[];
      json['price'].forEach((v) {
        price!.add(new Price.fromJson(v));
      });
    }
    tApId = json['t_ap_id'];
    tApdId = json['t_apd_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xs_block'] = this.xsBlock;
    data['s_block'] = this.sBlock;
    data['m_block'] = this.mBlock;
    data['l_block'] = this.lBlock;
    data['xl_block'] = this.xlBlock;
    data['xxl_block'] = this.xxlBlock;
    data['3xl_block'] = this.s3xlBlock;
    data['4xl_block'] = this.s4xlBlock;
    data['5xl_block'] = this.s5xlBlock;
    if (this.price != null) {
      data['price'] = this.price!.map((v) => v.toJson()).toList();
    }
    data['t_ap_id'] = this.tApId;
    data['t_apd_id'] = this.tApdId;
    return data;
  }
}