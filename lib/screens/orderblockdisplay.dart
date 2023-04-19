import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';
import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/modal_class/order_detail_class.dart';
import 'package:casadealerapp/modal_class/oredrdetail.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/alert_screen.dart';
import 'package:casadealerapp/screens/order_detail.dart';

import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/screens/product_2.dart';
import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;


class orderblockdisplay extends StatefulWidget {
  String? id;
  orderblockdisplay({Key? key,this.id}) : super(key: key);

  @override
  State<orderblockdisplay> createState() => _orderblockdisplayState();
}

class _orderblockdisplayState extends State<orderblockdisplay> {

  TextEditingController _search = TextEditingController();
  search? searchproperty;
  bool se_icon = false;
  bool? check = false;
  bool isLoading=true;
  double? gst =0.0;
  double? grand= 0.0;


convertblockorder? convertorder;


  orderdetail? detail;
  cartcount? count;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orederdetailapiblock();
    viewcount();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body:isLoading? Container(): SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: Color(0xfffFFFFFF),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
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
                              SizedBox(height:11.0),
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
                                      "Blocked Orders",
                                      style:
                                      TextStyle(fontSize: 2.h, color: Colors.white),
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
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>summary()));
                                  },
                                  badgeContent:  Text(( count?.cartCount== 0 ||count?.cartCount == null ) ? "0" :(count?.cartCount).toString(),
                                      style:TextStyle(color:Colors.white)),
                                  child: GestureDetector(
                                    onTap : (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>summary()));

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
                padding:  EdgeInsets.only(top:10.h),
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

                            if (value.isNotEmpty) {
                              setState(() {
                                check=true;
                              });
                              searchapi(value);
                            } else if (value.isEmpty) {
                              setState(() {
                                check=false;
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
                                Text("BLOCKED ORDER ID : "+widget.id.toString(),
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
                      Container(
                        height: 69.h,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          itemCount: detail?.productData?.length,
                          itemBuilder: ( context,  index) {
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
                                    .minPrice ?? "0") + double.parse(total2.toString()) *
                                double.parse(detail?.productData?[index]
                                    .maxPrice ?? "0");
                            gst = price!* 18/100;
                            grand = price!+ gst!;

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
                                            Text( "₹"+ (detail?.productData?[index].minPrice).toString() != 0 ?(detail?.productData?[index].minPrice).toString() : "N/A",
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
                                                "₹"+ (detail?.productData?[index].maxPrice).toString() != 0  ? (detail?.productData?[index].maxPrice).toString() :"N/A",
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
                                                      order_detail_c(
                                                          val:0,
                                                        oreder :widget.id.toString(),
                                                        id:index
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
                                          (detail?.productData?[index].xl).toString(),
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
                                        Expanded(
                                          child: Text(
                                            '   ₹' + price.toString() + " + ₹" + gst!.toStringAsFixed(2) + "(18% GST) = ₹" + grand!.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 1.5.h,
                                                color: Color(0xff333389)),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:93.h),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          buildErrorDialog2(context,"Alert!","Aer you sure? want to block.");
                          // converttoorder();

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

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => alert_screen(id: widget.id)));
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
              Padding(
                  padding:EdgeInsets.only (left: 1.h, top: 20.h,
                      right: 1.h),
                  child:check ! ? Container(
                    height: 100.h,
                    width: MediaQuery.of(context).size.width,
                    color:Colors.white,
                    child:  (searchproperty == null
                        ? SizedBox(
                      width: MediaQuery.of(context).size.width,
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
                      width: MediaQuery.of(context).size.width,
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
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topCenter,

                      margin: EdgeInsets.symmetric(horizontal: 2.h,vertical: 0.5.h),
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
                                      builder: (context) => product_2(

                                        pronamenevigatior:   '${searchproperty?.data?[index].prodName}',
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
                                            backgroundImage: NetworkImage(searchproperty
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
                  ):Container()
              ),
            ],
          ),
        ),
      ), isLoading: isLoading,

    );
  }
  orederdetailapiblock(){
    final Map<String, String> data = {};
    data['action'] = 'order_details';
    data['order_no'] = widget.id.toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .oredrdetailap(data)
            .then((Response response) async {
          detail = orderdetail.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && detail?.status == "success") {
            setState(() {
            });

            for(int index = 0; index < (detail?.productData?.length ?? 0); index++) {
              print("1234");

              print(index.toString()+price.toString());
              for (int i = 0; i < (detail?.productData?.length ?? 0); i++) {
                setState(() {
                  price;

                  isLoading = false;

                  gtotal = price! * 118 / 100;
                });
              }
            }
          } else {
            setState((){
              isLoading = false;
            });
          }
        });
      } else {
        setState((){
          isLoading = false;
        });
      }
    });
  }
converttoorder(){
  final Map<String, String> data = {};
  data['action'] = 'block_order_convert_confirm';
  data['d_id'] =(userData?.logindata?.dId).toString();
  data['order_no'] = widget.id.toString();
  checkInternet().then((internet) async {
    if (internet) {
      Productprovider()
          .convertblockorderapi(data)
          .then((Response response) async {
        convertorder = convertblockorder.fromJson(json.decode(response.body));
        if (response.statusCode == 200 && convertorder?.status == "success") {
          setState(() {
          });

          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>your_order()));
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
            if (kDebugMode) { }
          } else {
            setState(() {
              // isloading = false;
            });}
        });
      } else {
        setState(() {
          // isloading = false;
        });}
    });
  }
  viewcount()async {
    final Map<String, String> data = {};
    data['action'] = 'add_to_cart_count';
    data['d_id'] = (userData?.logindata?.dId).toString();


    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().addtocartcount(data).then((Response response) async {
          count = cartcount.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              count?.status == "success") {
          }
          else {
          }
        });
      } else {

      }
    });
  }
  buildErrorDialog2(BuildContext context,String title, String contant) {


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
              height: (title == "")?21.h :22.h,
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
                  Row(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        GestureDetector(
                          child: Container(
                            height: 40.0,
                            width: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xff333389),
                            ),
                            child: Center(
                              child: Text("Yes",
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
                            converttoorder();
                            Navigator.pop(context);

                          },
                        ),
                        SizedBox(width:3.w),
                        GestureDetector(
                          child: Container(
                            height: 40.0,
                            width: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xff333389),
                            ),
                            child: Center(
                              child: Text("No",
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
              height: (title == "")?20.5.h :19.h,
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
                  Row(children:[
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
                              style:  TextStyle(
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
                              style:  TextStyle(
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
}
