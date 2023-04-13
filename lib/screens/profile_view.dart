import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';

import 'package:casadealerapp/modal_class/profileV_class.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/product_2.dart';

import 'package:casadealerapp/screens/update_profile.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class profileView extends StatefulWidget {
  profileView({
    Key? key,
  }) : super(key: key);
  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  TextEditingController _search = TextEditingController();
  bool se_icon = false;
  bool check = false;
  search? searchproperty;
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  viewProfile? viewP;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewProapi();
    viewcart();
  }
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
          backgroundColor: Color(0xfffFFFFFF),
          drawer: drawer(context),
          key: _scaffoldKey,
          body: isLoading
              ? Container()
              : Stack(
                  children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color(0xfffFFFFFF),
                ),
                       SingleChildScrollView(
                         child: Column(
                           children: [
                             Container(
                               width: MediaQuery.of(context).size.width * 1,
                               height: 11.h,
                               child: Column(
                                 children: [
                                   SizedBox(height: 4.h),
                                   Padding(
                                     padding:
                                         EdgeInsets.only(bottom: 0.h, left: 2.h),
                                     child: Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                       children: [
                                         Row(
                                           children: [
                                             IconButton(
                                               onPressed: () {
                                                 _scaffoldKey.currentState
                                                     ?.openDrawer();
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
                                                     fontSize: 2.h,
                                                     color: Colors.white),
                                               ),
                                             ),
                                           ],
                                         ),
                                         // SizedBox(
                                         //   width: 8.w,
                                         // ),
                                         Row(
                                           children: [
                                             IconButton(
                                               onPressed: () {
                                                 setState(() {
                                                   se_icon = !se_icon;
                                                 });
                                                 // _scaffoldKey.currentState?.openDrawer();
                                               },
                                               icon: Icon(
                                                 Icons.search,
                                                 color: Colors.white,
                                                 size: 3.5.h,
                                               ),
                                             ),
                                             badges.Badge(
                                                 onTap: () {},
                                                 badgeContent: Text(
                                                     (viewaddtocart?.addToCartNumber ==
                                                                 0 ||
                                                             viewaddtocart
                                                                     ?.addToCartNumber ==
                                                                 null)
                                                         ? "0"
                                                         : ((viewaddtocart
                                                                 ?.addToCartNumber)
                                                             .toString()),
                                                     style: TextStyle(
                                                         color: Colors.white)),
                                                 child: Icon(
                                                     Icons.shopping_bag_outlined,
                                                     color: Colors.white,
                                                     size: 3.h))
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
                             SizedBox(
                               height: 2.h,
                             ),
                             (!se_icon)
                                 ? Container()
                                 : Container(
                                     margin: EdgeInsets.symmetric(horizontal: 2.h),
                                     padding: EdgeInsets.symmetric(horizontal: 2.h),
                                     alignment: Alignment.center,
                                     width: MediaQuery.of(context).size.width,
                                     height:
                                         MediaQuery.of(context).size.height * 0.075,
                                     child: TextFormField(
                                       onChanged: (value) {
                                         if (value.isNotEmpty) {
                                           setState(() {
                                             check = true;
                                           });
                                           searchapi(value);
                                         } else if (value.isEmpty) {
                                           setState(() {
                                             check = false;
                                           });
                                         } else {
                                           // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RestaurantsScreen()));
                                         }
                                       },
                                       controller: _search,
                                       decoration: InputDecoration(
                                         border: InputBorder.none,
                                         contentPadding: EdgeInsets.all(3.h),
                                         hintText: 'Search',
                                         suffixIcon: Icon(
                                           Icons.search,
                                           color: Color(0xfff333389),
                                           size: 3.h,
                                         ),
                                       ),
                                     ),
                                     decoration: BoxDecoration(
                                       color: Color(0xfff3faff),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(15),
                                       ),
                                     ),
                                   ),
                             SizedBox(
                               height: 2.h,
                             ),
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
                                       imageUrl:
                                       "https://tse4.mm.bing.net/th?id=OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8&pid=Api&P=0",
                                       placeholder: (context, url) =>
                                           Center(child: CircularProgressIndicator()),
                                       errorWidget: (context, url, error) => Image.asset(
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
                                         (viewP?.data?.fullName) == null
                                             ? ""
                                             : "Hi " +
                                             (viewP?.data?.fullName).toString(),
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
                                         (viewP?.data?.phoneOne) == null
                                             ? ""
                                             : (viewP?.data?.phoneOne).toString(),
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
                               padding: EdgeInsets.only(left: 2.h, right: 2.h),
                               child: Divider(color: Colors.black),
                             ),
                             SizedBox(height: 2.h),
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 SizedBox(
                                   width: 6.w,
                                 ),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     SizedBox(
                                       height: 1.w,
                                     ),
                                     Container(
                                       alignment: Alignment.centerLeft,
                                       height: 6.h,
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
                                       height: 6.h,
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
                                       height: 6.h,
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
                                       height: 6.h,
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
                                       height: 6.h,
                                       width: 45.w,
                                       child: Text(
                                         (viewP?.data?.companyName) == null
                                             ? "N/A"
                                             : (viewP?.data?.companyName).toString(),
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
                                       height: 6.h,
                                       width: 45.w,
                                       child: Text(
                                         (viewP?.data?.phoneTwo) == null
                                             ? "N/A"
                                             : (viewP?.data?.phoneTwo).toString(),
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
                                       height: 6.h,
                                       width: 45.w,
                                       child: Text(
                                         (viewP?.data?.emailId) == null
                                             ? "N/A"
                                             : (viewP?.data?.emailId).toString(),
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
                                       height: 6.h,
                                       width: 45.w,
                                       child: Text(
                                         (viewP?.data?.address) == null
                                             ? "N/A"
                                             : (viewP?.data?.address).toString(),
                                         // "xyz",
                                         maxLines: 5,
                                         style: TextStyle(
                                           fontSize: 5.w,
                                           fontWeight: FontWeight.w500,
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
                                             prfileCompanyname:
                                             viewP?.data?.companyName,
                                             prfileEmailaddress:
                                             viewP?.data?.emailId,
                                             prfileCompanyaddress:
                                             viewP?.data?.address,
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

                           ],
                         ),
                       ),
                    Padding(
                        padding: EdgeInsets.only(
                          left: 1.h,
                          right: 1.h,
                          top: 20.h,
                        ),
                        child: check!
                            ? Container(
                          height: 100.h,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: (searchproperty == null
                              ? SizedBox(
                            width:
                            MediaQuery.of(context)
                                .size
                                .width,
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: 25.h,
                                    child: Text(
                                      'Product not found',
                                      style: TextStyle(
                                        color: Colors
                                            .black,
                                        fontSize: 2.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : searchproperty
                              ?.data?.length ??
                              0) ==
                              0
                              ? SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Product not found.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 2.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : Container(
                            width: MediaQuery.of(context)
                                .size
                                .width,
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 0.5.h),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: searchproperty == null
                                  ? 0
                                  : searchproperty
                                  ?.data?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    String? search =
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                product_2(
                                                  pronamenevigatior:
                                                  '${searchproperty?.data?[index].prodName}',
                                                )));
                                    if (search != null) {
                                      if (search.isNotEmpty) {
                                        _search.text = search;
                                        searchapi(search);
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin:
                                    EdgeInsets.symmetric(
                                        vertical: 0.5.h),
                                    height: 20.w,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: searchproperty
                                                ?.data?[
                                            index]
                                                .prodImgDefault ??
                                                '',
                                            imageBuilder: (context,
                                                imageProvider) =>
                                                CircleAvatar(
                                                  radius: 8.w,
                                                  backgroundImage:
                                                  NetworkImage(
                                                    searchproperty
                                                        ?.data?[index]
                                                        .prodImgDefault ??
                                                        '',
                                                  ),
                                                ),
                                            placeholder: (context,
                                                url) =>
                                                Center(
                                                    child:
                                                    CircularProgressIndicator()),
                                            errorWidget: (context,
                                                url,
                                                error) =>
                                                CircleAvatar(
                                                  radius: 8.w,
                                                  backgroundImage:
                                                  AssetImage(
                                                    "assets/default_product_image.png",
                                                  ),
                                                )),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Container(
                                          child: Flexible(
                                            child: Text(
                                              searchproperty
                                                  ?.data?[
                                              index]
                                                  .prodName ??
                                                  '',
                                              textAlign:
                                              TextAlign
                                                  .center,
                                              style: TextStyle(
                                                  fontSize:
                                                  1.8.h,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                            : Container()),

              ])),
      isLoading: isLoading,
    );
  }
  viewProapi() async {
    final Map<String, String> data = {};
    data['action'] = "fetch_distributor_data";
    data['d_id'] = (userData?.logindata?.dId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().profileProvider(data).then((Response response) async {
          print(response.body);

          viewP = viewProfile.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && viewP?.status == "success") {
            print(viewP?.status);

            setState(() {
              isLoading = false;
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
  viewcart() async {
    final Map<String, String> data = {};
    data['action'] = 'view_add_to_cart_product_single';
    data['d_id'] = (userData?.logindata?.dId).toString();

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().viewcartapi(data).then((Response response) async {
          viewaddtocart = ViewCart.fromJson(json.decode(response.body));

          if (response.statusCode == 200 &&
              viewaddtocart?.status == "success") {
          } else {}
        });
      } else {}
    });
  }

  searchapi(body) async {
    final Map<String, String> data = {};
    data['action'] = 'searching_products';
    data['search'] = body;

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().searchproduct(data).then((Response response) async {
          searchproperty = search.fromJson(json.decode(response.body));

          if (response.statusCode == 200 &&
              searchproperty?.status == "success") {
            setState(() {
              // isloading = false;
            });
            if (kDebugMode) {}
          } else {
            setState(() {
              // isloading = false;
            });
          }
        });
      } else {
        setState(() {
          // isloading = false;
        });
      }
    });
  }
}
