import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:casadealerapp/modal_class/profileV_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';

import 'package:casadealerapp/screens/update_profile.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';


class profileView extends StatefulWidget {
  String? prfileFullName;
  String? prfilePhone1;
  String? prfilePhone2;
  String? prfileCompanyname;
  String? prfileEmailaddress;
  String? prfileCompanyaddress;

   profileView({Key? key, this.prfileFullName,this.prfilePhone1,this.prfilePhone2,this.prfileEmailaddress,this.prfileCompanyname,this.prfileCompanyaddress}) : super(key: key);

  @override
  State<profileView> createState() => _profileViewState();
}
bool isloading = true;

class _profileViewState extends State<profileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  viewProfile? viewP;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewProapi();

  }
  Widget build(BuildContext context) {
    return commanScreen(isLoading:isloading ,
      scaffold: Scaffold(

        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body: isloading?Container():Column(
          children: [
        Column(
        children: [
        Container(
        width: MediaQuery.of(context).size.width * 1,
        height: 11.h,
        child: Column(
          children: [
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.only(bottom: 0.h, left: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 2.3.h,
                      ),
                      Container(
                        // padding: EdgeInsets.only(top: 1.5.h),
                        // alignment: Alignment.center,
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 2.h, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xfff333389),
          // borderRadius: BorderRadius.all(
          //   Radius.circular(10),
          // ),
        ),
      ),
          ],
        ),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  height: 12.h,
                  width: 25.w,
                  padding: EdgeInsets.all(1.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:  "https://tse4.mm.bing.net/th?id=OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8&pid=Api&P=0",


                      placeholder: (context, url) =>
                          Center(
                              child:
                              CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset(
                            "assets/default_product_image.png",
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 1.w,
                    ),
                    Container(
                      width: 50.w,
                      child: Text(
                         (viewP?.data?.fullName) == null ?"": "Hi " + (viewP?.data?.fullName).toString(),
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.w,
                    ),

                    Container(
                      width: 50.w,
                      child: Text(
                        (viewP?.data?.phoneOne) == null ?"":(viewP?.data?.phoneOne).toString(),
                        // "1234567890",
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Color(0xff6262a5),
                        ),
                      ),
                    ),




                  ],
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Padding(
              padding:
              EdgeInsets.only(left: 2.h, right: 2.h),
              child: Divider(color: Colors.black),
            ),
            SizedBox(height: 2.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 6.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 1.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,

                      child: Text(
                        "Company Name :",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.w,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,
                      child: Text(
                        "Phone no2 :",
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,
                      child: Text(
                        "Email Address :",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Colors.black,
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 6.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,
                      child: Text(
                        "Company Address :",
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Colors.black,
                        ),
                      ),
                    ),








                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    SizedBox(
                      height: 1.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,
                      child: Text(
                        (viewP?.data?.companyName)== null ?"N/A":(viewP?.data?.companyName).toString(),
                        // "Fab",
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Color(0xff333389),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 6.w,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,
                      child: Text(
                        (viewP?.data?.phoneTwo) == null ?"N/A": (viewP?.data?.phoneTwo).toString(),
                        // "xyz@gmail.com",
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Color(0xff333389),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,
                      child: Text(
                        (viewP?.data?.emailId)== null ?"N/A": (viewP?.data?.emailId).toString(),
                        // "xyz@gmail.com",
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Color(0xff333389),
                        ),
                      ),
                    ),



                    SizedBox(
                      height: 6.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      width: 45.w,
                      child: Text(
                        (viewP?.data?.address) == null ?"N/A":(viewP?.data?.address).toString(),
                        // "xyz",
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Meta1",
                          color: Color(0xff333389),
                        ),
                      ),
                    ),








                  ],
                ),
              ],
            ),

            SizedBox(
              height: 8.w,
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              // color: Color(0xfff333389),
              // padding:
              //     EdgeInsets.only(left: 35, right: 40, bottom: 10, top: 20),
              child: ElevatedButton(
                onPressed: () {


                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => updateProfile(

                        prfileFullName: viewP?.data?.fullName,
                        prfilePhone1: viewP?.data?.phoneOne,
                        prfilePhone2: viewP?.data?.phoneTwo,
                        prfileCompanyname: viewP?.data?.companyName,
                        prfileEmailaddress: viewP?.data?.emailId,
                      prfileCompanyaddress: viewP?.data?.address,



                    )));

                },
                child: Text(
                  'Update Profile',
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

      ]
        )
      ),
    );
  }

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
