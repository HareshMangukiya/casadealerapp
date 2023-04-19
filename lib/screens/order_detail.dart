import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';
import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/modal_class/order_detail_class.dart';
import 'package:casadealerapp/modal_class/oredrdetail.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/alert_screen.dart';

import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/screens/orderblockdisplay.dart';
import 'package:casadealerapp/screens/product_2.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/build_dialog.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;


class order_detail_c extends StatefulWidget {
  String? oreder;
  String? total;
  int? id;
  int? val;
   order_detail_c({Key? key,this.id,this.oreder,this.total,this.val}) : super(key: key);

  @override
  State<order_detail_c> createState() => _order_detail_cState();
}

class _order_detail_cState extends State<order_detail_c> {
  TextEditingController _search = TextEditingController();
  search? searchproperty;
  bool se_icon = false;
  bool? check = false;
  double? gst;
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
  double? total;
  double? gtotal;
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
    return Scaffold(
      backgroundColor: Color(0xfffFFFFFF),
      drawer: drawer(context),
      key: _scaffoldKey,
      body: Stack(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height:8.0),
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
                        ],
                      ),
                      SizedBox(
                        width: 28.w,
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
                          badges.Badge(
                              onTap: (){

                              },
                              badgeContent:  Text((viewaddtocart?.addToCartNumber == 0 ||viewaddtocart?.addToCartNumber == null ) ? "0" :((viewaddtocart?.addToCartNumber).toString()),
                                  style:TextStyle(color:Colors.white)),
                              child: Icon(Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 3.h)
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
            padding: EdgeInsets.only(top:10.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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

                                          onChanged: (value){
                                            update();
                                          },
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
                                          onChanged: (value){
                                            update();
                                          },
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
                                          onChanged: (value){
                                            update();
                                          },
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
                                          onChanged: (value){
                                            update();
                                          },
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
                                          onChanged: (value){
                                            update();
                                          },
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
                                        height: 3.6.h,
                                        width: 17.w,
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
                                          onChanged: (value){
                                            update();
                                          },
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
                                          onChanged: (value){
                                            update();
                                          },
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
                                          onChanged: (value){
                                            update();
                                          },
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
                                          onChanged: (value){
                                            update();
                                          },
                                          style: TextStyle(
                                              fontSize: 2.h,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 3.6.h,
                                        width: 17.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          color: Color(0Xffeaeaf3),
                                        ),
                                        child: Text(
                                            '   ₹'+ total.toString(),
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
                                              fontSize: 1.5.h),
                                        ),
                                        Expanded(
                                          child: Text(
                                                  ' ₹' +  total.toString() +" + ₹ "+gst.toString()+ "(18% GST) = ₹" +  gtotal.toString(),
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
                      ),

                    ],
                  )
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
    );
  }
  update(){
    total = (int.parse(_xs.text) + int.parse(_s.text) +int.parse(_m.text) + int.parse(_l.text) + int.parse(_xl.text) + int.parse(_xxl.text) + int.parse(_3xl.text)) * double.parse((detail?.productData?[int.parse(widget.id.toString())].minPrice).toString()) +
        (int.parse(_4xl.text)+ int.parse(_5xl.text)) *double.parse((detail?.productData?[int.parse(widget.id.toString())].maxPrice).toString());
  gtotal = total! *118/100;
  gst = total!* 18/100;

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
              num sum1 = int.parse((detail?.productData?[int.parse(widget.id.toString())].s).toString()) +
                  int.parse((detail?.productData?[int.parse(widget.id.toString())].xs).toString())+
                  int.parse((detail?.productData?[int.parse(widget.id.toString())].m).toString())
              +int.parse((detail?.productData?[int.parse(widget.id.toString())].l).toString()) +
                  int.parse((detail?.productData?[int.parse(widget.id.toString())].xl).toString()) +
                  int.parse((detail?.productData?[int.parse(widget.id.toString())].xxl).toString()) +
                  int.parse((detail?.productData?[int.parse(widget.id.toString())].s3xl).toString());
              num sum2 =int.parse((detail?.productData?[int.parse(widget.id.toString())].s4xl).toString()) +
                  int.parse((detail?.productData?[int.parse(widget.id.toString())].s5xl).toString()) ;
             setState(() {
               total = sum1 * double.parse((detail?.productData?[int.parse(widget.id.toString())].minPrice).toString())
                   + sum2 * double.parse((detail?.productData?[int.parse(widget.id.toString())].maxPrice).toString());
               gtotal= total! * 118/100;
               gst = total!* 18/100;

             });
            });
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
    data['apd_id']= detail?.productData?[int.parse(widget.id.toString())].apdId.toString() ?? "0" ;
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


          if (response.statusCode == 200 && edit?.status == "success") {
            setState(() {
            });
            widget.val ==0?
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>orderblockdisplay(id: widget.oreder.toString(),))) : Navigator.of(context).push(MaterialPageRoute(builder: (context)=>order_id(id: widget.oreder.toString(),)));

          } else {
            buildErrorDialog(context, "", "your edited stock is not available.");
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

}
