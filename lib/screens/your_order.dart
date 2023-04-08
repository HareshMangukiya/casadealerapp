import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:casadealerapp/modal_class/singlepro_class.dart';
import 'package:casadealerapp/modal_class/view_order.dart';
import 'package:casadealerapp/provider/productprovider.dart';

import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class your_order extends StatefulWidget {
  const your_order({Key? key}) : super(key: key);

  @override
  State<your_order> createState() => _your_orderState();
}

class _your_orderState extends State<your_order> {
  view_orders? view;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List<String> tabs = ["Blocked", "Cart"];
  // List<bool> checkbox = [
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false
  // ];
  //
  // int cart = 0;
  //
  TextEditingController _search = TextEditingController();
  bool se_icon = false;
  bool isloading = true;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewapi();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
                                  size: 4.h,
                                ),
                              ),
                              SizedBox(
                                width: 2.3.h,
                              ),
                              Container(
                                // padding: EdgeInsets.only(top: 1.5.h),
                                // alignment: Alignment.center,
                                child: Text(
                                  "Your Orders",
                                  style:
                                      TextStyle(fontSize: 2.h, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 11.h,
                          ),
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
                              SizedBox(
                                width: 1.h,
                              ),
                              IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             cart_order()));
                                  // _scaffoldKey.currentState?.openDrawer();
                                },
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 3.h,
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "";
                  //   }
                  //   return null;
                  // },
                  onChanged: (value) {
                    print(value);
                    if (value.isNotEmpty) {
                      // searchapi(value);
                    } else if (value.isEmpty) {
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             products_1()));
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
                  // shape: BoxShape.circle,
                  color: Color(0xfff3faff),
                  // image: DecorationImage(
                  //     image: AssetImage("assets/product_1_img.png"),
                  //     fit: BoxFit.fitWidth)
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                    // ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 88.h,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => order_id()));
                  },
                  child: ListView.builder(
                    // padding: EdgeInsets.all(0),
                    // visualDensity: VisualDensity(horizontal: 4, vertical: 4),
                    // horizontalTitleGap: 0.0,

                    itemCount: view?.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // padding: EdgeInsets.all(0),
                        // alignment: Alignment.center,
                        height: 11.h,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          border: Border.all(color: Color(0xffe8e8e8)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                              CachedNetworkImage(
                                  height: 11.h,
                                  width: 20.w,
                                  fit: BoxFit.cover,
                                  imageUrl:view
                                      ?.data?[index]
                                      .imageOne ??
                                      "",
                                  progressIndicatorBuilder: (context,
                                      url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress
                                              .progress),
                                  errorWidget: (context, url, error) =>
                                      Image.asset( "assets/default_product_image.png",
                                        height: 11.h,
                                        width: 20.w,
                                        fit: BoxFit.cover,

                                      )
                              ),

                              // Image.asset(
                              //   'assets/product_1_img2.png',
                              //   height: 11.h,
                              //   width: 20.w,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            // SizedBox(width: 5.w,),

                            Padding(
                              padding: EdgeInsets.all(1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Order ID # ' +
                                                (view?.data?[index].id)
                                                    .toString() ??
                                            "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.h),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 1.5.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'No of Products : ',
                                        style: TextStyle(
                                          color: Color(0xff5a5858585),
                                        ),
                                      ),
                                      Text(
                                        // (view?.data?[index]
                                        //             .productNumberOrder)
                                        //         .toString() == null ?"N/A": (view?.data?[index]
                                        //     .productNumberOrder)
                                        //     .toString(),
                                        '550',
                                        style: TextStyle(
                                          color: Color(0xff5a5a9f),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(0.6.h),
                                    alignment: Alignment.center,
                                    height: 3.4.h,
                                    width: 21.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        color: (view?.data?[index].status ==
                                                "1")
                                            ? Color(0xfffaede7)
                                            : (view?.data?[index].status ==
                                                    "2")
                                                ? Color(0xffe1f5e2)
                                                : Color(0xfffae7e7)),
                                    child: Text(
                                      (view?.data?[index].status == "1")
                                          ? "Placed"
                                          : (view?.data?[index].status == "2")
                                              ? "Confirmed"
                                              : "Cancle",
                                      // 'Placed',
                                      style: TextStyle(
                                          color: (view?.data?[index].status ==
                                                  "1")
                                              ? Color(0xfff98b54)
                                              : (view?.data?[index].status ==
                                                      "2")
                                                  ? Color(0xff48d34d)
                                                  : Color(0xfff97070),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(width: 1.3.w),

                            SizedBox(width: 9.w),
                            Text(
                              '₹' + (view?.data?[index].price).toString() == null ? "N/A" :"₹" + (view?.data?[index].price).toString(),
                              // '₹5,925',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2.2.h,
                                  color: Color(0xff3b3b8d)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width ,
              //   height: 8.3.h,
              //
              //   child: Padding(
              //     padding: EdgeInsets.all(2.h),
              //     child: Container(
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 cart = 1;
              //               });
              //             },
              //             child: Container(
              //               padding: EdgeInsets.all(0.1.h),
              //               alignment: Alignment.center,
              //               width: 40.w,
              //               height: 5.5.h,
              //               decoration: BoxDecoration(
              //                   color: (cart == 0)
              //                       ? Colors.white
              //                       : Color(0xfff333389),
              //                   borderRadius: BorderRadius.circular(20),
              //                   border: Border.all(color: Colors.white)),
              //               child: Text(
              //                 'Exit',
              //                 style: TextStyle(
              //                     color: (cart == 0)
              //                         ? Color(0xff333389)
              //                         : Colors.white ,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 2.2.h),
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             width: 2.w,
              //           ),
              //           GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 cart = 0;
              //               });
              //             },
              //             child: Container(
              //               padding: EdgeInsets.all(0.1.h),
              //               alignment: Alignment.center,
              //               width: 40.w,
              //               height: 5.5.h,
              //               decoration: BoxDecoration(
              //                   color: (cart == 1)
              //                       ? Colors.white
              //                       : Color(0xfff333389),
              //                   // color:_selectedColor,
              //
              //                   borderRadius: BorderRadius.circular(20),
              //                   border: Border.all(color: Colors.white)),
              //               child: Text(
              //                 'Confirm',
              //                 style: TextStyle(
              //                     color: (cart == 1)
              //                         ? Color(0xff333389)
              //                         : Colors.white,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 2.2.h),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     // borderRadius: BorderRadius.all(
              //     //   Radius.circular(10),
              //     // ),
              //   ),
              // ),
            ],
          )
        ],
      ),
        ),
      );

  }

  viewapi() async {
    final Map<String, String> data = {};
    data['action'] = 'view_order';
    data['d_id'] = (userData?.logindata?.dId).toString();

    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .view_product_order(data)
            .then((Response response) async {
          view = view_orders.fromJson(json.decode(response.body));
          // isloading = false;

          if (response.statusCode == 200 && view?.status == "success") {
            setState(() {});

            // print("img" + (searchproperty?.data?[0].prodImgDefault).toString());

            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => loginsuccess()));

            if (kDebugMode) {
              // isloading = false;
            }
          } else {
            // isloading = false;
          }
        });
      } else {
        // isloading = false;
      }
    });
  }
}
