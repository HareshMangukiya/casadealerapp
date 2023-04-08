import 'dart:convert';

import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/summarEditBlock.dart';
import 'package:casadealerapp/modal_class/summaryEditCart.dart';
import 'package:casadealerapp/modal_class/view_block_single_product_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';

import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/build_dialog.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class summary_b_edit extends StatefulWidget {
  int? index;
  int? select;
  double? totalm;
  double? totalt;
  double? grandtotal;

   summary_b_edit({Key? key,  this.select,this.index,this.grandtotal,this.totalm,this.totalt
   }) : super(key: key);

  @override
  State<summary_b_edit> createState() => _summary_b_editState();
}

class _summary_b_editState extends State<summary_b_edit> {
  viewBlockProduct? blockView;
  ViewCart? viewaddtocart;
  RegExp regex = RegExp(r'^\d+$');
  // Mumbai contriller
  TextEditingController _search = TextEditingController();
  TextEditingController _xs = TextEditingController();
  TextEditingController _m = TextEditingController();
  TextEditingController _s = TextEditingController();
  TextEditingController _l = TextEditingController();
  TextEditingController _xl = TextEditingController();
  TextEditingController _xxl = TextEditingController();
  TextEditingController _3xl = TextEditingController();
  TextEditingController _4xl = TextEditingController();
  TextEditingController _5xl = TextEditingController();

  //Tripur controller

  TextEditingController _txs = TextEditingController();
  TextEditingController _tm = TextEditingController();
  TextEditingController _ts = TextEditingController();
  TextEditingController _tl = TextEditingController();
  TextEditingController _txl = TextEditingController();
  TextEditingController _txxl = TextEditingController();
  TextEditingController _t3xl = TextEditingController();
  TextEditingController _t4xl = TextEditingController();
  TextEditingController _t5xl = TextEditingController();

