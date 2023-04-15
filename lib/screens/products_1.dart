import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';
import 'package:casadealerapp/modal_class/category_wise_display.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/screens/cart_order.dart';

import 'package:casadealerapp/provider/login_authprovider.dart';
import 'package:casadealerapp/modal_class/all_category_display.dart';
import 'package:casadealerapp/screens/product_2.dart';
import 'package:casadealerapp/modal_class/productapiclass.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;
class products_1 extends StatefulWidget {
  const products_1({Key? key}) : super(key: key);
  static const appTitle = 'Drawer Demo';

  @override
  State<products_1> createState() => _products_1State();
}
class _products_1State extends State<products_1> {
  TextEditingController _search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  allcategorydisplay? allproperty;
  categorywisedisplay? allcatogaryproperty;
  search? searchproperty;
  bool check = false;
  productapi? productData;
  String? name;
  int? select;
  String? image;
  bool se_icon = false;
  bool isloading = true;
  cartcount? count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getdata();
  }
  getdata()async{
   await alldisplay();
   await categorydisplay();
   await viewcount();
  }
  @override
  Widget build(BuildContext context) {
    return commanScreen( isLoading:isloading,
      scaffold: Scaffold(
        drawer: drawer(context),
        key: _scaffoldKey,
        body: isloading?Container():
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Color(0xfffFFFFFF),
            ),
            Padding(
              padding:  EdgeInsets.only(top:0),
              child:Container(
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
                                  "Products",
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
                  children: [
                    Column(
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
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Container(
                        height: 13.h,
                        // margin: EdgeInsets.symmetric(horizontal: 2.h),
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: allproperty?.data?.length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gen = index;
                                  });
                                  categorydisplay();
                                },
                                child: Container(
                                  height: 13.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0.8.h),
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width *
                                            0.15,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: (gen != index)
                                                  ? Colors.white
                                                  : Color(0xfff333389),
                                              width: 0.8.w),
                                          shape: BoxShape.circle,
                                          // color: Colors.blueGrey,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            allproperty
                                                    ?.data?[index].categoryImg ??
                                                "",
                                          )

                                              ),
                                        ),

                                      ),
                                      Text(
                                        allproperty?.data?[index].categoryName ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 1.5.h, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Container(
                            // height: MediaQuery.of(context).size.height,
                            height: 75.h,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15),
                            color: Color(0xfffFFFFFF),
                            child:allcatogaryproperty?.diffProduct == null ?Center(child: Text("No Product Found.",style:
                              TextStyle(color:Colors.black,fontSize: 12.sp,
                              fontWeight: FontWeight.bold)
                              ,)):
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: allcatogaryproperty?.diffProduct?.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 19.0,
                                      childAspectRatio: 3.h / 5.9.h,
                                      mainAxisSpacing: 15),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => product_2(
                                                pronamenevigatior:
                                                    '${allcatogaryproperty?.diffProduct?[index].name}',

                                                coloridnevigator:
                                                    '${allcatogaryproperty?.diffProduct?[index].id}',
                                                )
                                        )
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child:
                                            CachedNetworkImage(
                                                width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.6,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.3,
                                                fit: BoxFit.cover,
                                              imageUrl:allcatogaryproperty
                                                  ?.diffProduct?[index]
                                                  .prodImgDefault ??
                                                  "",
                                                placeholder: (context, url) => Center(
                                                    child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset( "assets/product_1_img2.png",
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.6,
                                                    height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.3,
                                                    fit: BoxFit.cover
                                                    ,
                                                  )
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    // left: MediaQuery.of(context).size.width * 0.01,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.26),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.18,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.08,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.24),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 8.w,
                                                  height: 3.8.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(25),
                                                    ),
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.share,
                                                      color: Color(0xff7d7d7d),
                                                      size: 1.8.h,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 0.8.h),
                                        alignment: Alignment.centerLeft,

                                        child: Text(
                                          allcatogaryproperty
                                                  ?.diffProduct?[index].name ??
                                              "N/A",

                                          style: TextStyle(
                                              fontSize: 2.h,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 0.5.h,
                                      ),

                                      SizedBox(
                                        height: 3.5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 42.w,
                                            padding: EdgeInsets.only(left: 0.8.h),
                                            alignment: Alignment.centerLeft,
                                            child:

                                            Text(
                                                  '₹'+ (allcatogaryproperty
                                                              ?.diffProduct?[
                                                                  index]
                                                              .minPrice.toString() ?? "N?A")
                                                           +
                                                      " - ₹" +
                                                      (allcatogaryproperty
                                                              ?.diffProduct?[
                                                                  index]
                                                              .maxPrice
                                                          .toString() ?? 'N/A'),
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 2.3.h,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffe2000f),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20.h,
              left: 1.h,
              right: 1.h,
              child:check? Container(
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
            )
          ],
        ),
      ),
    );
  }

  alldisplay() async {
    final Map<String, String> data = {};
    data['action'] = 'all_category_display';
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().allcatogeryapi(data).then((Response response) async {
          allproperty = allcategorydisplay.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && allproperty?.status == "success") {
            categorydisplay();
            setState(() {
              isloading = false;
            });
            if (kDebugMode) {}
          } else {
            setState(() {
              isloading = false;
            });
          }
        });
      } else {
        setState(() {
        isloading = false;
      });}
    });
  }
  categorydisplay() async {
    final Map<String, String> data = {};
    data['action'] = 'category_wise_product';
    data['category_id'] =(allproperty?.data?[gen!].id).toString();
    data['d_id'] = (userData?.logindata?.dId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .selectcategorydisplay(data)
            .then((Response response) async {
          allcatogaryproperty =
              categorywisedisplay.fromJson(json.decode(response.body));
          if (response.statusCode == 200 &&
              allcatogaryproperty?.status == "success") {

            setState(() {
              isloading = false;
            });
            if (kDebugMode) { }
          } else {
            setState(() {
              isloading = false;
            });
          }
        });
      } else {
        setState(() {
        isloading = false;
      });
      }
    });
  }
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
              isloading = false;

            });
            if (kDebugMode) { }
          } else {
            setState(() {
            isloading = false;
          });}
        });
      } else {
        setState(() {
        isloading = false;
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
