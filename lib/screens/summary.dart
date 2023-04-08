import 'dart:convert';
import 'dart:ffi';

import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/confirmblock.dart';
import 'package:casadealerapp/modal_class/confirmblock.dart';
import 'package:casadealerapp/modal_class/confirmblock.dart';
import 'package:casadealerapp/modal_class/view_block_single_product_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/block_order.dart';

import 'package:casadealerapp/screens/cart_order.dart';

import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/screens/viewcartpage.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class summary extends StatefulWidget {
  String? pronamenevigatior;
  String? coloridnevigator;
  String? gender;
  int? total;
  int? cart;


  summary({Key? key ,this.pronamenevigatior,
    this.coloridnevigator,
  this.gender,this.cart
  }) : super(key: key);

  @override
  State<summary> createState() => _summaryState();
}

class _summaryState extends State<summary> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? check = false;
  int sum = 0;

  int? cart=0;
  RegExp regex = RegExp(r'^\d+$');
  List<String> tabs = ["Blocked", "Cart"];
  viewBlockProduct? blockView;
  ViewCart? viewaddtocart;
  confirmblockdata? confirm;
  double? grandtotal= 0.0;
  int? total1m=0;
  int? total2m = 0;
  int? total1t=0;
  int? total2t = 0;
  double? pricem=0.0;
  double? pricet= 0.0;
  double? gtotal=0.0;
  double? gst =0.0;
  double? grandtotalv= 0.0;
  int? total1vm=0;
  int? total2vm = 0;
  int? total1vt=0;
  int? total2vt = 0;
  double? pricevm=0.0;
  double? pricevt= 0.0;
  double? gtotalv=0.0;
  double? gstv =0.0;

  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      print(widget.cart);
      sumindex = widget.cart == 0? 0 :1;
    });
    sumindex == 0 ? viewBlockSummary() :viewcart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffFFFFFF),
      drawer: drawer(context),
      key: _scaffoldKey,
      body: SingleChildScrollView(
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
                          setState((){
                            sumindex = index;
                          });
                          sumindex ==0?  viewBlockSummary():viewcart();
                        },
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (sumindex == index)
                                    ? Color(0xfff333389)
                                    : Color(0xfffFFFFFF),
                              ),

                              height: 5.h,
                              width: 44.w,
                              margin: EdgeInsets.only(right: 0.1.w, top: 0.6.h),

                              // padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.h),
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: (sumindex != index)
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
           sumindex == 0 ? Container(
             width: MediaQuery.of(context).size.width,
             height: 70.h,
             child: SingleChildScrollView(
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   height: 70.h,

                   child:(blockView?.status == "fail")?Center(child: Text("No Product Blocked.",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontFamily: "Poppins",fontWeight: FontWeight.bold),)):
                   ListView.builder(
                       itemCount:blockView?.dataProduct?.length,
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
                                       blockView?.dataProduct?[index].productName ?? "N/A",

                                       style: TextStyle(
                                           color: Color(0xff35358a),
                                           fontSize: 2.h,
                                           fontWeight: FontWeight.bold)),
                                   Text( blockView?.dataProduct?[index].colorName ?? "N/A",
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
                                            blockView?.dataProduct?[index].mumbaiStock?.length ==0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice) != 0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString() : "N/A" :
                                            blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice != 0 ? (blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString() : "N/A",
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
                                           blockView?.dataProduct?[index].mumbaiStock?.length ==0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice) != 0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString() : "N/A" :
                                           blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice != 0 ? (blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString() : "N/A",
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
                                                     index :index,
                                                     select: 0,
                                                     totalm : pricem,
                                                     totalt : pricet,
                                                     grandtotal : gtotal,
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
                                       blockView?.dataProduct?[index].gender ?? "",
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
                             (blockView?.dataProduct?[index].mumbaiStock?.length) == 0? Text("Mumbai Stock is not blocked."):Column(
                              children: [
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].xsBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].sBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].mBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].lBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].xlBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].xxlBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].s3xlBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].s4xlBlock).toString(),
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
                                          (blockView?.dataProduct?[index].mumbaiStock?[0].s5xlBlock).toString(),
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
                                          "₹" + pricem.toString(),
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
                             (blockView?.dataProduct?[index].tirupurStock?.length == 0)?Text("No Tirupur stock available"):Column(
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].xsBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].sBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].mBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].lBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].xlBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].xxlBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].s3xlBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].s4xlBlock).toString(),
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
                                           (blockView?.dataProduct?[index].tirupurStock?[0].s5xlBlock).toString(),
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
                                           "₹" + pricet.toString(),
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
                                       ' Grand Total : ',
                                       style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 2.h),
                                     ),
                                     Text(
                                       "₹" + gtotal.toString(),
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

             ) ,

           ) :
           Container(
             width: MediaQuery.of(context).size.width,
             height: 70.h,
             child: viewcartpage(),
           ),



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
                                  builder: (context) =>
                                      products_1()));
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
                              borderRadius: BorderRadius.circular(20),
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

                          setState(() {
                            cart = 0;
                          });
                          viewBlockSummary();
                          viewcart();
                          // sumindex == 0? print("block ") : print("cart");
                          sumindex == 0? confirmblock() : confirmaddcart();
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

                              borderRadius: BorderRadius.circular(20),
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


   ])) );
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
            for(int index=0 ; index<(blockView?.dataProduct?.length ?? 0) ; index++){

                if(blockView?.dataProduct?[index].mumbaiStock?.length !=0){
                  total1m = int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].xsBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].sBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].mBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].lBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].xlBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].xxlBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].s3xlBlock ?? "0");
                  total2m =int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].s4xlBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].mumbaiStock?[0].s5xlBlock ?? "0");

                }
                if(blockView?.dataProduct?[index].tirupurStock?.length !=0){
                  total1t = int.parse(blockView?.dataProduct?[index].tirupurStock?[0].xsBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].tirupurStock?[0].sBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].tirupurStock?[0].mBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].tirupurStock?[0].lBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].tirupurStock?[0].xlBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].tirupurStock?[0].xxlBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].tirupurStock?[0].s3xlBlock ?? "0");
                  total2t =int.parse(blockView?.dataProduct?[index].tirupurStock?[0].s4xlBlock ?? "0") +
                      int.parse(blockView?.dataProduct?[index].tirupurStock?[0].s5xlBlock ?? "0");

                }
                 pricem= double.parse(total1m.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                    double.parse(total2m.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));

                 pricet= double.parse(total1t.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                    double.parse(total2t.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));

                for (int i = 0; i <(blockView?.dataProduct?.length ?? 0); i++) {
                  setState((){
                  double  pricemwg =pricem! *118/100;
                   double  pricetwg= pricet! *118/100;
                   pricem;
                   pricet;
                    gtotal =
                        pricemwg + pricetwg; //for display grandtotal to screen with gst 18%
                    grandtotal =  pricem! + pricet!;
                    gst =grandtotal! *18/100;// for confirm block api without gst
                  });
                setState(() {

                });
                if (kDebugMode) {
                }
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
  confirmblock() async {
    final Map<String, String> data = {};
    data['action'] = 'confirm_block_order';
    data['price_of_total'] = grandtotal.toString();
    data['gst_price'] = gst.toString();
    data['d_id'] = (userData?.logindata?.dId).toString();
      print(data);
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().comfirmblockapi(data).then((Response response) async {
          confirm = confirmblockdata.fromJson(json.decode(response.body));
          print(confirm?.status);
          if (response.statusCode == 200 &&
              confirm?.status == "success") {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>your_block_order()));
          }
          else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>your_block_order()));
          }
        });
      } else {

      }
    });
  }
  confirmaddcart()async{
    final Map<String, String> data = {};
    data['action'] = 'confirm_add_to_cart_order';
    data['price_of_total'] = grandtotalv.toString() ;
    data['gst_price'] = gstv.toString();

    data['d_id'] = (userData?.logindata?.dId).toString();

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().confirmaddtocartapi(data).then((Response response) async {
          confirm = confirmblockdata.fromJson(json.decode(response.body));
          print(confirm?.status);
          if (response.statusCode == 200 &&
              confirm?.status == "success") {

            setState(() {

            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        your_block_order()));
          } else {

          }
        });
      } else {

      }
    });
  }

}
