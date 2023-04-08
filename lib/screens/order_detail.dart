import 'dart:convert';

import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/modal_class/order_detail_class.dart';
import 'package:casadealerapp/modal_class/oredrdetail.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/alert_screen.dart';

import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/screens/orderblockdisplay.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class order_detail_c extends StatefulWidget {
  String? oreder;
  int? id;
   order_detail_c({Key? key,this.id,this.oreder}) : super(key: key);

  @override
  State<order_detail_c> createState() => _order_detail_cState();
}

class _order_detail_cState extends State<order_detail_c> {
  TextEditingController _xs =TextEditingController();
  TextEditingController _s =TextEditingController();
  TextEditingController _l =TextEditingController();
  TextEditingController _m =TextEditingController();
  TextEditingController _xl =TextEditingController();
  TextEditingController _xxl =TextEditingController();
  TextEditingController _3xl =TextEditingController();
  TextEditingController _4xl =TextEditingController();
  TextEditingController _5xl =TextEditingController();

  convertblockorder? edit;
  orderdetail? detail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orederdetailapiblock();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffFFFFFF),
      drawer: drawer(context),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                            // SizedBox(
                            //   width: 2.3.h,
                            // ),
                            Container(
                              // padding: EdgeInsets.only(top: 1.5.h),
                              // alignment: Alignment.center,
                              child: Text(
                                "Order Details",
                                style:
                                    TextStyle(fontSize: 2.h, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 14.h,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // _scaffoldKey.currentState?.openDrawer();
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 3.h,
                              ),
                            ),
                            // SizedBox(
                            //   width: 1.h,
                            // ),
                            IconButton(
                              onPressed: () {
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
                      Text("ORDER ID : "+widget.oreder.toString(),
                          style: TextStyle(
                              fontSize: 2.h,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff333389))),
                      Container(
                        alignment: Alignment.center,
                        height: 3.4.h,
                        width: 18.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xfffaede7)),
                        child: Text(
                          'Placed',
                          style: TextStyle(
                              color: Color(0xfff98346),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 69.h,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
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
                                Text(detail?.productData?[int.parse(widget.id.toString())].productName.toString() ?? "N/A",
                                    style: TextStyle(
                                        color: Color(0xff35358a),
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.bold)),
                                Text(detail?.productData?[int.parse(widget.id.toString())].colorName.toString() ?? "N/A",
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
                                      Text(detail?.productData?[int.parse(widget.id.toString())].minPrice.toString() ?? "N/A",
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
                                          detail?.productData?[int.parse(widget.id.toString())].maxPrice.toString() ?? "N/A",
                                        style: TextStyle(
                                          color: Color(0xff35358a),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    orderdetailblockeditapi();

                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 3.5.h,
                                    width: 20.5.w,
                                    child: Text(
                                      'update',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 1.5.h),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xff333389),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                )
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
                                    detail?.productData?[index].gender.toString() ?? "N/A",
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
                                    detail?.productData?[index].warehouseName.toString() ?? "N/A",
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
                            padding: EdgeInsets.symmetric(horizontal: 3.h),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                            padding: EdgeInsets.symmetric(horizontal: 3.h),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _xs,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _s,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _m,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _l,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _xl,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
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
                            padding: EdgeInsets.symmetric(horizontal: 3.h),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                        fontSize: 1.5.h,
                                        color: Color(0XFF50509a),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 0.1.h,
                                  width: 15.w,
                                  // color: Colors.black,
                                ),
                                Container(
                                  height: 0.1.h,
                                  width: 15.w,
                                  // color: Colors.black,
                                ),
                                Container(
                                  height: 0.1.h,
                                  width: 15.w,
                                  // color: Colors.black,
                                ),
                                Container(
                                  height: 0.1.h,
                                  width: 15.w,
                                  // color: Colors.black,
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
                            padding: EdgeInsets.symmetric(horizontal: 3.h),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _xxl,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _3xl,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _4xl,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 3.4.h,
                                  width: 16.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // border: Border.all(color: Colors.black),
                                      border: Border.all()),
                                  child: TextField(
                                    controller: _5xl,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
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
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    color: Color(0Xffeaeaf3),
                                  ),
                                  child: Text(
                                    '8888',
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        color: Color(0Xff50509a),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          // Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: 3.h),
                          //     child: DottedLine(
                          //       direction: Axis.horizontal,
                          //       lineLength: double.infinity,
                          //       lineThickness: 1.0,
                          //       dashLength: 5.0,
                          //       dashColor: Color(0xff8d8d8d),
                          //       // dashGradient: [Colors.red, Colors.blue],
                          //       dashRadius: 0.0,
                          //       dashGapLength: 4.0,
                          //       dashGapColor: Colors.transparent,
                          //       // dashGapGradient: [Colors.red, Colors.blue],
                          //       dashGapRadius: 0.0,
                          //     )),
                          // SizedBox(height: 2.h),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.h),
                          //   child: Container(
                          //     child: Row(
                          //       children: [
                          //         Text('Gender',
                          //             style: TextStyle(
                          //               color: Color(0xff848484),
                          //             )),
                          //         SizedBox(
                          //           width: 2.w,
                          //         ),
                          //         Text(
                          //           'Women',
                          //           style: TextStyle(
                          //               fontSize: 2.3.h,
                          //               color: Color(0xff35358a),
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 2.h),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.h),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           'XS',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           'S',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           'M',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           'L',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           'XL',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          //
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.h),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.h),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           '2XL',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           '3XL',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           '4XL',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         child: Text(
                          //           '5XL',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.only(
                          //               topLeft: Radius.circular(10),
                          //               topRight: Radius.circular(10)),
                          //           color: Color(0Xffeaeaf3),
                          //         ),
                          //         child: Text(
                          //           'TOTAL',
                          //           style: TextStyle(
                          //               fontSize: 1.5.h,
                          //               color: Color(0XFF50509a),
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.h),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         height: 0.1.h,
                          //         width: 15.w,
                          //         // color: Colors.black,
                          //       ),
                          //       Container(
                          //         height: 0.1.h,
                          //         width: 15.w,
                          //         // color: Colors.black,
                          //       ),
                          //       Container(
                          //         height: 0.1.h,
                          //         width: 15.w,
                          //         // color: Colors.black,
                          //       ),
                          //       Container(
                          //         height: 0.1.h,
                          //         width: 15.w,
                          //         // color: Colors.black,
                          //       ),
                          //       Container(
                          //         height: 0.1.h,
                          //         width: 15.w,
                          //         color: Colors.black,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.h),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.4.h,
                          //         width: 16.w,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             // border: Border.all(color: Colors.black),
                          //             border: Border.all()),
                          //         child: TextField(
                          //           textAlign: TextAlign.center,
                          //           keyboardType: TextInputType.number,
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         height: 3.5.h,
                          //         width: 15.w,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.only(
                          //               bottomRight: Radius.circular(10),
                          //               bottomLeft: Radius.circular(10)),
                          //           color: Color(0Xffeaeaf3),
                          //         ),
                          //         child: Text(
                          //           '8888',
                          //           style: TextStyle(
                          //               fontSize: 2.h,
                          //               color: Color(0Xff50509a),
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 6.h,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xfffeaeaf3),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.h),
                              child: Row(
                                children: [
                                  Text(
                                    ' Grand Total:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.h),
                                  ),
                                  Text(
                                    '   ₹99,99,999 + GST',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.h,
                                        color: Color(0xff333389)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                        ],
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: 1.3.h,
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 9.h,
                //   child: Padding(
                //     padding: EdgeInsets.all(2.h),
                //     child: Container(
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           GestureDetector(
                //             onTap: () {
                //               // Navigator.push(
                //               //     context,
                //               //     MaterialPageRoute(
                //               //         builder: (context) =>
                //               //             summary()));
                //               setState(() {
                //                 cart = 1;
                //               });
                //             },
                //             child: Container(
                //               padding: EdgeInsets.all(0.1.h),
                //               alignment: Alignment.center,
                //               width: 40.w,
                //               height: 8.h,
                //               decoration: BoxDecoration(
                //                   color: (cart == 0)
                //                       ? Colors.white
                //                       : Color(0xfff333389),
                //                   borderRadius:
                //                   BorderRadius.circular(20),
                //                   border:
                //                   Border.all(color: Colors.white)),
                //               child: Text(
                //                 'Exit',
                //                 style: TextStyle(
                //                     color: (cart == 0)
                //                         ? Color(0xff333389)
                //                         : Colors.white,
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
                //               // Navigator.push(
                //               //     context,
                //               //     MaterialPageRoute(
                //               //         builder: (context) =>
                //               //             summary())
                //               // );
                //               setState(() {
                //                 cart = 0;
                //               });
                //             },
                //             child: Container(
                //               padding: EdgeInsets.all(0.1.h),
                //               alignment: Alignment.center,
                //               width: 40.w,
                //               height: 8.h,
                //               decoration: BoxDecoration(
                //                   color: (cart == 1)
                //                       ? Colors.white
                //                       : Color(0xfff333389),
                //                   // color:_selectedColor,
                //
                //                   borderRadius:
                //                   BorderRadius.circular(20),
                //                   border:
                //                   Border.all(color: Colors.white)),
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
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     // borderRadius: BorderRadius.all(
                //     //   Radius.circular(10),
                //     // ),
                //     boxShadow: [
                //       BoxShadow(
                //         blurRadius: 15.0,
                //       ),
                //     ],
                //   ),
                // ),

                // Padding(
                //   padding: EdgeInsets.all(2.h),
                //   child: Container(
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => order_id()));
                //             setState(() {});
                //           },
                //           child: Container(
                //             padding: EdgeInsets.all(0.1.h),
                //             alignment: Alignment.center,
                //             width: 40.w,
                //             height: 6.h,
                //             decoration: BoxDecoration(
                //                 color: Color(0xfff333389),
                //                 borderRadius: BorderRadius.circular(8),
                //                 border: Border.all(color: Color(0xff333389))),
                //             child: Text(
                //               'Convert to Order',
                //               style: TextStyle(
                //                   color: Colors.white,
                //
                //                   // fontWeight: FontWeight.bold,
                //                   fontSize: 2.h),
                //             ),
                //           ),
                //         ),
                //         // SizedBox(
                //         //   width: 0.6.h,
                //         // ),
                //         GestureDetector(
                //           onTap: () {
                //             setState(() {});
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => alert_screen()));
                //           },
                //           child: Container(
                //             padding: EdgeInsets.all(0.1.h),
                //             alignment: Alignment.center,
                //             width: 40.w,
                //             height: 6.h,
                //             decoration: BoxDecoration(
                //                 color: Color(0xfff333389),
                //                 // color:_selectedColor,
                //
                //                 borderRadius: BorderRadius.circular(8),
                //                 border: Border.all(color: Color(0xff333389))),
                //             child: Text(
                //               'Unblock Order',
                //               style: TextStyle(
                //                   color: Colors.white,
                //
                //                   // fontWeight: FontWeight.bold,
                //                   fontSize: 2.h),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
  orederdetailapiblock(){
    final Map<String, String> data = {};
    data['action'] = 'order_details';
    data['order_no'] = widget.oreder.toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .oredrdetailap(data)
            .then((Response response) async {
          detail = orderdetail.fromJson(json.decode(response.body));


          if (response.statusCode == 200 && detail?.status == "success") {
            setState(() {
              _s.text =detail?.productData?[int.parse(widget.id.toString())].s.toString() ?? "0";
              _xs.text =detail?.productData?[int.parse(widget.id.toString())].xs.toString() ?? "0";
              _m.text =detail?.productData?[int.parse(widget.id.toString())].m.toString() ?? "0";
              _l.text =detail?.productData?[int.parse(widget.id.toString())].l.toString() ?? "0";
              _xl.text =detail?.productData?[int.parse(widget.id.toString())].xl.toString() ?? "0";
              _xxl.text =detail?.productData?[int.parse(widget.id.toString())].xxl.toString() ?? "0";
              _3xl.text =detail?.productData?[int.parse(widget.id.toString())].s3xl.toString() ?? "0";
              _4xl.text =detail?.productData?[int.parse(widget.id.toString())].s4xl.toString() ?? "0";
              _5xl.text =detail?.productData?[int.parse(widget.id.toString())].s5xl.toString() ?? "0";

            });


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
  orderdetailblockeditapi(){
    final Map<String, String> data = {};
    data['action'] = 'order_edit_stock';
    data['order_no'] = widget.oreder.toString();
    data['ap_id']= detail?.productData?[int.parse(widget.id.toString())].apId.toString() ?? "0" ;
    data['apd_id']= detail?.productData?[int.parse(widget.id.toString())].apId.toString() ?? "0" ;
    data['xs_order_q'] = _xs.text== "" ? "0" : _xs.text.toString() ;
    data['s_order_q'] = _xs.text== "" ? "0" : _s.text.toString() ;
    data['m_order_q'] = _m.text== "" ? "0" : _m.text.toString() ;
    data['l_order_q'] = _l.text== "" ? "0" : _l.text.toString() ;
    data['xl_order_q'] = _xl.text== "" ? "0" : _xl.text.toString() ;
    data['xxl_order_q'] = _xxl.text== "" ? "0" : _xxl.text.toString() ;
    data['3xl_order_q'] = _3xl.text== "" ? "0" : _3xl.text.toString() ;
    data['4xl_order_q'] = _4xl.text== "" ? "0" : _4xl.text.toString() ;
    data['5xl_order_q'] = _5xl.text== "" ? "0" : _5xl.text.toString() ;
print(data);
   checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .orderdetaildetailedit(data)
            .then((Response response) async {
          edit = convertblockorder.fromJson(json.decode(response.body));

print(edit?.status);
          if (response.statusCode == 200 && edit?.status == "success") {
            setState(() {

            });

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>orderblockdisplay(id: widget?.oreder.toString(),)));
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
