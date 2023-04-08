

import 'dart:convert';

import 'package:casadealerapp/modal_class/login_model.dart';
import 'package:casadealerapp/screens/forget_password.dart';
import 'package:casadealerapp/screens/loginsuccess.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/register.dart';
import 'package:casadealerapp/widget/CONST.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/login2.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/get_started_logo.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.07,
                // width: MediaQuery.of(context).size.width * 2,
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
                          // suffixIcon: Icon(
                          //   Icons.person_outline,
                          //   color: Color(0xfff9696c1),
                          //   size: 3.5.h,
                          // ),
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
                                    : Icons.visibility_off,
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
                      // color: Color(0xfff333389),
                      // padding:
                      //     EdgeInsets.only(left: 35, right: 40, bottom: 10, top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("Validate");
                            loginApi();
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => products_1()));
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

  loginApi() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {};

      data['loginEmail'] = _email.text.trim().toString();
      data['loginPassword'] = _password.text.trim().toString();
      data['action'] = 'login';

      checkInternet().then((internet) async {
        if (internet) {
          Authprovider().loginapi(data).then((Response response) async {
            SharedPreferences _sharedpreferences =
                await SharedPreferences.getInstance();
            print(response.statusCode);
            userData = usermodal.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && userData!.status == "success" ) {
              if(userData?.logindata?.acIa == "1"){
                SaveDataLocal.saveLogInData(userData!);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => products_1()));
                // Fluttertoast.showToast(
                //   msg: "Logged In Successfully",
                //   textColor: Colors.white,
                //   toastLength: Toast.LENGTH_SHORT,
                //   timeInSecForIosWeb: 1,
                //   gravity: ToastGravity.BOTTOM,
                //   backgroundColor: Colors.indigo,
                // );

                if (kDebugMode) {}

                _email.text = "";
                _password.text = "";
              }
              else{
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Colors.transparent,
                      child: Container(
                        height: 30.h,
                        width: 80.w,
                        // padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [

                            Container(
                              height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              // borderRadius: BorderRadius.circular(16),
                              padding: EdgeInsets.all(3.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          // Icon(Icons.edit,color:Colors.white ,),
                                          Text(
                                            "",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                  Form(

                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "Your registration is pending approval",
                                          style: TextStyle(

                                              fontSize: 12.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins"),
                                        ),
                                        Text(
                                          "you will be notified soon",
                                          style: TextStyle(

                                              fontSize: 12.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins"),
                                        ),

                                        // TextFormField(
                                        //   controller: _title,
                                        //   keyboardType: TextInputType.text,
                                        //   validator: (value) {
                                        //     if (value!.isEmpty) {
                                        //       return 'Please enter your subject';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   decoration: InputDecoration(
                                        //     contentPadding: EdgeInsets.all(2.0),
                                        //     prefixIcon: Icon(Icons.add,color: Colors.grey,),
                                        //     filled: true,
                                        //     hintText: "Subject",
                                        //     hintStyle: textstyle,
                                        //     fillColor: Colors.white,
                                        //     enabledBorder: OutlineInputBorder(
                                        //         borderSide: BorderSide.none,
                                        //         borderRadius: BorderRadius.circular(30.0)),
                                        //     focusedBorder: OutlineInputBorder(
                                        //         borderSide: BorderSide.none,
                                        //         borderRadius: BorderRadius.circular(30.0)),
                                        //   ),
                                        // ),

                                        Padding(
                                          padding: EdgeInsets.all(3.w),
                                          child: Container(
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: Color(0xff333389),
                                              borderRadius: BorderRadius.circular(30.0),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Color(0xff333389),
                                              //     offset: Offset(0, 10),
                                              //     blurRadius: 10,
                                              //     spreadRadius: -5,
                                              //   ),
                                              // ],
                                              // border: Border.all(color: Colors.white,width: 1.0)
                                            ),
                                            height: 40.0,
                                            child: TextButton(
                                              style: ButtonStyle(
                                                alignment: Alignment.center,
                                                // backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                                padding: MaterialStateProperty.all(
                                                  EdgeInsets.symmetric(vertical: 1.h),
                                                ),
                                                shape:
                                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20.sp),
                                                    )),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();

                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Oky",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  // Icon(
                                                  //   Icon,
                                                  //   color: Colors.grey.shade700,
                                                  // )

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                print("vfvfdg");
              }

            } else {

              // Fluttertoast.showToast(
              //   msg: "Enter A Valid Email Address",
              //   textColor: Colors.white,
              //   toastLength: Toast.LENGTH_SHORT,
              //   timeInSecForIosWeb: 1,
              //   gravity: ToastGravity.BOTTOM,
              //   backgroundColor: Colors.indigo,
              // );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.transparent,
                    child: Container(
                      height: 25.h,
                      width: 80.w,
                      // padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [

                          Container(
                            height: 25.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            // borderRadius: BorderRadius.circular(16),
                            padding: EdgeInsets.all(3.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        // Icon(Icons.edit,color:Colors.white ,),
                                        Text(
                                          "",
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins"),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                                Form(

                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        "Your login is not correct !",
                                        style: TextStyle(

                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),


                                      // TextFormField(
                                      //   controller: _title,
                                      //   keyboardType: TextInputType.text,
                                      //   validator: (value) {
                                      //     if (value!.isEmpty) {
                                      //       return 'Please enter your subject';
                                      //     }
                                      //     return null;
                                      //   },
                                      //   decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.all(2.0),
                                      //     prefixIcon: Icon(Icons.add,color: Colors.grey,),
                                      //     filled: true,
                                      //     hintText: "Subject",
                                      //     hintStyle: textstyle,
                                      //     fillColor: Colors.white,
                                      //     enabledBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide.none,
                                      //         borderRadius: BorderRadius.circular(30.0)),
                                      //     focusedBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide.none,
                                      //         borderRadius: BorderRadius.circular(30.0)),
                                      //   ),
                                      // ),

                                      Padding(
                                        padding: EdgeInsets.all(3.w),
                                        child: Container(
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            color: Color(0xff333389),
                                            borderRadius: BorderRadius.circular(30.0),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Color(0xff333389),
                                            //     offset: Offset(0, 10),
                                            //     blurRadius: 10,
                                            //     spreadRadius: -5,
                                            //   ),
                                            // ],
                                            // border: Border.all(color: Colors.white,width: 1.0)
                                          ),
                                          height: 40.0,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              alignment: Alignment.center,
                                              // backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                              padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(vertical: 1.h),
                                              ),
                                              shape:
                                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.sp),
                                                  )),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();

                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Oky",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                // Icon(
                                                //   Icon,
                                                //   color: Colors.grey.shade700,
                                                // )

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          });
        } else {}
      });
    }
  }
}
