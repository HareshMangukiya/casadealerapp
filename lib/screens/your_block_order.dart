import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';

import 'package:casadealerapp/modal_class/block_orderView.dart';
import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/modal_class/view_order.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/alert_screen.dart';

import 'package:casadealerapp/screens/order_detail.dart';
import 'package:casadealerapp/screens/orderblockdisplay.dart';
import 'package:casadealerapp/screens/product_2.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;


class your_block_order extends StatefulWidget {
  const your_block_order({Key? key}) : super(key: key);

  @override
  State<your_block_order> createState() => _your_block_orderState();
}

class _your_block_orderState extends State<your_block_order> {

  TextEditingController _search = TextEditingController();
  bool se_icon = false;
  bool check = false;
  search? searchproperty;

  viewBlockOrder? blockview2;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blockViewOrderapi();
    viewcart();
  }
bool isLoading=true;
  int? select=0;
  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body:
        isLoading ? Container():Stack(
          children: [
            Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xfffFFFFFF),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
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
                                        "Your blocked Orders",
                                        style: TextStyle(
                                            fontSize: 2.h, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 8.w,
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
                                        badgeContent: Text((viewaddtocart?.addToCartNumber == 0 ||viewaddtocart?.addToCartNumber == null ) ? "0" :((viewaddtocart?.addToCartNumber).toString()),
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

                        color: Color(0xfff3faff),

                        borderRadius: BorderRadius.all(
                          Radius.circular(15),

                        ),
                      ),
                    ),
                    Padding(
                      // top: 20.h,
                      padding: EdgeInsets.only(left: 1.h,
                        right: 1.h,),
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
                Column(
                  children: [
                    Container(
                      height: 88.h,
                      child: blockview2?.data?.length == 0 ?Center(child:Text("No Product in blocked order",style: TextStyle(
                        color:Colors.black,fontWeight: FontWeight.bold

                      ),)) :ListView.builder(
                        itemCount: blockview2?.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => orderblockdisplay(
                                        id:blockview2?.data?[index].ordNo
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
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:
                                        CachedNetworkImage(
                                            height: 11.h,
                                            width: 20.w,
                                            fit: BoxFit.cover,
                                            imageUrl:blockview2
                                                ?.data?[index]
                                                .imageOne ??
                                                "",
                                             placeholder:
                                            (context, url) =>
                                Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Image.asset( "assets/default_product_image.png",
                                                    height: 11.h,
                                                      width: 20.w,
                                                      fit: BoxFit.cover,

                                                )
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Order ID # ' + (blockview2?.data?[index].ordNo.toString() ?? "N/A"),
                                                  // +  (view?.data?[index].productNumberOrder).toString() ?? "" ,

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
                                                  // (view?.data?[index].productNumberOrder).toString() ?? "" ,

                                                   (blockview2?.data?[index]?.numberOfProduct.toString() ?? ""),

                                                  style: TextStyle(
                                                    color: Color(0xff5a5a9f),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 3.4.h,
                                              width: 18.w,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 1.3.w),
                                  Row(
                                    children: [
                                      Text(
                                        '₹' + (blockview2?.data?[index].price).toString() ?? "" ,
                                        // '₹5,925',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.2.h,
                                            color: Color(0xff3b3b8d)),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xffe2e2ed),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          height: 5.h,
                                          width: 10.w,
                                          child: PopupMenuButton(
                                            onSelected: (value) {

                                            },
                                            itemBuilder: (BuildContext bc) {
                                              return [
                                                PopupMenuItem(

                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  order_detail_c()));
                                                    },
                                                    child: Text("Edit",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color(0xff333389))),
                                                  ),
                                                  value: '/hello',
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {
                                                    setState((){
                                                      select = index;
                                                    });
                                                   converttoorder();
                                                  },
                                                  child: Text("Convert to order",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)
                                                  ),
                                                  value: '/about',
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                alert_screen(id:blockview2?.data?[index].ordNo)
                                                        )
                                                    );
                                                  },
                                                  child: Text("Unblock order",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  value: '/contact',
                                                )
                                              ];
                                            },
                                          )
                                          // Icon(
                                          //   Icons.more_vert,
                                          //   color: Color(0xff5a5a9f),
                                          // ),
                                          ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),

            Positioned(
                top: 20.h,
                left: 2.h,
                right: 2.h,
                child:check? Container(
                  height: 40.h,
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
                                    builder: (context) =>
                                        products_1()));
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
            )
        ]),
      ), isLoading: isLoading,
    );
  }

  blockViewOrderapi() async {
    final Map<String, String> data = {};
    data['action'] = "view_order_block";
    data['d_id'] = (userData?.logindata?.dId).toString();

      checkInternet().then((internet) async {
        if (internet) {
          Productprovider().blockViewProvider(data).then((Response response) async {
            blockview2 = viewBlockOrder.fromJson(json.decode(response.body));
            print(blockview2?.status);

            if (response.statusCode == 200 && blockview2?.status == "success") {
              setState(() {
                // isLoading =false;
              });

            } else {
              setState(() {
                // isLoading =false;
              });
            }
          });
        } else {
          setState(() {
            // isLoading =false;
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
  converttoorder(){
    final Map<String, String> data = {};
    data['action'] = 'block_order_convert_confirm';
    data['d_id'] =(userData?.logindata?.dId).toString();
    data['order_no'] =  (blockview2?.data?[select!].ordNo).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .convertblockorderapi(data)
            .then((Response response) async {
          convertblockorder  convertorder = convertblockorder.fromJson(json.decode(response.body));
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
