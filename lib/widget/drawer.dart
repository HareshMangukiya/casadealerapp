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
import 'package:casadealerapp/widget/shared_preference.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

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

  getdata() async {
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthDrawer = MediaQuery.of(context).size.width * 0.75;
    return SafeArea(
      child: Drawer(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: widthDrawer,
            // color: Colors.black,
            child: ListView(
              //padding: EdgeInsets.all(2.w),
              children: [
                Container(
                    height: 13.h,
                    padding: EdgeInsets.all(5.w),
                    width: widthDrawer,
                    // color: Colors.black.withOpacity(0.3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(.0)),
                      // image: DecorationImage(
                      //     fit: BoxFit.fill,
                      //     // image: AssetImage("assets/splash2.jpg")
                      // )
                      // image: NetworkImage(
                      //     'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 7.w,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/profile.jpg',
                                  width: 13.w,
                                  height: 13.w,
                                  fit: BoxFit.cover,
                                ),
                                // child: Image.network(
                                //   (viewmodel?.data?.profileImg).toString(),
                                //   fit: BoxFit.cover,
                                //   width: 16.w,
                                //   height: 16.w,
                                // ),
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
                                        color: Color(0xff6161a3),
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
                  color: Colors.black,
                ),

                // Divider(color: Colors.black,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child: Column(
                    children: [
                      Container(
                        color: index[0]
                            ? Color(0xffb4776e6).withOpacity(0.2)
                            : Colors.transparent,
                        child: ListTile(
                          // trailing: Icon(
                          //   Icons.arrow_forward_ios,
                          //   // color: Color(0xffb4776e6),
                          //   color: index[1] ? Color(0xffb4776e6) : Colors.black,
                          // ),
                          leading: Icon(Icons.person,
                              // color: Color(0xffb4776e6),
                              color: index[0]
                                  ? Color(0xffb4776e6)
                                  : Color(0xff6161a3)),
                          title: Text(
                            'Profile',
                            style: TextStyle(
                              // color: Color(0xffb4776e6),
                                color: index[0]
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
                            setState(() {
                              index[0] = !index[0];
                            });

                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>mytrips1()));
                          },
                        ),
                      ),
                      Container(
                        color: index[1]
                            ? Color(0xffb4776e6).withOpacity(0.2)
                            : Colors.transparent,
                        child: ListTile(
                          // trailing: Icon(
                          //   Icons.arrow_forward_ios,
                          //   // color: Color(0xffb4776e6),
                          //   color: index[1] ? Color(0xffb4776e6) : Colors.black,
                          // ),
                          leading: Icon(Icons.shopping_bag_outlined,
                              // color: Color(0xffb4776e6),
                              color: index[1]
                                  ? Color(0xffb4776e6)
                                  : Color(0xff6161a3)),
                          title: Text(
                            'Home',
                            style: TextStyle(
                                // color: Color(0xffb4776e6),
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
                                    builder: (context) => products_1()));
                            setState(() {
                              index[1] = !index[1];
                            });
                            // Navigator.of(context).pop();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>mytrips1()));
                          },
                        ),
                      ),
                      // Divider(color: Colors.black,),

                      Container(
                        color: index[2]
                            ? Color(0xffb4776e6).withOpacity(0.2)
                            : Colors.transparent,
                        child: ListTile(
                          // trailing: Icon(
                          //   Icons.arrow_forward_ios,
                          //   // color: Color(0xffb4776e6),
                          //   color: index[2] ? Color(0xffb4776e6) : Colors.black,
                          // ),
                          leading: Icon(
                            Icons.library_books,
                            // color: Color(0xffb4776e6),
                            color: index[2]
                                ? Color(0xffb4776e6)
                                : Color(0xff6161a3),
                          ),
                          title: Text(
                            'Order History',
                            style: TextStyle(
                                // color: Color(0xffb4776e6),
                                color: index[2]
                                    ? Color(0xffb4776e6)
                                    : Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => your_order()));

                              index[2] = !index[2];
                            });
                            // Navigator.of(context).pop();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>favouritelist()));
                          },
                        ),
                      ),
                      Container(
                        color: index[3]
                            ? Color(0xffb4776e6).withOpacity(0.2)
                            : Colors.transparent,
                        child: ListTile(
                          // trailing: Icon(
                          //   Icons.arrow_forward_ios,
                          //   // color: Color(0xffb4776e6),
                          //   color: index[3] ? Color(0xffb4776e6) : Colors.black,
                          // ),
                          leading: Icon(
                            Icons.check_box_outline_blank,
                            // color: Color(0xffb4776e6),
                            color: index[3]
                                ? Color(0xffb4776e6)
                                : Color(0xff6161a3),
                          ),
                          title: Text(
                            'Blocked Order',
                            style: TextStyle(
                                // color: Color(0xffb4776e6),
                                color: index[3]
                                    ? Color(0xffb4776e6)
                                    : Colors.black,
                                fontSize: 12.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          your_block_order()));
                              index[3] = !index[3];
                            });
                            // Navigator.of(context).pop();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>requestlist()));
                          },
                        ),
                      ),
                      // Divider(color: Colors.black,),
                      Container(
                        color: index[4]
                            ? Color(0xffb4776e6).withOpacity(0.2)
                            : Colors.transparent,
                        child: ListTile(
                          // trailing: Icon(
                          //   Icons.arrow_forward_ios,
                          //   // color: Color(0xffb4776e6),
                          //   color: index[4] ? Color(0xffb4776e6) : Colors.black,
                          // ),
                          leading: Icon(
                            Icons.headphones_outlined,
                            // color: Color(0xffb4776e6),
                            color: index[4]
                                ? Color(0xffb4776e6)
                                : Color(0xff6161a3),
                          ),
                          title: Text(
                            'Help & Support',
                            style: TextStyle(
                                // color: Color(0xffb4776e6),
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
                            // Navigator.of(context).pop();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>profile2()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        color: index[5]
                            ? Color(0xffb4776e6).withOpacity(0.2)
                            : Colors.transparent,
                        child: ListTile(
                          // trailing: Icon(
                          //   Icons.arrow_forward_ios,
                          //   // color: Color(0xffb4776e6),
                          //   color: index[4] ? Color(0xffb4776e6) : Colors.black,
                          // ),
                          leading: Icon(
                            Icons.exit_to_app,
                            // color: Color(0xffb4776e6),
                            color: index[5]
                                ? Color(0xffb4776e6)
                                : Color(0xff6161a3),
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
                            setState(() {
                              Navigator.of(context).pop();
                              SaveDataLocal.clearUserData();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));

                              index[5] = !index[5];
                            });
                            // Navigator.of(context).pop();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>profile2()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider(color: Colors.black,),
              ],
            )),
      ),
    );
  }

  TextStyle textStyle = TextStyle(
      color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600);
  // view(){
  //   final Map<String, String> data = {
  //   };
  //   data['action']="view_profile";
  //   data['user_id'] = (userData?.data?.uId).toString();
  //   checkInternet().then((internet) async {
  //     if (internet) {
  //       authprovider().viewapi(data).then((Response response) async {
  //         viewmodel = ViewModel.fromJson(json.decode(response.body));
  //         if (response.statusCode == 200 && viewmodel?.status == "1") {
  //           setState(() {
  //             // isLoading = false;
  //           });
  //
  //           if (kDebugMode) {
  //           }
  //
  //         }
  //         else{
  //         }
  //       });
  //     } else {
  //       setState(() {
  //         // isLoading = false;
  //       });
  //       buildErrorDialog(context, 'Error',"Internate Required");
  //     }
  //   });
  // }


  viewProapi() async {
    final Map<String, String> data = {};
    data['action'] = "fetch_distributor_data";
    data['d_id'] = (userData?.logindata?.dId).toString();

    print(data);

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().profileProvider(data).then((Response response) async {
          print(response.body);

          viewP = viewProfile.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && viewP?.status == "success") {
            print(viewP?.status);

            setState(() {
              isloading = false;
              // viewProapi();
            });
            // SaveDataLocal.saveLogInData(userData!);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => loginsuccess()));
            // Fluttertoast.showToast(
            //   msg: "Logged In Successfully",
            //   textColor: Colors.white,
            //   toastLength: Toast.LENGTH_SHORT,
            //   timeInSecForIosWeb: 1,
            //   gravity: ToastGravity.BOTTOM,
            //   backgroundColor: Colors.indigo,
            // );

            if (kDebugMode) {}


          } else {

            setState(() {
              isloading = false;

            });


          }
        });
      } else {}
    });

  }
}
