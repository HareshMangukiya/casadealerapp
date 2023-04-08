import 'package:casadealerapp/screens/alert_screen.dart';

import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class order_detail_c extends StatefulWidget {
  const order_detail_c({Key? key}) : super(key: key);

  @override
  State<order_detail_c> createState() => _order_detail_cState();
}

class _order_detail_cState extends State<order_detail_c> {
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
                      Text('Order ID#1234',
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
                    // padding: EdgeInsets.all(0),
                    // visualDensity: VisualDensity(horizontal: 4, vertical: 4),
                    // horizontalTitleGap: 0.0,

                    itemCount: 2,
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
                                Text('Ruffty Tipping',
                                    style: TextStyle(
                                        color: Color(0xff35358a),
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.bold)),
                                Text('Bottle Green',
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
                                      Text(' ₹250',
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
                                        ' ₹280',
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
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             summary_b_edit()));
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
                                    'Male',
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
                          // Padding(
                          //   padding:
                          //   EdgeInsets.symmetric(horizontal: 2.h),
                          //   // child: Row(
                          //   //   crossAxisAlignment:
                          //   //       CrossAxisAlignment.center,
                          //   //   mainAxisAlignment:
                          //   //       MainAxisAlignment.spaceAround,
                          //   //   children: [
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //   ],
                          //   // ),
                          // ),
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
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.h),
                              child: DottedLine(
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
                              )),
                          SizedBox(height: 2.h),
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
                                    'Women',
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
                          // Padding(
                          //   padding:
                          //   EdgeInsets.symmetric(horizontal: 2.h),
                          //   // child: Row(
                          //   //   crossAxisAlignment:
                          //   //       CrossAxisAlignment.center,
                          //   //   mainAxisAlignment:
                          //   //       MainAxisAlignment.spaceAround,
                          //   //   children: [
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     Container(
                          //   //       height: 0.1.h,
                          //   //       width: 15.w,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //   ],
                          //   // ),
                          // ),
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
                          SizedBox(
                            height: 2.h,
                          ),
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

                Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => order_id()));
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(0.1.h),
                            alignment: Alignment.center,
                            width: 40.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: Color(0xfff333389),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xff333389))),
                            child: Text(
                              'Convert to Order',
                              style: TextStyle(
                                  color: Colors.white,

                                  // fontWeight: FontWeight.bold,
                                  fontSize: 2.h),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 0.6.h,
                        // ),
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => alert_screen()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(0.1.h),
                            alignment: Alignment.center,
                            width: 40.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: Color(0xfff333389),
                                // color:_selectedColor,

                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xff333389))),
                            child: Text(
                              'Unblock Order',
                              style: TextStyle(
                                  color: Colors.white,

                                  // fontWeight: FontWeight.bold,
                                  fontSize: 2.h),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
