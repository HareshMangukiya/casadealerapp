import 'dart:convert';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';
import 'package:casadealerapp/modal_class/confirmblock.dart';
import 'package:casadealerapp/modal_class/confirmblock.dart';
import 'package:casadealerapp/modal_class/confirmblock.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/modal_class/view_block_single_product_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/block_order.dart';

import 'package:casadealerapp/screens/cart_order.dart';
import 'package:casadealerapp/screens/product_2.dart';

import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/screens/viewcartpage.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
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

  // Mumbai contriller
  TextEditingController _search = TextEditingController();
  search? searchproperty;
  bool se_icon = false;
  double? tot = 0.0;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? check = false;
  int sum = 0;
double? gstfv = 0.0;
double? paymentv=0.0 ;
  double? gstfb = 0.0;
  double? paymentb=0.0 ;

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
  bool isLoading = true;
  double? gstf=0.0;
  cartcount? count;

  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      sumindex = 0;
    });
    sumindex == 0 ? viewBlockSummary() :viewcart();
    viewcount();
  }
  Future<void> Cont() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      gstf;
  tot;
    });
  }
  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body: isLoading ? Container():Stack(
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
              padding:  EdgeInsets.only(top:0.0),
              child:    Container(
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
            ),
               Padding(
                 padding:  EdgeInsets.only(top:10.h),
                 child: SingleChildScrollView(
                  child: Column(
                 children :[
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
                                   pricem= double.parse(total1m.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                                       double.parse(total2m.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));

                                 }
                                 else{
                                   pricem =0.0;
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
                                   pricet= double.parse(total1t.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                                       double.parse(total2t.toString()) * ((blockView?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));

                                 }
                                 else{
                                   pricet=0.0;
                                 }
                                 print(index.toString() + pricem.toString());
                                 print(index.toString() + pricet.toString());
                                 grandtotal = pricem! + pricet!; //for display grandtotal to screen with gst 18%
                                 gst =grandtotal! *18/100;
                                 gtotal = grandtotal!+ gst!;
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
                                           SizedBox(
                                             width: 40.w,
                                             child: Text(
                                                 blockView?.dataProduct?[index].productName ?? "N/A",

                                                 style: TextStyle(
                                                     color: Color(0xff35358a),
                                                     fontSize: 2.h,
                                                     fontWeight: FontWeight.bold)),
                                           ),
                                           SizedBox(
                                             width: 40.w,


                                             child: Text( blockView?.dataProduct?[index].colorName ?? "N/A",
                                                 maxLines: 2,
                                                 style: TextStyle(
                                                   color: Color(0xff35358a),
                                                   fontSize: 2.h,
                                                   fontWeight: FontWeight.bold,
                                                 )),
                                           ),
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
                                               int? min = (blockView?.dataProduct?[index].mumbaiStock?.length ==0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice) != 0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice) : 0 :
                                               blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice != 0 ? (blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice) : 0);
                                               int? max= (blockView?.dataProduct?[index].mumbaiStock?.length ==0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice) != 0 ? (blockView?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice) : 0 :
                                               blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice != 0 ? (blockView?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice) : 0);
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
                                                               grand : grandtotal,
                                                               gst:gst,
                                                               pricemax: double.parse(max.toString()),
                                                               pricemin:double.parse(min.toString())

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
                                     ((blockView?.dataProduct?[index].mumbaiStock?.length) == 0) ? Container() : Column(
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
                                                 width: 17.w,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.only(
                                                       bottomRight: Radius.circular(10),
                                                       bottomLeft: Radius.circular(10)),
                                                   color: Color(0Xffeaeaf3),
                                                 ),
                                                 child: Text(
                                                   "₹" + pricem.toString(),
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

                                     blockView?.dataProduct?[index].tirupurStock?.length != 0 && blockView?.dataProduct?[index].mumbaiStock?.length != 0  ?
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
                                     (blockView?.dataProduct?[index].tirupurStock?.length == 0)?Container():Column(
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
                                                 width: 17.w,
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
                                                 width: 17.w,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.only(
                                                       bottomRight: Radius.circular(10),
                                                       bottomLeft: Radius.circular(10)),
                                                   color: Color(0Xffeaeaf3),
                                                 ),
                                                 child: Text(
                                                   "₹" + pricet.toString(),
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
                                             Expanded(
                                               child: Text(
                                                 "₹" + grandtotal.toString() +" + ₹" +gst!.toStringAsFixed(2) +"(18% GST) = ₹" + gtotal!.toStringAsFixed(2) ,
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
                               }
                           ),
                         )
                     ) ,
                   ) :
                   isLoading? Container():Container(
                     width: MediaQuery.of(context).size.width,
                     height: 70.h,
                     child: SingleChildScrollView(
                         child: Container(
                           width: MediaQuery.of(context).size.width,
                           height: 70.h,
                           child:(viewaddtocart?.status == "fail")?Center(child: Text("No Product Added To Cart.",style: TextStyle(color: Colors.black,fontSize: 12.sp,fontFamily: "Poppins",fontWeight: FontWeight.bold),)):ListView.builder(
                               itemCount:viewaddtocart?.dataProduct?.length,
                               scrollDirection: Axis.vertical,
                               itemBuilder:(context,index){
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
                                   pricevm= double.parse(total1vm.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                                       double.parse(total2vm.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));
                                 }
                                 else{
                                   pricevm = 0.0;
                                 }
                                 if (viewaddtocart?.dataProduct?[index].tirupurStock?.length !=
                                     0){
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
                                   pricevt = double.parse(total1vt.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                                       double.parse(total2vt.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));
                                 }
                                 else{
                                   pricevt=0.0;
                                 }
                                
                               
                                 grandtotalv = pricevm! +pricevt! ;

                                 gstv=grandtotalv! *18/100;
                                 gtotalv = grandtotalv! +gstv!;

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
                                               int? min = (viewaddtocart?.dataProduct?[index].mumbaiStock?.length ==0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice) != 0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice) : 0 :
                                               viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice != 0 ? (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice) : 0);
                                               int? max= (viewaddtocart?.dataProduct?[index].mumbaiStock?.length ==0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice) != 0 ? (viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice) : 0 :
                                               viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice != 0 ? (viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice) : 0);
                                               Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (context) =>
                                                           summary_b_edit(
                                                               index :index,
                                                               select: 1,
                                                               totalm : pricem,
                                                               totalt : pricet,
                                                               grandtotal : gtotal,
                                                               grand : grandtotal,
                                                               gst:gst,
                                                               pricemax: double.parse(max.toString()),
                                                               pricemin:double.parse(min.toString())

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

                                     viewaddtocart?.dataProduct?[index].mumbaiStock?.length ==0  ?Container()
                                         :Column(
                                       children: [
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
                                                 width: 17.w,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.only(
                                                       bottomRight: Radius.circular(10),
                                                       bottomLeft: Radius.circular(10)),
                                                   color: Color(0Xffeaeaf3),
                                                 ),
                                                 child: Text(
                                                   "₹" + pricevm.toString(),
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
                                     viewaddtocart?.dataProduct?[index].tirupurStock?.length != 0 && viewaddtocart?.dataProduct?[index].mumbaiStock?.length != 0  ?
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


                                     viewaddtocart?.dataProduct?[index].tirupurStock?.length ==0  ? Container(): Column(
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
                                                 width: 17.w,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.only(
                                                       bottomRight: Radius.circular(10),
                                                       bottomLeft: Radius.circular(10)),
                                                   color: Color(0Xffeaeaf3),
                                                 ),
                                                 child: Text(
                                                   "₹" +  pricevt.toString(),
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
                                             Expanded(
                                               child: Text(
                                                 "₹" + grandtotalv.toString() + " + " + "₹" + gstv!.toStringAsFixed(2) +"(18% GST) = ₹" + gtotalv!.toStringAsFixed(2) ,
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
                               }),
                         )

                     ),
                   ),
                 ]
             ),
                 ),
               ),
            Padding(
              padding:  EdgeInsets.only(top:92.h),
              child: Container(
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
                            // viewcart();
                            // viewBlockSummary();
                          sumindex  == 0?   confirmblock(): confirmaddcart();
                            // sumindex == 0? print("block ") : print("cart");

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
            ),
            Padding(
                padding:EdgeInsets.only( left: 1.h, top: 20.h,
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
                                    // Container(
                                    //   height: 19.h,
                                    //   width: 40.w,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius:
                                    //     BorderRadius.all(
                                    //       Radius.circular(10.sp),
                                    //     ),
                                    //     image: DecorationImage(
                                    //       image: imageProvider,
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //   ),
                                    // ),

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
                                  // Container(
                                  //   height: 19.h,
                                  //   width: 40.w,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius:
                                  //     BorderRadius.all(
                                  //       Radius.circular(10.h),
                                  //     ),
                                  //   ),
                                  //   child: ClipRRect(
                                  //     borderRadius:
                                  //     BorderRadius.circular(
                                  //         15),
                                  //     child: Image.asset(
                                  //       "assets/default_product_image.png",
                                  //
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
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
        ) ),
      isLoading: isLoading!,
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
                  0){
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
              pricevm = double.parse(total1vm.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                  double.parse(total2vm.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));
              pricevt = double.parse(total1vt.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].minPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].minPrice).toString()))) +
                  double.parse(total2vt.toString()) * ((viewaddtocart?.dataProduct?[index].mumbaiStock?.length == 0) ? (double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].tirupurStock?[0].price?[0].maxPrice).toString())) :  (double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString()) <=0 ?0 :double.parse((viewaddtocart?.dataProduct?[index].mumbaiStock?[0].price?[0].maxPrice).toString())));
              grandtotalv = pricevm! +pricevt! ;

              gstv=grandtotalv! *18/100;
              gtotalv = grandtotalv! +gstv!;
              gstfv = gstv! + gstfv!;
              paymentv =paymentv!+ grandtotalv!;
            }

            setState(() {
              paymentv;
              gstfv;
              isLoading =false;
            });
            if (kDebugMode) {
            }
          } else {
            setState(() {
              isLoading =false;
            });
          }
        });
      } else {
        setState(() {
          isLoading =false;
        });
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
            for(int index =0 ;index< (blockView?.dataProduct?.length ?? 0);index++){
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
              grandtotal = pricem! + pricet!; //for display grandtotal to screen with gst 18%
              gst =grandtotal! *18/100;
              gtotal = grandtotal!+ gst!;
              gstfb = gst!+gstfb!;
              paymentb =paymentb! + grandtotal!;

            }

            setState(() {
              paymentb;
              gstfb;
              isLoading =false;
            });
            if (kDebugMode) {
            }
          } else {
            setState(() {
              isLoading =false;
            });
          }
        });
      } else {
        setState(() {
          isLoading =false;
        });
      }
    });
  }
  confirmblock() async {
    final Map<String, String> data = {};
    data['action'] = 'confirm_block_order';
    data['price_of_total'] = paymentb.toString();
    data['gst_price'] = gstfb.toString();
    data['d_id'] = (userData?.logindata?.dId).toString();

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().comfirmblockapi(data).then((Response response) async {
          confirm = confirmblockdata.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              confirm?.status == "successs") {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>your_block_order()));
        setState(() {
          isLoading =false;
        });

          }
          else {
            setState(() {
              isLoading =false;
            });

          }
        });
      } else {
        setState(() {
          isLoading =false;
        });

      }
    });
  }
  confirmaddcart()async{
    print("cart");
    final Map<String, String> data = {};
    data['action'] = 'confirm_add_to_cart_order';
    data['price_of_total'] = paymentv.toString() ;
    data['gst_price'] = gstfv.toString();

    data['d_id'] = (userData?.logindata?.dId).toString();
    print(data);

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().confirmaddtocartapi(data).then((Response response) async {
          confirm = confirmblockdata.fromJson(json.decode(response.body));
          print(confirm?.status);
          if (response.statusCode == 200 &&
              confirm?.status == "successs") {

            setState(() {
              isLoading =false;
            });
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>your_order()));
          } else {
            setState(() {
              isLoading =false;
            });
          }
        });
      } else {
        setState(() {
          isLoading =false;
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
              isLoading =false;

            });
            if (kDebugMode) { }
          } else {
            setState(() {
              isLoading =false;
            });}
        });
      } else {
        setState(() {
          isLoading =false;
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
