import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/logoapi.dart';
import 'package:casadealerapp/screens/getstarted.dart';
import 'package:casadealerapp/screens/login.dart';
import 'package:casadealerapp/provider/login_authprovider.dart';
import 'package:casadealerapp/modal_class/login_model.dart';
import 'package:casadealerapp/screens/loginsuccess.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/build_dialog.dart';
import 'package:casadealerapp/widget/shared_preference.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _companyname = TextEditingController();
  TextEditingController _companyname1 = TextEditingController();

  TextEditingController _phone = TextEditingController();
  TextEditingController _phone1 = TextEditingController();

  // TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password1 = TextEditingController();
  TextEditingController _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible1 = false;
  bool _passwordVisible = false;

  String? gender = "male";
  bool? check3 = false;
  var select = "i1";
  usermodal? userData;
  logoapi? logoapp;
  void initState() {
    // TODO: implement initState
    super.initState();
    // view();

    getdata();
  }

  getdata() async {
    await fetchlogo();
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
              SingleChildScrollView(

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(right: 30.h),
                        child: Container(
                          child: Text("Register",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xfff3b3b8e))),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        // alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height: 5.5.h,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your full name";
                            }
                            return null;
                          },
                          controller: _firstname,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(2.h),
                            hintText: 'Full Name',
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
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height: 5.5.h,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your company name";
                            }
                            return null;
                          },
                          controller: _companyname,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(2.h),
                            hintText: 'Company Name',

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
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height:5.5.h,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your company address";
                            }
                            return null;
                          },
                          controller: _companyname1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(2.h),
                            hintText: 'Company Address',

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
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height: 5.5.h,
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
                            hintText: 'Email Address',
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
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height:5.5.h,
                        child: TextFormField(
                          validator: (value) {
                            if (value?.length != 10)
                              return 'Mobile Number must be of 10 digit';
                            else
                              return null;
                          },
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(2.h),
                            hintText: 'Phone No. 1',
                            // suffixIcon: Icon(
                            //   Icons.phone_outlined,
                            //   color: Color(0xfff9696c1),
                            //   size: 3.5.h,
                            // ),
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
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height: 5.5.h,
                        child: TextFormField(

                          controller: _phone1,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(2.h),
                            hintText: 'Phone 2 (optional)',

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
                        height: 20,
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
                        // height: 5.5.h,
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  color: Colors.black,
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(2.h),
                              hintText: 'Create Password'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                        // height: 5.5.h,
                        child: TextFormField(
                          obscureText: !_passwordVisible1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Re-Enter password";
                            }
                            return null;
                          },
                          controller: _password1,
                          decoration: InputDecoration(

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible1 = !_passwordVisible1;
                                  });
                                },
                                icon: Icon(
                                  color: Colors.black,
                                  _passwordVisible1
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(2.h),
                              hintText: 'Re-Enter Password'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.06,

                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              registerApi();
                            }
                          },
                          child: Text(
                            'Register',
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
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 2.h),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => login(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "   Login",
                                  style: TextStyle(
                                      color: Color(0xfff494996), fontSize: 2.h),
                                ))
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  registerApi() async {
    final Map<String, String> data = {};
    data['fullname'] = _firstname.text.trim().toString();
    data['company_name'] = _companyname.text.trim().toString();
    data['mobile_no_one'] = _phone.text.trim().toString();
    data['mobile_no_two'] = _phone1.text.trim().toString();
    data['email_id'] = _email.text.trim().toString();
    data['password'] = _password.text.trim().toString();

    data['confirm_password'] = _password1.text.trim().toString();

    data['action'] = 'signup';

    if (_formKey.currentState!.validate()) {
      checkInternet().then((internet) async {
        if (internet) {
          Authprovider().loginapi(data).then((Response response) async {


            userData = usermodal.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && userData!.status == "success") {

              SaveDataLocal.saveLogInData(userData!);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => loginsuccess()));
              _email.text = "";
              _password.text = "";
            } else {
              buildErrorDialog(context, "", "User already exist");
            }
          });
        } else {}
      });
    }
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
