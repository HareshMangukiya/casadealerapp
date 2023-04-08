import 'dart:convert';


import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/modal_class/order_detail_class.dart';
import 'package:casadealerapp/modal_class/oredrdetail.dart';
import 'package:casadealerapp/provider/productprovider.dart';

import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class order_id extends StatefulWidget {
  String? id;
  int? index1;
   order_id({
    Key? key,this.id,this.index1
  }) : super(key: key);

  @override
  State<order_id> createState() => _order_idState();
}

class _order_idState extends State<order_id> {
orderdetail? detail;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  int? sub_total;
  int? gst;
  int? payable_amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    orederdetailapiblock();
  }
int? total1=0;
int? total2 = 0;
double? price =0.0;
double? gtotal =0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffFFFFFF),
      drawer: drawer(context),
      key: _scaffoldKey,
      body: Column(
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
                      //
                      SizedBox(
                        width: 2.3.h,
                      ),
                      Container(
                        // padding: EdgeInsets.only(top: 1.5.h),
                        // alignment: Alignment.center,
                        child: Text(
                          "Your Orders",
                          style: TextStyle(fontSize: 2.h, color: Colors.white),
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
                          // _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 3.h,
                        ),
                      ),
                      SizedBox(
                        width: 1.h,
                      ),
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
                      "ORDER ID : "+widget.id.toString(),

                    style: TextStyle(
                        fontSize: 2.h,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333389)
                    )),
                // Container(
                //   padding: EdgeInsets.all(0.6.h),
                //   alignment: Alignment.center,
                //   height: 3.4.h,
                //   width: 21.w,
                //   decoration: BoxDecoration(
                //       borderRadius:
                //       BorderRadius.circular(15),
                //       color: (detail?.productData?[(widget.index.toString())]. ==
                //           "1")
                //           ? Color(0xfffaede7)
                //           : (detail?.orderData?.status ==
                //           "2")
                //           ? Color(0xffe1f5e2)
                //           : Color(0xfffae7e7)),
                //   child: Text(
                //     (detail?.orderData?.status == "1")
                //         ? "Placed"
                //         : (detail?.orderData?.status == "2")
                //         ? "Confirmed"
                //         : "Cancle",
                //     // 'Placed',
                //     style: TextStyle(
                //         color: (detail?.orderData?.status ==
                //             "1")
                //             ? Color(0xfff98b54)
                //             : (detail?.orderData?.status ==
                //             "2")
                //             ? Color(0xff48d34d)
                //             : Color(0xfff97070),
                //         fontWeight: FontWeight.bold),
                //   ),
                // )
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
              itemCount: detail?.productData?.length,
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
                          Text(detail?.productData?[index].productName.toString() ?? "N/A",
                              style: TextStyle(
                                  color: Color(0xff35358a),
                                  fontSize: 2.h,
                                  fontWeight: FontWeight.bold)),
                          Text(detail?.productData?[index].colorName.toString() ?? "N/A",
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
                                Text(detail?.productData?[index].minPrice.toString() ?? "N/A",
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
                                  detail?.productData?[index].maxPrice.toString() ?? "N/A",
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
                              // Navigator.push(
                              //     context,
                                  // MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         order_detail_c(
                                  //             oreder :widget.id.toString(),
                                  //             id:index
                                  //         )));
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
                              (detail?.productData?[index].xs).toString(),
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
                              (detail?.productData?[index].s).toString(),
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
                              (detail?.productData?[index].m).toString(),
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
                              (detail?.productData?[index].l).toString(),
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
                              (detail?.productData?[index].l).toString(),
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
                                  fontSize: 1.5.h,
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
                              (detail?.productData?[index].xxl).toString(),
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
                              (detail?.productData?[index].s3xl).toString(),
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
                              (detail?.productData?[index].s4xl).toString(),
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
                              (detail?.productData?[index].s5xl).toString(),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: Color(0Xffeaeaf3),
                            ),
                            child: Text(
                              "₹" + price.toString(),
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
        ],
      ),

      Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => summary_b_edit()));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff333389),
                ),
                height: 6.h,
                width: 40.w,
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              cancelrequest();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => products_1()));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff333389),
              ),
              height: 6.h,
              width: 40.w,
              child: Text(
                'Cancle Request',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      )

      //
    ],
      ),
    );
  }

  orederdetailapiblock(){
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
            setState(() {
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
cancelrequest(){
  final Map<String, String> data = {};
  data['action'] = 'cancle_order_request';
  data['order_no'] = widget.id.toString();
  data['d_id'] =(userData?.logindata?.dId).toString();

  print(data);
  checkInternet().then((internet) async {
    if (internet) {
      Productprovider()
          .canclerequestapi(data)
          .then((Response response) async {
        convertblockorder edit = convertblockorder.fromJson(json.decode(response.body));
        print(edit.status);

        if (response.statusCode == 200 && edit?.status == "success") {
          setState(() {
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

}
