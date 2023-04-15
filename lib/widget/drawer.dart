import 'dart:convert';

import 'package:casadealerapp/modal_class/profileV_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/block_order.dart';
import 'package:casadealerapp/screens/login.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/profile_view.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:casadealerapp/widget/shared_preference.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class drawer extends StatefulWidget {
  final BuildContext context;
  const drawer(this.context, {Key? key}) : super(key: key);
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  viewProfile? viewP;
  List<bool> index = [false, false, false, false, false, false, false, false];
  // ViewModel? viewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // view();
    viewProapi();
    index = [false, false, false, false, false, false, false, false];

    getdata();
  }
  bool isLoading = true;

  getdata() async {
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthDrawer = MediaQuery.of(context).size.width * 0.75;
    return Drawer(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: widthDrawer,
              child: ListView(
                children: [
                  Container(
                      height: 13.h,
                      padding: EdgeInsets.all(5.w),
                      width: widthDrawer,
                      // color: Colors.black.withOpacity(0.3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(.0)),

                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 7.w,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/profile.jpg',
                                    width: 13.w,
                                    height: 13.w,
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    'Hi ' + (viewP?.data?.fullName).toString(),
                                        // (userData?.logindata?.fullName)
                                        //     .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                      (viewP?.data?.phoneOne).toString(),
                                      // userData?.logindata?.phoneOne ?? "",
                                      style: TextStyle(
                                          color: Color(0xff333389),
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: ,
                          // ),
                          Icon(
                            Icons.settings_outlined,
                            // color: Color(0xffb4776e6),
                            color:
                                index[1] ? Color(0xff6161a3) : Color(0xff6161a3),
                            size: 3.h,
                          ),
                        ],
                      )),
                  Divider(
                    color: Color(0xffbd6d6e7),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.w),
                    child: Column(
                      children: [
                        Container(
                          color: index[0]
                              ? Color(0xffb4776e6).withOpacity(0.2)
                              : Colors.transparent,
                          child: ListTile(
                            leading: Stack(
                              children: [
                                Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Container(
                                    height: 25.0,
                                    width:25.0,
                                        decoration: BoxDecoration(
                                          color:Color(0xffbefeff6),
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                  ),
                                ),
                                  Icon(Icons.shopping_bag_outlined,
                                      color: index[0]
                                          ? Color(0xffb4776e6)
                                          : Color(0xff6161a3)),
                              ],
                            ),
                            title: Text(
                              'Home',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => products_1()));
                            },
                          ),
                        ),
                        Divider(color: Colors.grey.shade100,),
                        Container(
                          color: index[1]
                              ? Color(0xffb4776e6).withOpacity(0.2)
                              : Colors.transparent,
                          child: ListTile(

                            leading: Stack(
                              children: [
                                Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Container(
                                    height: 25.0,
                                    width:25.0,
                                    decoration: BoxDecoration(
                                        color:Color(0xffbefeff6),
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),
                                  ),
                                ),
                                Icon(Icons.person,

                                    color: index[1]
                                        ? Color(0xffb4776e6)
                                        : Color(0xff6161a3)),
                              ],
                            ),
                            title: Text(
                              'Profile',
                              style: TextStyle(

                                  color: index[1]
                                      ? Color(0xffb4776e6)
                                      : Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profileView()));
                            },
                          ),
                        ),
                        Divider(color: Colors.grey.shade100,),

                        Container(
                          color: index[2]
                              ? Color(0xffb4776e6).withOpacity(0.2)
                              : Colors.transparent,
                          child: ListTile(

                            leading: Stack(
                              children: [
                                Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Container(
                                    height: 25.0,
                                    width:25.0,
                                    decoration: BoxDecoration(
                                        color:Color(0xffbefeff6),
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.library_books,

                                  color: index[2]
                                      ? Color(0xffb4776e6)
                                      : Color(0xff6161a3),
                                ),
                              ],
                            ),
                            title: Text(
                              'Order History',
                              style: TextStyle(

                                  color: index[2]
                                      ? Color(0xffb4776e6)
                                      : Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {

                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => your_order()));
                            },
                          ),
                        ),
                        Divider(color: Colors.grey.shade100,),
                        Container(
                          color: index[3]
                              ? Color(0xffb4776e6).withOpacity(0.2)
                              : Colors.transparent,
                          child: ListTile(

                            leading: Stack(
                              children: [
                                Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Container(
                                    height: 25.0,
                                    width:25.0,
                                    decoration: BoxDecoration(
                                        color:Color(0xffbefeff6),
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.check_box_outline_blank,
                                  color: index[3]
                                      ? Color(0xffb4776e6)
                                      : Color(0xff6161a3),
                                ),
                              ],
                            ),
                            title: Text(
                              'Blocked Order',
                              style: TextStyle(

                                  color: index[3]
                                      ? Color(0xffb4776e6)
                                      : Colors.black,
                                  fontSize: 12.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {

                                Navigator.of(context).pop();

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            your_block_order()));
                            },
                          ),
                        ),
                        Divider(color: Colors.grey.shade100,),

                        Container(
                          color: index[4]
                              ? Color(0xffb4776e6).withOpacity(0.2)
                              : Colors.transparent,
                          child: ListTile(
                            leading: Stack(
                              children: [
                                Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Container(
                                    height: 25.0,
                                    width:25.0,
                                    decoration: BoxDecoration(
                                        color:Color(0xffbefeff6),
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.headphones_outlined,

                                  color: index[4]
                                      ? Color(0xffb4776e6)
                                      : Color(0xff6161a3),
                                ),
                              ],
                            ),
                            title: Text(
                              'Help & Support',
                              style: TextStyle(
                                  color: index[4]
                                      ? Color(0xffb4776e6)
                                      : Colors.black,
                                  fontSize: 12.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              setState(() {
                                Navigator.of(context).pop();

                                index[4] = !index[4];
                              });

                            },
                          ),
                        ),
                        Divider(color: Colors.grey.shade100,),
                        SizedBox(
                          height: 40.h,
                        ),
                        Container(
                          color: index[5]
                              ? Color(0xffb4776e6).withOpacity(0.2)
                              : Colors.transparent,
                          child: ListTile(

                            leading: Stack(
                              children: [
                                Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Container(
                                    height: 25.0,
                                    width:25.0,
                                    decoration: BoxDecoration(
                                        color:Color(0xffbefeff6),
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.exit_to_app,
                                  color: index[5]
                                      ? Color(0xffb4776e6)
                                      : Color(0xff6161a3),
                                ),
                              ],
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                  // color: Color(0xffb4776e6),
                                  color: index[5]
                                      ? Color(0xffb4776e6)
                                      : Colors.black,
                                  fontSize: 12.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                                Navigator.of(context).pop();
                                SaveDataLocal.clearUserData();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => login()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Divider(color: Colors.black,),
                ],
              )),
        );
  }
  TextStyle textStyle = TextStyle(
      color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600);
  viewProapi() async {
    final Map<String, String> data = {};
    data['action'] = "fetch_distributor_data";
    data['d_id'] = (userData?.logindata?.dId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().profileProvider(data).then((Response response) async {
          viewP = viewProfile.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && viewP?.status == "success") {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