  summryEditBlockProduct? summeryeditblock;
  summryEditCartProduct? summaryeditcart;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? check = false;
  int sum = 0;
  List<String> tabs = ["Blocked", "Cart"];
  int cart = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("=========" +widget.select.toString());
    sumindex1 = (widget.select==0) ? 0 :1;
    (widget.select==0) ? viewBlockSummary() : viewcart() ;
}
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
                              ),
                            ),
                            SizedBox(
                              width: 2.3.h,
                            ),
                            Container(
                              // padding: EdgeInsets.only(top: 1.5.h),
                              // alignment: Alignment.center,
                              child: Text(
                                "Summary",
                                style:
                                    TextStyle(fontSize: 2.h, color: Colors.white),
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Color(0xfff9e9ec7))),
                alignment: Alignment.center,
                height: 6.5.h,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            sumindex1 = index;
                          });
                          // sumindex1 == 0 ? viewBlockSummary(): viewcart();
                        },
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (sumindex1 == index)
                                    ? Color(0xfff333389)
                                    : Color(0xfffFFFFFF),
                              ),

                              height: 5.h,
                              width: 44.w,
                              margin:
                                  EdgeInsets.only(right: 0.1.w, top: 0.6.h),

                              // padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.h),
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: (sumindex1 != index)
                                      ? Colors.grey.shade600
                                      : Color(0xffffffff),
                                ),
                              ),
                            ),

                          ],
                        ),
                      );
                    }),
              ),
            ),
            (sumindex1 == 0)
                ? Column(
                    children: [
                      Container(
                        height: 70.h,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text((blockView?.dataProduct?[int.parse((widget.index).toString())].productName).toString(),
                                          style: TextStyle(
                                              color: Color(0xff35358a),
                                              fontSize: 2.h,
                                              fontWeight: FontWeight.bold)),
                                      Text((blockView?.dataProduct?[int.parse((widget.index).toString())].colorName).toString(),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Price',
                                      style:
                                          TextStyle(color: Color(0xff848484)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0 ?
                                               ( blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].price?[0].minPrice).toString()
                                                : (blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].price?[0].minPrice).toString(),
                                                style: TextStyle(
                                                    color: Color(0xff35358a),
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                              blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0 ?
                                              ( blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].price?[0].maxPrice).toString()
                                                  : (blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].price?[0].maxPrice).toString(),
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


                                          editBlock();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 3.5.h,
                                          width: 20.5.w,
                                          child: Text(
                                            'Update',
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Divider(
                                    height: 3.h,
                                    thickness: 0.3.w,
                                    color: Color(0xff50509a),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                          (blockView?.dataProduct?[int.parse((widget.index).toString())].gender).toString(),
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
                                          'Mumbai',
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                         "TOTAL",
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                              bottomRight:
                                                  Radius.circular(10),
                                              bottomLeft:
                                                  Radius.circular(10)),
                                          color: Color(0Xffeaeaf3),
                                        ),
                                        child: Text(
                                        (widget.totalm).toString(),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.h),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                          'Tripur',
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
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _txs,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _ts,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _tm,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _tl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _txl,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _txxl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _t3xl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _t4xl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _t5xl,
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
                                              bottomRight:
                                                  Radius.circular(10),
                                              bottomLeft:
                                                  Radius.circular(10)),
                                          color: Color(0Xffeaeaf3),
                                        ),
                                        child: Text(
                                          (widget.totalt).toString(),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' Grand Total:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 2.h),
                                        ),
                                        Text(
                                          ' ₹ '+(widget.grandtotal).toString(),
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 9.h,
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => summary()));
                                    setState(() {
                                      cart = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(0.1.h),
                                    alignment: Alignment.center,
                                    width: 40.w,
                                    height: 8.h,
                                    decoration: BoxDecoration(
                                        color: (cart == 0)
                                            ? Colors.white
                                            : Color(0xfff333389),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Text(
                                      'Exit',
                                      style: TextStyle(
                                          color: (cart == 0)
                                              ? Color(0xff333389)
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 2.2.h),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => your_block_order()));
                                    setState(() {
                                      cart = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(0.1.h),
                                    alignment: Alignment.center,
                                    width: 40.w,
                                    height: 8.h,
                                    decoration: BoxDecoration(
                                        color: (cart == 1)
                                            ? Colors.white
                                            : Color(0xfff333389),
                                        // color:_selectedColor,

                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                          color: (cart == 1)
                                              ? Color(0xff333389)
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 2.2.h),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.all(
                          //   Radius.circular(10),
                          // ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Column(
                    children: [
                      Container(
                        height: 70.h,
                        child: ListView.builder(
                          // padding: EdgeInsets.all(0),
                          // visualDensity: VisualDensity(horizontal: 4, vertical: 4),
                          // horizontalTitleGap: 0.0,

                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].productName ?? "N/A",
                                          style: TextStyle(
                                              color: Color(0xff35358a),
                                              fontSize: 2.h,
                                              fontWeight: FontWeight.bold)),
                                      Text(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].colorName ?? "N/A",
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Price',
                                      style:
                                          TextStyle(color: Color(0xff848484)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text( viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length ==0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice) != 0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString() : "N/A" :
                                            viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].price?[0].minPrice != 0 ? (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString() : "N/A",
                                                style: TextStyle(
                                                    color: Color(0xff35358a),
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                              viewaddtocart?.dataProduct?[index].mumbaiStock?.length ==0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice) != 0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString() : "N/A" :
                                              viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice != 0 ? (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString() : "N/A",
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
                                          editCart();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 3.5.h,
                                          width: 20.5.w,
                                          child: Text(
                                            'Update',
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Divider(
                                    height: 3.h,
                                    thickness: 0.3.w,
                                    color: Color(0xff50509a),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                         viewaddtocart?.dataProduct?[index].gender ?? "N/A",
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
                                          'Mumbai',
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                              bottomRight:
                                                  Radius.circular(10),
                                              bottomLeft:
                                                  Radius.circular(10)),
                                          color: Color(0Xffeaeaf3),
                                        ),
                                        child: Text(
                                          widget.totalm.toString(),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.h),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                          'Tripur',
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

                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _txs,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _ts,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _tm,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _tl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _txl,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.4.h,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _txxl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _t3xl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _t4xl,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // border: Border.all(color: Colors.black),
                                            border: Border.all()),
                                        child: TextField(
                                          controller: _t5xl,
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
                                              bottomRight:
                                                  Radius.circular(10),
                                              bottomLeft:
                                                  Radius.circular(10)),
                                          color: Color(0Xffeaeaf3),
                                        ),
                                        child: Text(
                                        widget.totalt.toString(),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' Grand Total:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 2.h),
                                        ),
                                        Text(
                                          widget.grandtotal.toString(),
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 9.h,
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => summary()));
                                    setState(() {
                                      cart = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(0.1.h),
                                    alignment: Alignment.center,
                                    width: 40.w,
                                    height: 8.h,
                                    decoration: BoxDecoration(
                                        color: (cart == 0)
                                            ? Colors.white
                                            : Color(0xfff333389),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Text(
                                      'Exit',
                                      style: TextStyle(
                                          color: (cart == 0)
                                              ? Color(0xff333389)
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 2.2.h),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => your_order()));
                                    setState(() {
                                      cart = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(0.1.h),
                                    alignment: Alignment.center,
                                    width: 40.w,
                                    height: 8.h,
                                    decoration: BoxDecoration(
                                        color: (cart == 1)
                                            ? Colors.white
                                            : Color(0xfff333389),
                                        // color:_selectedColor,

                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                          color: (cart == 1)
                                              ? Color(0xff333389)
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 2.2.h),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.all(
                          //   Radius.circular(10),
                          // ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }



  editBlock() async {
    final Map<String, String> data = {};
    data['action'] = 'edit_block_single_product';
    data['t_ap_id'] = blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length == 0? "0"  :(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].tApId).toString();
    data['t_apd_id'] =blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length == 0? "0"  :(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].tApdId).toString();
    data['m_ap_id'] = blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0? "0"  :(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].mApId).toString();;
    data['m_apd_id'] = blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0? "0"  :(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].mApdId).toString();
    data['d_id'] = (userData?.logindata?.dId).toString();
    data['gender_type'] =(blockView?.dataProduct?[int.parse((widget.index).toString())].gender).toString();
    //Mumbai Data
    data['m_xs'] =
    _xs.text.trim().toString() == "" ? "0" : _xs.text.trim().toString();

    data['m_s'] =
    _s.text.trim().toString() == "" ? "0" : _s.text.trim().toString();
    data['m_m'] =
    _m.text.trim().toString() == "" ? "0" : _m.text.trim().toString();
    data['m_l'] =
    _l.text.trim().toString() == "" ? "0" : _l.text.trim().toString();
    data['m_xl'] =
    _xl.text.trim().toString() == "" ? "0" : _xl.text.trim().toString();
    data['m_xxl'] =
    _xxl.text.trim().toString() == "" ? "0" : _xxl.text.trim().toString();
    data['m_3xl'] =
    _3xl.text.trim().toString() == "" ? "0" : _3xl.text.trim().toString();
    data['m_4xl'] =
    _4xl.text.trim().toString() == "" ? "0" : _4xl.text.trim().toString();
    data['m_5xl'] =
    _5xl.text.trim().toString() == "" ? "0" : _5xl.text.trim().toString();

    //Tripur  Data

    data['t_xs'] =
    _txs.text.trim().toString() == "" ? "0" : _txs.text.trim().toString();
    data['t_s'] =
    _ts.text.trim().toString() == "" ? "0" : _ts.text.trim().toString();
    data['t_m'] =
    _tm.text.trim().toString() == "" ? "0" : _tm.text.trim().toString();
    data['t_l'] =
    _tl.text.trim().toString() == "" ? "0" : _tl.text.trim().toString();
    data['t_xl'] =
    _txl.text.trim().toString() == "" ? "0" : _txl.text.trim().toString();
    data['t_xxl'] =
    _txxl.text.trim().toString() == "" ? "0" : _txxl.text.trim().toString();
    data['t_3xl'] =
    _t3xl.text.trim().toString() == "" ? "0" : _t3xl.text.trim().toString();
    data['t_4xl'] =
    _t4xl.text.trim().toString() == "" ? "0" : _t4xl.text.trim().toString();
    data['t_5xl'] =
    _t5xl.text.trim().toString() == "" ? "0" : _t5xl.text.trim().toString();

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .summeryEditBlockProvider(data)
            .then((Response response) async {
          summeryeditblock = summryEditBlockProduct.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && summeryeditblock?.status == "success") {

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>summary()));
            if (kDebugMode) {}
          } else {
            buildErrorDialog1(this.context, "",  'Already product added to cart',1);
          }
        });
      } else {
      }
    });
  }
  editCart() async {
    final Map<String, String> data = {};
    data['action'] = 'edit_add_to_cart_single_product';
    data['t_ap_id'] = viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length == 0? "0"  :(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].tApId).toString();
    data['t_apd_id'] =viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length == 0? "0"  :(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].tApdId).toString();
    data['m_ap_id'] = viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0? "0"  :(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].mApId).toString();;
    data['m_apd_id'] = viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0? "0"  :(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].mApdId).toString();
    data['d_id'] = (userData?.logindata?.dId).toString();
    data['gender_type'] =(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].gender).toString();
    //Mumbai Data
    data['m_xs'] =
    _xs.text.trim().toString() == "" ? "0" : _xs.text.trim().toString();

    data['m_s'] =
    _s.text.trim().toString() == "" ? "0" : _s.text.trim().toString();
    data['m_m'] =
    _m.text.trim().toString() == "" ? "0" : _m.text.trim().toString();
    data['m_l'] =
    _l.text.trim().toString() == "" ? "0" : _l.text.trim().toString();
    data['m_xl'] =
    _xl.text.trim().toString() == "" ? "0" : _xl.text.trim().toString();
    data['m_xxl'] =
    _xxl.text.trim().toString() == "" ? "0" : _xxl.text.trim().toString();
    data['m_3xl'] =
    _3xl.text.trim().toString() == "" ? "0" : _3xl.text.trim().toString();
    data['m_4xl'] =
    _4xl.text.trim().toString() == "" ? "0" : _4xl.text.trim().toString();
    data['m_5xl'] =
    _5xl.text.trim().toString() == "" ? "0" : _5xl.text.trim().toString();

    //Tripur  Data

    data['t_xs'] =
    _txs.text.trim().toString() == "" ? "0" : _txs.text.trim().toString();
    data['t_s'] =
    _ts.text.trim().toString() == "" ? "0" : _ts.text.trim().toString();
    data['t_m'] =
    _tm.text.trim().toString() == "" ? "0" : _tm.text.trim().toString();
    data['t_l'] =
    _tl.text.trim().toString() == "" ? "0" : _tl.text.trim().toString();
    data['t_xl'] =
    _txl.text.trim().toString() == "" ? "0" : _txl.text.trim().toString();
    data['t_xxl'] =
    _txxl.text.trim().toString() == "" ? "0" : _txxl.text.trim().toString();
    data['t_3xl'] =
    _t3xl.text.trim().toString() == "" ? "0" : _t3xl.text.trim().toString();
    data['t_4xl'] =
    _t4xl.text.trim().toString() == "" ? "0" : _t4xl.text.trim().toString();
    data['t_5xl'] =
    _t5xl.text.trim().toString() == "" ? "0" : _t5xl.text.trim().toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .summeryEditCartProvider(data)
            .then((Response response) async {
          summaryeditcart = summryEditCartProduct.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && summaryeditcart?.status == "success") {

            if (kDebugMode) {}
          } else {
            buildErrorDialog1(this.context, "",  'Already product added to cart',1);
          }
        });
      } else {
      }
    });
  }
  viewBlockSummary() async {
    final Map<String, String> data = {};
    data['action'] = 'view_block_product_single';

    data['d_id'] = (userData?.logindata?.dId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().summaryBlockViewProvider(data).then((Response response) async {
          blockView = viewBlockProduct.fromJson(json.decode(response.body));
          print(blockView?.status);
          if (response.statusCode == 200 &&
              blockView?.status == "success") {
           if (blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length !=0 ){
              _s.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].sBlock).toString();
              _xs.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].xsBlock).toString();
              _l.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].lBlock).toString();
              _m.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].mBlock).toString();
              _xl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].xlBlock).toString();
              _xxl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].xxlBlock).toString();
              _3xl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].s3xlBlock).toString();
              _4xl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].s4xlBlock).toString();
              _5xl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].s5xlBlock).toString();
           }
           else{
             _s.text = "0";
             _xs.text = "0";
             _m.text = "0";
             _l.text = "0";
             _xl.text = "0";
             _xxl.text = "0";
             _3xl.text = "0";
             _4xl.text = "0";
             _5xl.text = "0";

           }
           if (blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length !=0 ){
             _ts.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].sBlock).toString();
             _txs.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].xsBlock).toString();
             _tl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].lBlock).toString();
             _tm.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].mBlock).toString();
             _txl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].xlBlock).toString();
             _txxl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].xxlBlock).toString();
             _t3xl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].s3xlBlock).toString();
             _t4xl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].s4xlBlock).toString();
             _t5xl.text=(blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].s5xlBlock).toString();
           }
           else{
             _ts.text = "0";
             _txs.text = "0";
             _tm.text = "0";
             _tl.text = "0";
             _txl.text = "0";
             _txxl.text = "0";
             _t3xl.text = "0";
             _t4xl.text = "0";
             _t5xl.text = "0";
           }
            setState(() {

            });
            if (kDebugMode) {
            }
          } else {
          }
        });
      } else {
      }
    });
  }
  viewcart()async {
    final Map<String, String> data = {};
    data['action'] = 'view_add_to_cart_product_single';
    // data['product_name'] = widget.pronamenevigatior.toString();
    // data['gender_type'] = widget.gender.toString();
    // data['color_name'] =  widget.coloridnevigator.toString();
    data['d_id'] = (userData?.logindata?.dId).toString();


    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().viewcartapi(data).then((Response response) async {
          viewaddtocart = ViewCart.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && viewaddtocart?.status == "success") {
            if (viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length !=0 ){
              _s.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].sBlock).toString();
              _xs.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].xsBlock).toString();
              _l.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].lBlock).toString();
              _m.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].mBlock).toString();
              _xl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].xlBlock).toString();
              _xxl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].xxlBlock).toString();
              _3xl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].s3xlBlock).toString();
              _4xl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].s4xlBlock).toString();
              _5xl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].s5xlBlock).toString();
            }
            else{
              _s.text = "0";
              _xs.text = "0";
              _m.text = "0";
              _l.text = "0";
              _xl.text = "0";
              _xxl.text = "0";
              _3xl.text = "0";
              _4xl.text = "0";
              _5xl.text = "0";

            }
            if (viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length !=0 ){
              _ts.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].sBlock).toString();
              _txs.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].xsBlock).toString();
              _tl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].lBlock).toString();
              _tm.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].mBlock).toString();
              _txl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].xlBlock).toString();
              _txxl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].xxlBlock).toString();
              _t3xl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].s3xlBlock).toString();
              _t4xl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].s4xlBlock).toString();
              _t5xl.text=(viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].s5xlBlock).toString();
            }
            else{
              _ts.text = "0";
              _txs.text = "0";
              _tm.text = "0";
              _tl.text = "0";
              _txl.text = "0";
              _txxl.text = "0";
              _t3xl.text = "0";
              _t4xl.text = "0";
              _t5xl.text = "0";
            }
            setState(() {
            });
            if (kDebugMode) {
            }
          } else {
          }
        });
      } else {
      }
    });
  }
}

