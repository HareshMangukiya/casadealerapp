import 'dart:convert';

import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class viewcartpage extends StatefulWidget {
  String? pronamenevigatior;
  String? coloridnevigator;
  String? gender;
   viewcartpage({Key? key,this.pronamenevigatior,this.coloridnevigator,this.gender}) : super(key: key);

  @override
  State<viewcartpage> createState() => _viewcartpageState();
}

class _viewcartpageState extends State<viewcartpage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? check = false;
  int sum = 0;
  int sumindex = 0;
  List<String> tabs = ["Blocked", "Cart"];
  int cart = 0;
  ViewCart? viewaddtocart;
  double? grandtotalv= 0.0;
  int? total1vm=0;
  int? total2vm = 0;
  int? total1vt=0;
  int? total2vt = 0;
  double? pricevm=0.0;
  double? pricevt= 0.0;
  double? gtotalv=0.0;
  double? gstv =0.0;

  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewcart();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70.h,
        child:(viewaddtocart?.status == "fail")?Center(child: Text("No Product Added To Cart.",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontFamily: "Poppins",fontWeight: FontWeight.bold),)):ListView.builder(
            itemCount:viewaddtocart?.dataProduct?.length,
            scrollDirection: Axis.vertical,
            itemBuilder:(context,index){

              return Column(
                children: [
                  // SizedBox(height: 1.h),
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
                        Text(
                            viewaddtocart?.dataProduct?[index].productName ?? "N/A",

                            style: TextStyle(
                                color: Color(0xff35358a),
                                fontSize: 2.h,
                                fontWeight: FontWeight.bold)),
                        Text( viewaddtocart?.dataProduct?[index].colorName ?? "N/A",
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
                              Text(  viewaddtocart?.dataProduct?[index].mumbaiStock?.length ==0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice) != 0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString() : "N/A" :
                              viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice != 0 ? (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString() : "N/A",
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>

                                            summary_b_edit(
                                              select: 1,
                                             index:index,
                                              totalm : pricevm,
                                              totalt : pricevt,
                                              grandtotal : gtotalv,
                                            )));

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
                    padding:
                    EdgeInsets.symmetric(horizontal: 3.h),
                    child: Divider(
                      height: 3.h,
                      thickness: 0.3.w,
                      color: Color(0xff50509a),
                    ),
                  ),
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
                                        viewaddtocart?.dataProduct?[index].gender ?? "",
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
                                        "Mumbai",
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
                         viewaddtocart?.dataProduct?[index].mumbaiStock?.length ==0  ?Text("No Mumbai stock Added to cart"):Column(
                            children: [
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].xsBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].sBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].mBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].lBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].xlBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].xxlBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].s3xlBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].s4xlBlock).toString(),
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
                                        (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].s5xlBlock).toString(),
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
                                        pricevm.toString(),
                                        style: TextStyle(
                                            fontSize: 2.h,
                                            color: Color(0Xff50509a),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                        "Tirupur",
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
                  viewaddtocart?.dataProduct?[index].tirupurStock?.length ==0  ?Text("No Tirupur stock Added to cart"): Column(
                    children: [
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].xsBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].sBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].mBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].lBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].xlBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].xxlBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].s3xlBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].s4xlBlock).toString(),
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
                                (viewaddtocart?.dataProduct?[index].tirupurStock?[0].s5xlBlock).toString(),
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
                                pricevt.toString(),
                                style: TextStyle(
                                    fontSize: 2.h,
                                    color: Color(0Xff50509a),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  Container(
                    alignment: Alignment.centerLeft,
                    height: 6.h,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xfffeaeaf3),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 2.h),
                      child: Row(
                        children: [
                          Text(
                            ' Grand Total :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 2.h),
                          ),
                          Text(
                               "₹" + gtotalv.toString() + '+ GST',
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
            }),
      )

    );



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

          if (response.statusCode == 200 &&
              viewaddtocart?.status == "success") {
            for(int index=0 ; index<(viewaddtocart?.dataProduct?.length ?? 0) ; index++) {
              if (viewaddtocart?.dataProduct?[index].mumbaiStock?.length != 0) {
                total1vm = int.parse(
                    viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .xsBlock ?? "0") +
                    int.parse(viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .sBlock ?? "0") +
                    int.parse(viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .mBlock ?? "0") +
                    int.parse(viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .lBlock ?? "0") +
                    int.parse(viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .xlBlock ?? "0") +
                    int.parse(viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .xxlBlock ?? "0") +
                    int.parse(viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .s3xlBlock ?? "0");
                total2vm = int.parse(
                    viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .s4xlBlock ?? "0") +
                    int.parse(viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                        .s5xlBlock ?? "0");
              }
              if (viewaddtocart?.dataProduct?[index].tirupurStock?.length !=
                  0) {
                total1vt = int.parse(
                    viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                        .xsBlock ?? "0") +
                    int.parse(
                        viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                            .sBlock ?? "0") +
                    int.parse(
                        viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                            .mBlock ?? "0") +
                    int.parse(
                        viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                            .lBlock ?? "0") +
                    int.parse(
                        viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                            .xlBlock ?? "0") +
                    int.parse(
                        viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                            .xxlBlock ?? "0") +
                    int.parse(
                        viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                            .s3xlBlock ?? "0");
                total2vt = int.parse(
                    viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                        .s4xlBlock ?? "0") +
                    int.parse(
                        viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                            .s5xlBlock ?? "0");
              }
              pricevm = double.parse(total1vm.toString()) *
                  ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0)
                      ? (double.parse((viewaddtocart?.dataProduct?[index]
                      .tirupurStock?[0].price?[0].minPrice).toString()) <= 0
                      ? 0
                      : double.parse(
                      (viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                          .price?[0].minPrice).toString()))
                      : (double.parse((viewaddtocart?.dataProduct?[index]
                      .mumbaiStock?[0].price?[0].minPrice).toString()) <= 0
                      ? 0
                      : double.parse(
                      (viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                          .price?[0].minPrice).toString()))) +
                  double.parse(total2vm.toString()) *
                      ((viewaddtocart?.dataProduct?[index].mumbaiStock
                          ?.length == 0) ? (double.parse((viewaddtocart
                          ?.dataProduct?[index].tirupurStock?[0].price?[0]
                          .maxPrice).toString()) <= 0 ? 0 : double.parse(
                          (viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                              .price?[0].maxPrice).toString())) : (double.parse(
                          (viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                              .price?[0].maxPrice).toString()) <= 0 ? 0 : double
                          .parse(
                          (viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                              .price?[0].maxPrice).toString())));

              pricevt = double.parse(total1vt.toString()) *
                  ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0)
                      ? (double.parse((viewaddtocart?.dataProduct?[index]
                      .tirupurStock?[0].price?[0].minPrice).toString()) <= 0
                      ? 0
                      : double.parse(
                      (viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                          .price?[0].minPrice).toString()))
                      : (double.parse((viewaddtocart?.dataProduct?[index]
                      .mumbaiStock?[0].price?[0].minPrice).toString()) <= 0
                      ? 0
                      : double.parse(
                      (viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                          .price?[0].minPrice).toString()))) +
                  double.parse(total2vt.toString()) *
                      ((viewaddtocart?.dataProduct?[index].mumbaiStock
                          ?.length == 0) ? (double.parse((viewaddtocart
                          ?.dataProduct?[index].tirupurStock?[0].price?[0]
                          .maxPrice).toString()) <= 0 ? 0 : double.parse(
                          (viewaddtocart?.dataProduct?[index].tirupurStock?[0]
                              .price?[0].maxPrice).toString())) : (double.parse(
                          (viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                              .price?[0].maxPrice).toString()) <= 0 ? 0 : double
                          .parse(
                          (viewaddtocart?.dataProduct?[index].mumbaiStock?[0]
                              .price?[0].maxPrice).toString())));

              for (int i = 0; i <
                  (viewaddtocart?.dataProduct?.length ?? 0); i++) {
                setState(() {
                  double pricemwg = pricevm! * 118 / 100;
                  double pricetwg = pricevt! * 118 / 100;
                  pricevm;
                  pricevt;
                  gtotalv =
                      pricemwg +
                          pricetwg; //for display grandtotal to screen with gst 18%
                  grandtotalv = pricevm! + pricevt!;
                  gstv = grandtotalv! * 18 /
                      100; // for confirm block api without gst
                });
              }
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
