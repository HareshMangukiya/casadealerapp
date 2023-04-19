import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/modal_class/summarEditBlock.dart';
import 'package:casadealerapp/modal_class/summaryEditCart.dart';
import 'package:casadealerapp/modal_class/view_block_single_product_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/product_2.dart';

import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
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

class summary_b_edit extends StatefulWidget {
  int? index;
  int? select;
  double? totalm;
  double? totalt;
  double? grandtotal;
  double? grand;
  double? gst;
  double? pricemin;
  double? pricemax;

   summary_b_edit({Key? key,this.gst,this.pricemax,this.pricemin,this.grand, this.select,this.index,this.grandtotal,this.totalm,this.totalt
   }) : super(key: key);

  @override
  State<summary_b_edit> createState() => _summary_b_editState();
}

class _summary_b_editState extends State<summary_b_edit> {

  search? searchproperty;
  bool se_icon = false;
  double? totaltt;
  double? totalmm;
  double? grandt;
  double? gstt;
  double? grandtotalt;

  viewBlockProduct? blockView;
  cartcount? count;
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
  TextEditingController _totalmm = TextEditingController();
  TextEditingController _totaltt = TextEditingController();

  summryEditBlockProduct? summeryeditblock;
  summryEditCartProduct? summaryeditcart;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? check = false;
  int sum = 0;
  List<String> tabs = ["Blocked", "Cart"];
  int cart = 0;
  bool isLoading= true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    sumindex1 = (widget.select==0) ? 0 :1;
    (widget.select==0) ? viewBlockSummary() : viewcart() ;
    viewcount();
    setState(() {
      totaltt = widget.totalt;
      totalmm =widget.totalm;
      gstt=widget.gst;
      grandt =widget.grand;
      grandtotalt =widget.grandtotal;
      print(totalmm);
    });
}
  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold
      : Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body:isLoading? Container(): Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Color(0xfffFFFFFF),
            ),
            Padding(
              padding:  EdgeInsets.only(top:0.0),
              child: Container(
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
                              SizedBox(height: 11.0,),
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
                                      "Summary",
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
                                    onTap:(){
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
                                    // sumindex1 = index;
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
                                    (blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0) ? Container()  : Column(
                                    children: [
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
                                                  borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  borderRadius:
                                                  BorderRadius.circular(5),
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
                                              width: 17.w,
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
                                                  borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  borderRadius:
                                                  BorderRadius.circular(5),
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
                                              height: 3.5.h,
                                              width: 17.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                    Radius.circular(10),
                                                    bottomLeft:
                                                    Radius.circular(10)),
                                                color: Color(0Xffeaeaf3),
                                              ),
                                              child: Text(
                                                ' ₹ ' +totalmm.toString(),
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

                                    ],
                                ),

                                        blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length != 0 &&blockView?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length != 0  ?
                                        Column(
                                          children: [
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
                                          ],
                                        ) :Container(),



                                        (blockView?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length == 0) ?Container(): Column(
                                         children: [
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
                                                     'Tirupur',
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
                                                       borderRadius:
                                                       BorderRadius.circular(5),
                                                       // border: Border.all(color: Colors.black),
                                                       border: Border.all()),
                                                   child: TextField(
                                                     controller: _ts,
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
                                                       borderRadius:
                                                       BorderRadius.circular(5),
                                                       // border: Border.all(color: Colors.black),
                                                       border: Border.all()),
                                                   child: TextField(
                                                     controller: _txl,
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
                                                       borderRadius:
                                                       BorderRadius.circular(5),
                                                       // border: Border.all(color: Colors.black),
                                                       border: Border.all()),
                                                   child: TextField(
                                                     controller: _t3xl,
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
                                                       borderRadius:
                                                       BorderRadius.circular(5),
                                                       // border: Border.all(color: Colors.black),
                                                       border: Border.all()),
                                                   child: TextField(
                                                     controller: _t4xl,
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
                                                       borderRadius:
                                                       BorderRadius.circular(5),
                                                       // border: Border.all(color: Colors.black),
                                                       border: Border.all()),
                                                   child: TextField(
                                                     controller: _t5xl,
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
                                                   height: 3.5.h,
                                                   width: 17.w,
                                                   decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.only(
                                                         bottomRight:
                                                         Radius.circular(10),
                                                         bottomLeft:
                                                         Radius.circular(10)),
                                                     color: Color(0Xffeaeaf3),
                                                   ),
                                                   child: Text(
                                                     ' ₹ ' + (totaltt).toString(),
                                                     style: TextStyle(
                                                         fontSize: 1.5.h,
                                                         color: Color(0Xff50509a),
                                                         fontWeight: FontWeight.bold),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),

                                           SizedBox(height: 3.h),
                                         ],
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
                                                Expanded(
                                                  child: Text(
                                                    ' ₹ '+ grandt.toString() + ' + ₹ ' +gstt!.toStringAsFixed(2) +"(18 % GST) =   ₹  " +(grandtotalt!).toStringAsFixed(2),
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
                                      ],
                                    );
                                  },
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
                                                    Text( viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0 ?
                                                    ( viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].price?[0].minPrice).toString()
                                                        : (viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].price?[0].minPrice).toString(),
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
                                                      viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0 ?
                                                      ( viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?[0].price?[0].maxPrice).toString()
                                                          : (viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?[0].price?[0].maxPrice).toString(),
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
                                        viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length == 0 ? Container() :  Column(
                                          children:[
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
                                                        borderRadius:
                                                        BorderRadius.circular(5),
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
                                                        borderRadius:
                                                        BorderRadius.circular(5),
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
                                                        borderRadius:
                                                        BorderRadius.circular(5),
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
                                                        borderRadius:
                                                        BorderRadius.circular(5),
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
                                                        borderRadius:
                                                        BorderRadius.circular(5),
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
                                                        borderRadius:
                                                        BorderRadius.circular(5),
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
                                                        borderRadius:
                                                        BorderRadius.circular(5),
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
                                                    height: 3.5.h,
                                                    width: 17.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                          bottomRight:
                                                          Radius.circular(10),
                                                          bottomLeft:
                                                          Radius.circular(10)),
                                                      color: Color(0Xffeaeaf3),
                                                    ),
                                                    child:
                                                    // TextField(
                                                    //   controller: _totalmm,
                                                    //   textAlign: TextAlign.center,
                                                    //   keyboardType: TextInputType.number,
                                                    //   onChanged: (value){
                                                    //     update();
                                                    //   },
                                                    //   style: TextStyle(
                                                    //       fontSize: 2.h,
                                                    //       color: Colors.black,
                                                    //       fontWeight: FontWeight.bold),
                                                    // ),
                                                    Text(
                                                       ' ₹ '+totalmm.toString(),
                                                      style: TextStyle(
                                                          fontSize: 1.5.h,
                                                          color: Color(0Xff50509a),
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),

                                        viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length != 0 && viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].mumbaiStock?.length != 0  ?
                                        Column(
                                          children: [
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
                                          ],
                                        ) :Container(),
                                        viewaddtocart?.dataProduct?[int.parse((widget.index).toString())].tirupurStock?.length == 0 ? Container():  Column(
                                       children: [
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
                                                     borderRadius:
                                                     BorderRadius.circular(5),
                                                     // border: Border.all(color: Colors.black),
                                                     border: Border.all()),
                                                 child: TextField(
                                                   controller: _ts,
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
                                                     borderRadius:
                                                     BorderRadius.circular(5),
                                                     // border: Border.all(color: Colors.black),
                                                     border: Border.all()),
                                                 child: TextField(
                                                   controller: _tm,
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
                                                     borderRadius:
                                                     BorderRadius.circular(5),
                                                     // border: Border.all(color: Colors.black),
                                                     border: Border.all()),
                                                 child: TextField(
                                                   controller: _tl,
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
                                                     borderRadius:
                                                     BorderRadius.circular(5),
                                                     // border: Border.all(color: Colors.black),
                                                     border: Border.all()),
                                                 child: TextField(
                                                   controller: _txl,
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
                                                     borderRadius:
                                                     BorderRadius.circular(5),
                                                     // border: Border.all(color: Colors.black),
                                                     border: Border.all()),
                                                 child: TextField(
                                                   controller: _t3xl,
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
                                                     borderRadius:
                                                     BorderRadius.circular(5),
                                                     // border: Border.all(color: Colors.black),
                                                     border: Border.all()),
                                                 child: TextField(
                                                   controller: _t4xl,
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
                                                     borderRadius:
                                                     BorderRadius.circular(5),
                                                     // border: Border.all(color: Colors.black),
                                                     border: Border.all()),
                                                 child: TextField(
                                                   controller: _t5xl,
                                                   textAlign: TextAlign.center,
                                                   keyboardType: TextInputType.number,
                                                   onChanged: (value){
                                                     print("1234");
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
                                                 height: 3.5.h,
                                                 width: 17.w,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.only(
                                                       bottomRight:
                                                       Radius.circular(10),
                                                       bottomLeft:
                                                       Radius.circular(10)),
                                                   color: Color(0Xffeaeaf3),
                                                 ),
                                                 child:
                                                 Text(
                                                      ' ₹ ' +totaltt.toString(),
                                                   style: TextStyle(
                                                       fontSize: 1.5.h,
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
                                                 Expanded(
                                                   child: Text(
                                                     ' ₹ '+ grandt.toString() + ' + ₹ ' +gstt!.toStringAsFixed(2) +"(18 % GST) =   ₹  " +(grandtotalt!).toStringAsFixed(2),
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
                                     )
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
            ),
            Padding(

                padding:EdgeInsets.only  ( left: 1.h, top: 20.h,
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
      isLoading: isLoading
    );
  }

  update(){
 setState(() {
    totalmm = ((int.parse(_xs.text)+int.parse(_s.text)+int.parse(_m.text)+int.parse(_l.text)+int.parse(_xl.text)+int.parse(_xxl.text)+int.parse(_3xl.text)) * double.parse((widget.pricemin!.toString())) +
       ((int.parse(_4xl.text)+int.parse(_5xl.text))* double.parse((widget.pricemax).toString())) );
    totaltt = ((int.parse(_txs.text)+int.parse(_ts.text)+int.parse(_tm.text)+int.parse(_tl.text)+int.parse(_txl.text)+int.parse(_txxl.text)+int.parse(_t3xl.text)) * double.parse((widget.pricemin!).toString())) +
       ((int.parse(_t4xl.text)+int.parse(_t5xl.text))* double.parse((widget.pricemax).toString())) ;
   grandt = totalmm!+totaltt!;
   gstt = totaltt!*(18/100)+totalmm! *(18/100);
   grandtotalt = grandt! + gstt!;
 });
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
            print(summeryeditblock?.status);
          if (response.statusCode == 200 && summeryeditblock?.status == "success") {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>summary(cart:0)));
          } else {
            buildErrorDialog1(this.context, "",  'your editable value not available in stock.',1);
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>summary(cart:1)));
            if (kDebugMode) {}
          } else {
            // buildErrorDialog1(this.context, "",  'Already product added to cart',1);
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
                isLoading=false;
            });
            if (kDebugMode) {
            }
          } else {
            setState(() {
              isLoading=false;
            });
          }
        });
      } else {
        setState(() {
          isLoading=false;
        });
      }
    });
  }
  viewcart()async {
    final Map<String, String> data = {};
    data['action'] = 'view_add_to_cart_product_single';

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
         // int    total1vm = int.parse(
         //        viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .xsBlock ?? "0") +
         //        int.parse(viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .sBlock ?? "0") +
         //        int.parse(viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .mBlock ?? "0") +
         //        int.parse(viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .lBlock ?? "0") +
         //        int.parse(viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .xlBlock ?? "0") +
         //        int.parse(viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .xxlBlock ?? "0") +
         //        int.parse(viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .s3xlBlock ?? "0");
         //   int total2vm = int.parse(
         //        viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .s4xlBlock ?? "0") +
         //        int.parse(viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0]
         //            .s5xlBlock ?? "0");
         //    totalmm = double.parse(total1vm.toString()) * ((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].minPrice).toString()))) +
         //        double.parse(total2vm.toString()) * ((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].maxPrice).toString())));
         //
         //  int  total1vt = int.parse(
         //        viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //            .xsBlock ?? "0") +
         //        int.parse(
         //            viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //                .sBlock ?? "0") +
         //        int.parse(
         //            viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //                .mBlock ?? "0") +
         //        int.parse(
         //            viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //                .lBlock ?? "0") +
         //        int.parse(
         //            viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //                .xlBlock ?? "0") +
         //        int.parse(
         //            viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //                .xxlBlock ?? "0") +
         //        int.parse(
         //            viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //                .s3xlBlock ?? "0");
         // int  total2vt = int.parse(
         //        viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //            .s4xlBlock ?? "0") +
         //        int.parse(
         //            viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0]
         //                .s5xlBlock ?? "0");
         //    totaltt = double.parse(total1vt.toString()) * ((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].minPrice).toString()))) +
         //        double.parse(total2vt.toString()) * ((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[widget.index!].mumbaiStock?[0].price?[0].maxPrice).toString())));
         //   _totalmm.text =totalmm.toString();
         //   _totaltt.text= totaltt.toString();
         //    setState(() {
         //      totalmm;
         //      totaltt;
         //      grandt = totalmm!+totaltt!;
         //      gstt = totaltt!*(18/100)+totalmm! *(18/100);
         //      grandtotalt = grandt! + gstt!;
         //      isLoading=false;
         //    });
            setState(() {
              isLoading=false;
            });

          } else {
            setState(() {
              isLoading=false;
            });
          }
        });
      } else {
        setState(() {
          isLoading=false;
        });
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
}

