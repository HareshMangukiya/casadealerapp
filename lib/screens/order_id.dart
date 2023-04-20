import 'dart:convert';
import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';
import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/modal_class/order_detail_class.dart';
import 'package:casadealerapp/modal_class/oredrdetail.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/alert_screen2.dart';
import 'package:casadealerapp/screens/order_detail.dart';
import 'package:casadealerapp/screens/product_2.dart';

import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/build_dialog.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class order_id extends StatefulWidget {
  String? id;
  int? index1;
  String? o_status;
   order_id({
    Key? key,this.id,this.index1,this.o_status
  }) : super(key: key);

  @override
  State<order_id> createState() => _order_idState();
}

class _order_idState extends State<order_id> {
  TextEditingController _search = TextEditingController();
  search? searchproperty;
  bool se_icon = false;
  bool? check = false;
  orderdetail? detail;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  double? sub_total = 0.0;
  double? gst;
  double? payable_amount = 0.0;
  bool? isLoading = true;

  RegExp regex = RegExp(r'^\d+$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orederdetailapiblock();
    viewcount();
    print("£££££££££££££" + widget.o_status.toString());
  }

  int? total1 = 0;
  int? total2 = 0;
  double? price = 0.0;
  double? gtotal = 0.0;
  double? gstt = 0.0;
  cartcount? count;

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body: isLoading! ? Container() : Stack(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Color(0xfffFFFFFF),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 1,
              height: 11.h,
              child: Column(
                children: [
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.h, left: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 11.0),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  child: Icon(
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
                                    TextStyle(
                                        fontSize: 2.h, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 28.w,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 11,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      se_icon = !se_icon;
                                    });
                                    // _scaffoldKey.currentState?.openDrawer();
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 3.5.h,
                                  ),
                                ),
                              ],
                            ),

                            badges.Badge(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => summary()));
                                },
                                badgeContent: Text((count?.cartCount == 0 ||
                                    count?.cartCount == null) ? "0" : (count
                                    ?.cartCount).toString(),
                                    style: TextStyle(color: Colors.white)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => summary()));
                                  },
                                  child: Icon(Icons.shopping_bag_outlined,
                                      color: Colors.white,
                                      size: 3.5.h),
                                )
                            )
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
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    (!se_icon)
                        ? Container()
                        : Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.h),
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height:
                      MediaQuery
                          .of(context)
                          .size
                          .height * 0.075,
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
                    ),
// SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Container(
                        alignment: Alignment.center,
                        height: 6.5.h,
                        width: 95.w,
                        decoration: BoxDecoration(
                          color: Color(0xffeaeaf3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "ORDER ID : " + widget.id.toString(),

                                  style: TextStyle(
                                      fontSize: 2.h,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff333389)
                                  )),

                              Container(
                                alignment: Alignment.center,
                                height: 3.4.h,
                                width: 27.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: (widget.o_status ==
                                        "Blocked")
                                        ? Color(0xfffaede7)
                                        : (widget.o_status ==
                                        "Placed")
                                        ? Color(0xffe1f5e2):(widget.o_status ==
                                        "Confirmed")?
                                    Color(0xffe1f5e2):(widget.o_status ==
                                        "unblock order") ?Color(0xfffaede7)
                                        : Color(0xfffae7e7)),
                                child: Text(

                                  widget.o_status.toString(),
                                  style: TextStyle(
                                      color: (widget.o_status ==
                                          "Blocked")
                                          ? Color(0xfff98b54)
                                          : (widget.o_status ==
                                          "Placed")
                                          ? Color(0xff48d34d):(widget.o_status ==
                                          "Confirmed")
                                          ? Color(0xff48d34d):(widget.o_status ==
                                          "unblock order")? Color(0xfff98b54):
                                      Color(0xfff97070),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ),
                    Container(
                      height: 50.h,
                      child: ListView.builder(
                        itemCount: detail?.productData?.length,
                        itemBuilder: (context, index) {
                          total1 = int.parse(
                              detail?.productData?[index]
                                  .xs ?? "0") +
                              int.parse(detail?.productData?[index]
                                  .s ?? "0") +
                              int.parse(detail?.productData?[index]
                                  .m ?? "0") +
                              int.parse(detail?.productData?[index]
                                  .l ?? "0") +
                              int.parse(detail?.productData?[index]
                                  .xl ?? "0") +
                              int.parse(detail?.productData?[index]
                                  .xxl ?? "0") +
                              int.parse(detail?.productData?[index]
                                  .s3xl ?? "0");
                          total2 = int.parse(
                              detail?.productData?[index]
                                  .s4xl ?? "0") +
                              int.parse(detail?.productData?[index]
                                  .s5xl ?? "0");
                          price = double.parse(total1.toString()) *
                              double.parse(detail?.productData?[index]
                                  .minPrice ?? "0") +
                              double.parse(total2.toString()) *
                                  double.parse(detail?.productData?[index]
                                      .maxPrice ?? "0");

                          gst = price! * 18 / 100;
                          gtotal = price! + gst!;


                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Product Name',
                                        style: TextStyle(
                                          color: Color(0xff848484),
                                          fontSize: 1.5.h,
                                        )),
                                    Text('Color',
                                        style: TextStyle(
                                          color: Color(0xff848484),
                                          fontSize: 1.5.h,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(detail?.productData?[index].productName
                                        .toString() ?? "N/A",
                                        style: TextStyle(
                                            color: Color(0xff35358a),
                                            fontSize: 2.h,
                                            fontWeight: FontWeight.bold)),
                                    Text(detail?.productData?[index].colorName
                                        .toString() ?? "N/A",
                                        style: TextStyle(
                                          color: Color(0xff35358a),
                                          fontSize: 2.h,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Price',
                                    style: TextStyle(color: Color(0xff848484)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.h,
                                      child: Row(
                                        children: [
                                          Text('XS - 3XL :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Text("₹" +
                                              (detail?.productData?[index]
                                                  .minPrice).toString() != 0
                                              ? (detail?.productData?[index]
                                              .minPrice).toString()
                                              : "N/A",
                                              style: TextStyle(
                                                  color: Color(0xff35358a),
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.h,
                                      child: Row(
                                        children: [
                                          Text(
                                            '4XL- 5XL :',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "₹" + (detail?.productData?[index]
                                                .maxPrice).toString() != 0
                                                ? (detail?.productData?[index]
                                                .maxPrice).toString()
                                                : "N/A",
                                            style: TextStyle(
                                              color: Color(0xff35358a),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  widget.o_status!= "Cancel"?GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  order_detail_c(
                                                    val: 1,
                                                    oreder: widget.id
                                                        .toString(),
                                                    id: index,
                                                    o_status: widget.o_status.toString(),
                                                  )
                                          )
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 20.5.w,
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 1.5.h),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xff333389),
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                    ),
                                  ): Container()
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Divider(
                                  height: 3.h,
                                  thickness: 0.3.w,
                                  color: Color(0xff50509a),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text('Gender',
                                          style: TextStyle(
                                            color: Color(0xff848484),
                                          )),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        detail?.productData?[index].gender
                                            .toString() ?? "N/A",
                                        style: TextStyle(
                                            fontSize: 2.3.h,
                                            color: Color(0xff35358a),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.h),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text('State',
                                          style: TextStyle(
                                            color: Color(0xff848484),
                                          )),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        detail?.productData?[index]
                                            .warehouseName.toString() ?? "N/A",
                                        style: TextStyle(
                                            fontSize: 2.3.h,
                                            color: Color(0xff35358a),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),

                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      // color: Colors.red,
                                      child: Text(
                                        'XS',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        'L',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        'XL',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].xs)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].s)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].m)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].l)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].xl)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        '2XL',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        '3XL',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        '4XL',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        '5XL',
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: Color(0Xffeaeaf3),
                                      ),
                                      child: Text(
                                        'TOTAL',
                                        style: TextStyle(
                                            fontSize: 1.6.h,
                                            color: Color(0XFF50509a),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 15.w,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height: 0.1.h,
                                      width: 17.w,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 3.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].xxl)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].s3xl)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].s4xl)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.5.h,
                                      width: 15.w,
                                      child: Text(
                                        (detail?.productData?[index].s5xl)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 1.9.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 3.6.h,
                                      width: 15.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        color: Color(0Xffeaeaf3),
                                      ),
                                      child: Text(
                                        "₹" + price.toString(),
                                        style: TextStyle(
                                            fontSize: 1.5.h,
                                            color: Color(0Xff50509a),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 6.h,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                color: Color(0xfffeaeaf3),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        ' Grand Total:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.h),
                                      ),
                                      Text(
                                        '   ₹' + price.toString() + " + ₹" +
                                            gst.toString() + "(18% GST) = ₹" +
                                            gtotal.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.5.h,
                                            color: Color(0xff333389)),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              SizedBox(height: 2.h),

                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 73.h),
              child: Column(
                  children: [
                    Container(
                      height: 20.h,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: Color(0xfff5f5f5),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Payment Summary',
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                    fontSize: 1.8.h,
                                    color: Color(0xff333389)),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            DottedLine(
                              direction: Axis.horizontal,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 5.0,
                              dashColor: Color(0xff8d8d8d),
                              // dashGradient: [Colors.red, Colors.blue],
                              dashRadius: 0.0,
                              dashGapLength: 4.0,
                              dashGapColor: Colors.transparent,
                              // dashGapGradient: [Colors.red, Colors.blue],
                              dashGapRadius: 0.0,
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sub Total :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.9.h,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    // '₹' + (detail?.orderData?.price).toString() ?? "",

                                    // '₹99,99,999',
                                    // (detail?.data?[0].).toString() ??
                                    "₹" + sub_total.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 1.9.h,
                                      color: Color(0xff50509a),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'GST',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.9.h,
                                        color: Colors.black),
                                  ),
                                  Text(

                                    "₹" + gstt.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 1.9.h,
                                      color: Color(0xff50509a),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Payable Amount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.9.h,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "₹" + payable_amount.toString(),
                                    // '₹1,00,12,455',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 1.9.h,
                                      color: Color(0xff50509a),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 3.h),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // Navigator.push(
                        //       //     context,
                        //       //     MaterialPageRoute(
                        //       //         builder: (context) => summary_b_edit()));
                        //     },
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8),
                        //         color: Color(0xff333389),
                        //       ),
                        //       height: 6.h,
                        //       width: 40.w,
                        //       child: Text(
                        //         'Edit',
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        widget.o_status != "Cancel" ? GestureDetector(
                        onTap: () {
            navDialog(this.context, "", "Are You Sure Cancel This  order");
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => products_1()));
            },
              child:
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff333389),
                ),
                height: 6.h,
                width: 40.w,
                child: Text(
                  'Cancel Request',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ): Container()

                      ],
                    ),
                    SizedBox(height: 1.h),
                  ]
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 1.h, top: 20.h,
                    right: 1.h),
                child: check ! ? Container(
                  height: 100.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.white,
                  child: (searchproperty == null
                      ? SizedBox(
                    width: MediaQuery
                        .of(context)
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
                                color: Colors.black,
                                fontSize: 2.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : searchproperty?.data?.length ?? 0) ==
                      0
                      ? SizedBox(
                    width: MediaQuery
                        .of(context)
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    alignment: Alignment.topCenter,

                    margin: EdgeInsets.symmetric(
                        horizontal: 2.h, vertical: 0.5.h),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: searchproperty == null
                          ? 0
                          : searchproperty?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            String? search = await
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        product_2(

                                          pronamenevigatior: '${searchproperty
                                              ?.data?[index].prodName}',
                                          // coloridnevigator:
                                          //     '${productData?.productData![index].apId}',
                                        )
                                )
                            );
                            if (search != null) {
                              if (search.isNotEmpty) {
                                _search.text = search;
                                searchapi(search);
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 0.5.h),
                            height: 20.w,
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: searchproperty
                                        ?.data?[index]
                                        .prodImgDefault ??
                                        '',
                                    imageBuilder:
                                        (context, imageProvider) =>
                                        CircleAvatar(
                                          radius: 8.w,
                                          backgroundImage: NetworkImage(
                                            searchproperty
                                                ?.data?[index]
                                                .prodImgDefault ??
                                                '',),
                                        ),
                                    placeholder: (context, url) =>
                                        Center(
                                            child:
                                            CircularProgressIndicator()),
                                    errorWidget:
                                        (context, url, error) =>
                                        CircleAvatar(
                                          radius: 8.w,
                                          backgroundImage: AssetImage(
                                            "assets/default_product_image.png",
                                          ),
                                        )

                                ),
                                SizedBox(width: 5.w,),
                                Container(
                                  child: Flexible(
                                    child: Text(
                                      searchproperty
                                          ?.data?[index]
                                          .prodName ??
                                          '',
                                      textAlign:
                                      TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 1.8.h,
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
                ) : Container()
            ),
          ],
        ),
      ),
      isLoading: isLoading!,
    );
  }

  orederdetailapiblock() {
    final Map<String, String> data = {};
    data['action'] = 'order_details';
    data['order_no'] = widget.id.toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .oredrdetailap(data)
            .then((Response response) async {
          detail = orderdetail.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && detail?.status == "success") {
            for (int index = 0; index <
                (detail?.productData?.length ?? 0); index++) {
              total1 = int.parse(
                  detail?.productData?[index]
                      .xs ?? "0") + int.parse(detail?.productData?[index]
                  .s ?? "0") +
                  int.parse(detail?.productData?[index]
                      .m ?? "0") +
                  int.parse(detail?.productData?[index]
                      .l ?? "0") +
                  int.parse(detail?.productData?[index]
                      .xl ?? "0") +
                  int.parse(detail?.productData?[index]
                      .xxl ?? "0") +
                  int.parse(detail?.productData?[index]
                      .s3xl ?? "0");
              total2 = int.parse(
                  detail?.productData?[index]
                      .s4xl ?? "0") +
                  int.parse(detail?.productData?[index]
                      .s5xl ?? "0");
              price = double.parse(total1.toString()) *
                  double.parse(detail?.productData?[index]
                      .minPrice ?? "0") + double.parse(total2.toString()) *
                  double.parse(detail?.productData?[index]
                      .maxPrice ?? "0");
              gst = price! * 18 / 100;
              gtotal = price! + gst!;
              sub_total = sub_total! + price!;
              gstt = gst! + gstt!;
              payable_amount = gstt! + sub_total!;
            }

            setState(() {
              sub_total;
              payable_amount;
              gstt;
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

  cancelrequest() {
    final Map<String, String> data = {};
    data['action'] = 'cancle_order_request';
    data['order_no'] = widget.id.toString();
    data['d_id'] = (userData?.logindata?.dId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .canclerequestapi(data)
            .then((Response response) async {
          convertblockorder edit = convertblockorder.fromJson(
              json.decode(response.body));
          if (response.statusCode == 200 && edit?.status == "success") {
            setState(() {});

            // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> your_order() ));

          } else {
            // isloading = false;
          }
        });
      } else {
        // isloading = false;
      }
    });
  }

  // search
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

  viewcount() async {
    final Map<String, String> data = {};
    data['action'] = 'add_to_cart_count';
    data['d_id'] = (userData?.logindata?.dId).toString();


    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().addtocartcount(data).then((Response response) async {
          count = cartcount.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              count?.status == "success") {}
          else {}
        });
      } else {

      }
    });
  }


  // navDialog1(BuildContext context, String title, String contant) {
  //   if (Platform.isAndroid) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           backgroundColor: Colors.transparent,
  //           child: Container(
  //             width: 73.w,
  //             height: (title == "") ? 20.h : 22.h,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //
  //                     Row(
  //                       children: [
  //                         // Icon(Icons.edit,color:Colors.white ,),
  //                         Text(
  //                           "",
  //                           style: TextStyle(
  //                               decoration: TextDecoration.underline,
  //                               fontSize: 16.sp,
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold,
  //                               fontFamily: "Poppins"),
  //                         ),
  //                       ],
  //                     ),
  //                     IconButton(
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                           // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> order_id() ));
  //
  //                         },
  //                         icon: Icon(
  //                           Icons.close,
  //                           color: Colors.black,
  //                         ))
  //                   ],
  //                 ),
  //                 (title != "") ? Column(
  //                   children: [
  //                     Container(
  //                       padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                       child: Text(
  //                         title,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontSize: 14.sp,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.bold,
  //                             decorationColor: Colors.black,
  //                             fontFamily: 'poppins'),
  //                       ),
  //                     ),
  //                     SizedBox(height: 1.h),
  //                   ],
  //                 ) : Container(),
  //
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                   child: Column(
  //                     children: [
  //                       SizedBox(height: 1.h),
  //                       Text(
  //                         contant,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontSize: 12.sp,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.bold,
  //                             decorationColor: Colors.black,
  //                             fontFamily: 'poppins'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 2.h),
  //                 Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       GestureDetector(
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           height: 40.0,
  //                           width: 30.w,
  //                           decoration: BoxDecoration(
  //                             shape: BoxShape.rectangle,
  //                             borderRadius: BorderRadius.circular(20.0),
  //                             color: Color(0xff333389),
  //                           ),
  //                           child: Text("ok",
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                   fontSize: 14.sp,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.white,
  //                                   decorationColor: Colors.black,
  //                                   fontFamily: 'poppins')),
  //                         ),
  //                         onTap: () {
  //                           // Navigator.pop(context);
  //
  //                           Navigator.of(context).push(MaterialPageRoute(
  //                               builder: (context) => your_order()));
  //                         },
  //                       ),
  //                       // GestureDetector(
  //                       //   child: Container(
  //                       //     height: 40.0,
  //                       //     width: 30.w,
  //                       //     decoration: BoxDecoration(
  //                       //       shape: BoxShape.rectangle,
  //                       //       borderRadius: BorderRadius.circular(20.0),
  //                       //       color: Color(0xff333389),
  //                       //     ),
  //                       //     child: Center(
  //                       //       child: Text("No",
  //                       //           textAlign: TextAlign.center,
  //                       //           style:  TextStyle(
  //                       //               fontSize: 14.sp,
  //                       //               fontWeight: FontWeight.bold,
  //                       //               color: Colors.white,
  //                       //               decorationColor: Colors.black,
  //                       //               fontFamily: 'poppins')),
  //                       //     ),
  //                       //   ),
  //                       //   onTap: () {
  //                       //
  //                       //     Navigator.pop(context);
  //                       //
  //                       //   },
  //                       // ),
  //                     ]),
  //                 SizedBox(height: 2.h,),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  //   if (Platform.isIOS) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           backgroundColor: Colors.transparent,
  //           child: Container(
  //             width: 70.w,
  //             height: (title == "") ? 15.5.h : 19.h,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(height: 3.h,),
  //                 (title != "") ? Column(
  //                   children: [
  //                     Container(
  //                       padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                       child: Text(
  //                         title,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontSize: 14.sp,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.bold,
  //                             decorationColor: Colors.black,
  //                             fontFamily: 'poppins'),
  //                       ),
  //                     ),
  //                     SizedBox(height: 1.h),
  //                   ],
  //                 ) : Container(),
  //
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                   child: Column(
  //                     children: [
  //                       SizedBox(height: 1.h),
  //                       Text(
  //                         contant,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontSize: 12.sp,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.normal,
  //                             decorationColor: Colors.black,
  //                             fontFamily: 'poppins'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 2.h),
  //                 Divider(
  //                   height: 1.0,
  //                   color: Colors.grey,
  //                 ),
  //                 SizedBox(height: 2.h),
  //                 Row(children: [
  //                   GestureDetector(
  //                     child: Container(
  //                       height: 40.0,
  //                       width: 30.w,
  //                       decoration: BoxDecoration(
  //                         shape: BoxShape.rectangle,
  //                         borderRadius: BorderRadius.circular(20.0),
  //                         color: Color(0xff333389),
  //                       ),
  //                       child: Center(
  //                         child: Text("Yes",
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                                 fontSize: 14.sp,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.white,
  //                                 decorationColor: Colors.black,
  //                                 fontFamily: 'poppins')),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       // Navigator.pop(context);
  //
  //
  //                     },
  //                   ),
  //                   GestureDetector(
  //                     child: Container(
  //                       height: 40.0,
  //                       width: 30.w,
  //                       decoration: BoxDecoration(
  //                         shape: BoxShape.rectangle,
  //                         borderRadius: BorderRadius.circular(20.0),
  //                         color: Color(0xff333389),
  //                       ),
  //                       child: Center(
  //                         child: Text("No",
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                                 fontSize: 14.sp,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.white,
  //                                 decorationColor: Colors.black,
  //                                 fontFamily: 'poppins')),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ]
  //                 ),
  //                 SizedBox(height: 2.h,),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  //   // show the dialog
  // }

  navDialog(BuildContext context, String title, String contant) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 73.w,
              height: (title == "") ? 20.h : 22.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  (title != "") ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ) : Container(),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 40.0,
                            width: 30.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xff333389),
                            ),
                            child: Center(
                              child: Text("Yes",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      decorationColor: Colors.black,
                                      fontFamily: 'poppins')),
                            ),
                          ),
                          onTap: () {
                            buildErrorDialog1(context, "", "We have Receive your request .Order will cancelled only if material is not ready or dispached ");



                          },
                        ),
                        SizedBox(width: 2.w,),
                        GestureDetector(
                          child: Container(
                            height: 40.0,
                            width: 30.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xff333389),
                            ),
                            child: Center(
                              child: Text("No",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      decorationColor: Colors.black,
                                      fontFamily: 'poppins')),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                  SizedBox(height: 2.h,),
                ],
              ),
            ),
          );
        },
      );
    }
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 70.w,
              height: (title == "") ? 15.5.h : 19.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h,),
                  (title != "") ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ) : Container(),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Divider(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 2.h),
                  Row(children: [
                    GestureDetector(
                      child: Container(
                        height: 40.0,
                        width: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xff333389),
                        ),
                        child: Center(
                          child: Text("Yes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decorationColor: Colors.black,
                                  fontFamily: 'poppins')),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40.0,
                        width: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xff333389),
                        ),
                        child: Center(
                          child: Text("No",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decorationColor: Colors.black,
                                  fontFamily: 'poppins')),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ]
                  ),
                  SizedBox(height: 2.h,),
                ],
              ),
            ),
          );
        },
      );
    }
    // show the dialog
  }
  buildErrorDialog1(BuildContext context,String title, String contant,
      {VoidCallback? callback, String? buttonname}) {
    Widget okButton = GestureDetector(
      child: Container(
        height: 35.0,
        width: 30.w,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xff333389),
        ),
        child: Center(
          child: Text(buttonname ?? 'OK',
              textAlign: TextAlign.center,
              style:  TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decorationColor: Colors.black,
                  fontFamily: 'poppins')),
        ),
      ),
      onTap: () {
        cancelrequest();
        // if (callback == null) {
        // Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>your_order()));
        // } else {

        // }
      },
    );

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 73.w,
              height: (title == "")?25.h :50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  (title != "")?Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ):Container(),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal:3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  okButton,
                  SizedBox(height: 2.h,),
                ],
              ),
            ),
          );
        },
      );
    }
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 70.w,
              height: (title == "")?15.5.h :19.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h,),
                  (title != "")?Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ):Container(),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal:3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Divider(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 2.h),
                  okButton,
                  SizedBox(height: 2.h,),
                ],
              ),
            ),
          );
        },
      );
      // CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
      //   title: Text(title,
      //       style: TextStyle(
      //           color: Colors.black,
      //           decorationColor: Colors.black,
      //           fontFamily: 'poppins')),
      //   content: Text(contant,
      //       style: const TextStyle(
      //           color: Colors.black,
      //           decorationColor: Colors.black,
      //           fontFamily: 'poppins')),
      //   actions: [
      //     okButton,
      //   ],
      // );
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return cupertinoAlertDialog;
      //   },
      // );
    }
    // show the dialog
  }

}
