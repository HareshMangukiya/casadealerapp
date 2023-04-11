class logoapi {
  String? status;
  List<Data>? data;

  logoapi({this.status, this.data});

  logoapi.fromJson(Map<String, dynamic> json) {
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
  String? appLogo;
  String? splashScreenImg;
  String? loginScreenBannersOne;
  String? registerScreeneBannersTwo;

  Data(
      {this.appLogo,
        this.splashScreenImg,
        this.loginScreenBannersOne,
        this.registerScreeneBannersTwo});

  Data.fromJson(Map<String, dynamic> json) {
    appLogo = json['app_logo'];
    splashScreenImg = json['splash_screen_img'];
    loginScreenBannersOne = json['login_screen_banners_one'];
    registerScreeneBannersTwo = json['register_screene_banners_two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_logo'] = this.appLogo;
    data['splash_screen_img'] = this.splashScreenImg;
    data['login_screen_banners_one'] = this.loginScreenBannersOne;
    data['register_screene_banners_two'] = this.registerScreeneBannersTwo;
    return data;
  }
}