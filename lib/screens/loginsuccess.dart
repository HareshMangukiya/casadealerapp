import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/logoapi.dart';
import 'package:casadealerapp/provider/login_authprovider.dart';
import 'package:casadealerapp/screens/getstarted.dart';
import 'package:casadealerapp/screens/login.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class loginsuccess extends StatefulWidget {
  const loginsuccess({Key? key}) : super(key: key);

  @override
  State<loginsuccess> createState() => _loginsuccessState();
}
class _loginsuccessState extends State<loginsuccess> {
  logoapi? logoapp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchlogo();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xfffFFFFFF),
      body: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Container(
              alignment: Alignment.center,
              child:CachedNetworkImage(
                height: MediaQuery.of(context).size.height * 0.5,
                imageUrl:logoapp?.data?[0].loginScreenBannersOne ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset(
                      'assets/get_started2.png',
                      fit: BoxFit.cover,
                      // height: MediaQuery.of(context).size.height * 1,
                      // width: MediaQuery.of(context).size.width * 2,
                    ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              alignment: Alignment.topCenter,
              child:CachedNetworkImage(
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.07,
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
            SizedBox(
              height: 3.h,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Congratulations!",
                    style:
                        TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Your registration is pending approval",
                    style: TextStyle(
                        color: Color(0xff6e6e6e), fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "you will be notified soon",
                    style: TextStyle(
                        color: Color(0xff6e6e6e), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              // color: Color(0xfff333389),
              // padding:
              //     EdgeInsets.only(left: 35, right: 40, bottom: 10, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xfff333389),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Back to Login',
                      style: TextStyle(fontSize: 2.h),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    ));
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
