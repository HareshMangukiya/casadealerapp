import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/modal_class/view_order.dart';


import 'package:casadealerapp/provider/productprovider.dart';

import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/screens/product_2.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;


class your_order extends StatefulWidget {
  const your_order({Key? key}) : super(key: key);

  @override
  State<your_order> createState() => _your_orderState();
}

class _your_orderState extends State<your_order> {

  search? searchproperty;

  bool? check = false;

  viewOrders? view;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _search = TextEditingController();
  bool se_icon = false;
  bool isLoading = true;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewapi();
  }

  @override
  Widget build(BuildContext context) {
    return  commanScreen(
      scaffold: Scaffold(
          backgroundColor: Color(0xfffFFFFFF),
          drawer: drawer(context),
          key: _scaffoldKey,
          body:isLoading ?Container(): Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: Color(0xfffFFFFFF),
              ),
              SingleChildScrollView(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    SizedBox(
                                      width: 2.3.h,
                                    ),
                                    Container(
                                      // padding: EdgeInsets.only(top: 1.5.h),
                                      // alignment: Alignment.center,
                                      child: Text(
                                        "Your Orders",
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
                                    // SizedBox(
                                    //   width: 1.h,
                                    // ),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     // Navigator.push(
                                    //     //     context,
                                    //     //     MaterialPageRoute(
                                    //     //         builder: (context) =>
                                    //     //             cart_order()));
                                    //     // _scaffoldKey.currentState?.openDrawer();
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.shopping_bag_outlined,
                                    //     color: Colors.white,
                                    //     size: 3.h,
                                    //   ),
                                    // ),
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
                    Container(
                      height: 88.h,
                      child:view?.status == "fail" ?Center(child:Text("No Product in Your order",style: TextStyle(
                          color:Colors.black,fontWeight: FontWeight.bold
                      ),)): ListView.builder(
                        itemCount: view?.data?.length,
                        itemBuilder: ( context,  index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => order_id(id:view?.data?[index].ordNo,
                                    index1:index,
                                  )));
                            },
                            child: Container(
                              // padding: EdgeInsets.all(0),
                              // alignment: Alignment.center,
                              height: 11.h,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color(0xfffafafa),
                                border: Border.all(color: Color(0xffe8e8e8)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child:
                                    CachedNetworkImage(
                                        height: 11.h,
                                        width: 20.w,
                                        fit: BoxFit.cover,
                                        imageUrl:view
                                            ?.data?[index]
                                            .imageOne ??
                                            "",
                                        progressIndicatorBuilder: (context,
                                            url, downloadProgress) =>
                                            CircularProgressIndicator(
                                                value: downloadProgress
                                                    .progress),
                                        errorWidget: (context, url, error) =>
                                            Image.asset( "assets/default_product_image.png",
                                              height: 11.h,
                                              width: 20.w,
                                              fit: BoxFit.cover,

                                            )
                                    ),


                                  ),
                                  // SizedBox(width: 5.w,),

                                  Padding(
                                    padding: EdgeInsets.all(1.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Order ID # ' +
                                                  (view?.data?[index].ordNo)
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2.h),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 1.5.h),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'No of Products : ',
                                              style: TextStyle(
                                                color: Color(0xff5a5858585),
                                              ),
                                            ),
                                            Text(
                                              view?.data?[index].numberOfProduct.toString() ?? "",

                                              style: TextStyle(
                                                color: Color(0xff5a5a9f),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(0.6.h),
                                          alignment: Alignment.center,
                                          height: 3.4.h,
                                          width: 21.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              color: (view?.data?[index].status ==
                                                  "1")
                                                  ? Color(0xfffaede7)
                                                  : (view?.data?[index].status ==
                                                  "2")
                                                  ? Color(0xffe1f5e2)
                                                  : Color(0xfffae7e7)),
                                          child: Text(
                                            (view?.data?[index].status == "1")
                                                ? "Placed"
                                                : (view?.data?[index].status == "2")
                                                ? "Confirmed"
                                                : "Cancle",
                                            // 'Placed',
                                            style: TextStyle(
                                                color: (view?.data?[index].status ==
                                                    "1")
                                                    ? Color(0xfff98b54)
                                                    : (view?.data?[index].status ==
                                                    "2")
                                                    ? Color(0xff48d34d)
                                                    : Color(0xfff97070),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 1.3.w),

                                  SizedBox(width: 9.w),
                                  Text(
                                    '₹' + (view?.data?[index].price).toString() == null ? "N/A" :"₹" + (view?.data?[index].price).toString(),
                                    // '₹5,925',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.2.h,
                                        color: Color(0xff3b3b8d)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                  padding:EdgeInsets.only(left: 1.h,  top: 20.h,
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
                      child:(view?.data?.length == 0) ? Center(child: Text("No Product in Block order")): ListView.builder(
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
        ), isLoading: isLoading,
    );

  }

  viewapi() async {
    final Map<String, String> data = {};
    data['action'] = 'view_order';
    data['d_id'] = (userData?.logindata?.dId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .view_product_order(data)
            .then((Response response) async {
          view = viewOrders.fromJson(json.decode(response.body));
          // isloading = false;

          if (response.statusCode == 200 && view?.status == "success") {
            setState(() {
              isLoading =false;
            });
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
  viewcart()async {
    final Map<String, String> data = {};
    data['action'] = 'view_add_to_cart_product_single';
    data['d_id'] = (userData?.logindata?.dId).toString();


    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().viewcartapi(data).then((Response response) async {
          viewaddtocart = ViewCart.fromJson(json.decode(response.body));

          if (response.statusCode == 200 &&
              viewaddtocart?.status == "success") {




          }
          else {

          }
        });
      } else {

      }
    });
  }
}
