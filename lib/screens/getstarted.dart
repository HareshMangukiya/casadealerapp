
import 'dart:async';
import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/logoapi.dart';
import 'package:casadealerapp/provider/login_authprovider.dart';
import 'package:casadealerapp/screens/login.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/shared_preference.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
class get_started extends StatefulWidget {
  const get_started({Key? key}) : super(key: key);

  @override
  State<get_started> createState() => _get_startedState();
}
class _get_startedState extends State<get_started> {
  logoapi? logoapp;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchlogo();
    getdata();
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      userData == null
          ? Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => login(),
      ))
          : Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => products_1(),
      ));

    });
  }
  getdata() async {
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Stack(children: [
          Column(
            children: [
              Container(
                height: 70.h,
                alignment: Alignment.center,
                child:CachedNetworkImage(
                  height: 70.h,
                  fit: BoxFit.fill,
                  imageUrl:logoapp?.data?[0].splashScreenImg ?? "",
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset(
                        'assets/get_started2.png',
                        fit: BoxFit.fill,
                      ),
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                height: 12.h,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  height: 12.h,
                  fit: BoxFit.contain,
                  imageUrl:logoapp?.data?[0].appLogo ?? "",
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset(
                        'assets/get_started_logo.png',
                        fit: BoxFit.contain,
                        // height: MediaQuery.of(context).size.height * 1,
                        // width: MediaQuery.of(context).size.width * 2,
                      ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
  fetchlogo() async {
    final Map<String, String> data = {};
    data['action'] = 'banner_logo_app_change';
    checkInternet().then((internet) async {
      if (internet) {
        Authprovider().logo(data).then((Response response) async {
          logoapp = logoapi.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              logoapp?.status == "success") {
          }
          else {
          }
        });
      } else {
      }
    });
  }
}
