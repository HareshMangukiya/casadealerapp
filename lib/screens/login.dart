

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/login_model.dart';
import 'package:casadealerapp/modal_class/logoapi.dart';
import 'package:casadealerapp/screens/forget_password.dart';
import 'package:casadealerapp/screens/loginsuccess.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/register.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/build_dialog.dart';
import 'package:casadealerapp/widget/shared_preference.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


import '../provider/login_authprovider.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}
class _loginState extends State<login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
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
        backgroundColor: Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.topCenter,
              child:
              CachedNetworkImage(
              width:MediaQuery.of(context).size.width,
                height:44.h,
                fit: BoxFit.cover,
                imageUrl:logoapp?.data?[0].loginScreenBannersOne ?? "",
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset(
                      'assets/get_started2.png',
                      fit: BoxFit.cover,
                      width:MediaQuery.of(context).size.width,
                      height:44.h,
                    ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              alignment: Alignment.topCenter,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.07,

                imageUrl:logoapp?.data?[0].appLogo ?? "",
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset(
                      'assets/get_started_logo.png',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: MediaQuery.of(context).size.width * 2,
                    ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 36.h, top: 1.h),
                      child: Container(
                        // alignment: Alignment.centerLeft,
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xfff3b3b8e))),
                      ),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: TextFormField(
                        validator: (value) {
                          String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                              "\\@" +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                              "(" +
                              "\\." +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                              ")+";
                          //Convert string p to a RegE  x
                          RegExp regExp = RegExp(p);

                          if (value!.isEmpty) {
                            return 'Please enter Your Email';
                          } else {
                            //If email address matches pattern
                            if (regExp.hasMatch(value)) {
                              return null;
                            } else {
                              //If it doesn't match
                              return 'Email is not valid';
                            }
                          }
                        },
                        controller: _email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(2.h),
                          hintText: 'Phone Number or Email',
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfffFBFBFB),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfffFBFBFB),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        controller: _password,
                        decoration: InputDecoration(
                          //  prefixIcon: Icon(Icons.login),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,color:Colors.black
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(2.h),
                            hintText: 'Password'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.h, top: 2.5.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => forgetpassword(

                              )));
                        },
                        child: Container(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xfffdd2a45),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            loginApi();
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 2.h),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfff333389),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New Here?",
                            style: TextStyle(fontSize: 2.h),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => register()));
                              },
                              child: Text(
                                "   Register",
                                style: TextStyle(
                                    color: Color(0xfff494996), fontSize: 2.h),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ]),
            ),
          ]),
        ),
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
  loginApi() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {};
      data['loginEmail'] = _email.text.trim().toString();
      data['loginPassword'] = _password.text.trim().toString();
      data['action'] = 'login';

      checkInternet().then((internet) async {
        if (internet) {
          Authprovider().loginapi(data).then((Response response) async {
            userData = usermodal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && userData!.status == "success" ) {
              if(userData?.logindata?.acIa == "1"){
                SaveDataLocal.saveLogInData(userData!);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => products_1()));
                _email.text = "";
                _password.text = "";
              }
              else{
                buildErrorDialog(context, "", ( userData?.msgApproval).toString());
              }
            } else {
              buildErrorDialog(context, "", "Your login is not correct !" );
            }
          });
        } else {}
      });
    }
  }
}
