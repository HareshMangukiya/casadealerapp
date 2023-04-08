import 'dart:convert';

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/add_to_cart_modal.dart';
import 'package:casadealerapp/modal_class/block_product_modal.dart';
import 'package:casadealerapp/modal_class/category_wise_display.dart';
import 'package:casadealerapp/modal_class/color_display_all_class.dart';
import 'package:casadealerapp/modal_class/color_modal.dart';
import 'package:casadealerapp/modal_class/product2_image_modal.dart';
import 'package:casadealerapp/modal_class/select_image_class.dart';
import 'package:casadealerapp/provider/login_authprovider.dart';
import 'package:casadealerapp/modal_class/productapiclass.dart';
import 'package:casadealerapp/provider/productprovider.dart';

import 'package:casadealerapp/modal_class/singlepro_class.dart';
import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/build_dialog.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:casadealerapp/widget/loader.dart';
import 'package:casadealerapp/widget/video_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';



import 'package:http/http.dart' as http;

class product_2 extends StatefulWidget {
  String? pronamenevigatior;
  String? coloridnevigator;
  String? gender;
  product_2({
    Key? key,
    this.pronamenevigatior,
    this.coloridnevigator,
    this.gender,
  }) : super(key: key);
  @override
  State<product_2> createState() => _product_2State();
}

class products {
  String? image;
  String? Brand_Name;
  String? Street_Wear;
  String? Artist_Name;
  String? Price;

  products(this.image, this.Brand_Name, this.Street_Wear, this.Artist_Name,
      this.Price);
}

class _product_2State extends State<product_2> {
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

  //TOTAL CONTROLLLER
  TextEditingController _totalms = TextEditingController();
  TextEditingController _totalxs = TextEditingController();
  TextEditingController _totalmm = TextEditingController();
  TextEditingController _total_ll = TextEditingController();
  TextEditingController _total_xl = TextEditingController();
  TextEditingController _total_xxl = TextEditingController();
  TextEditingController _total_3xl = TextEditingController();
  TextEditingController _total_4xl = TextEditingController();
  TextEditingController _total_5xl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  color? colorData;
  bool _customTileExpanded = false;

  int selectindex = 0;
  int btn = 0;
  int gen = 0;
  int cart = 0;
  int sumindex = 0;
  int selectbtn = 0;
  int selectgender = 0;
  int def = 0;

  //Api Total

  final PageController controller = PageController(initialPage: 0);
  List<products> images = [
    products("assets/default_product_image.png", "Brand Name", "Street Wear",
        "Artist Name", "\₹125"),
  ];

  List<String> tabs = ["Tripur", "Munbai"];

  List<String> image = [];
  productapi? productData;
  bool se_icon = false;
  categorywisedisplay? allcatogaryproperty;
  colorClass? product2color;
  // product2Imageclass? imageDisplay;
  selectColorImageClass? selectimage;
  colorDisplayClass? displayallcolor;
  blockProductClass? block;
  addtoCartClass? add;
  bool isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    await displaycolor();
    // await imageapi();
    await colorapi();
    await selectimageapi();
  }

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      isLoading: isloading,
      scaffold: Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body: isloading
            ? Container()
            : Form(
               key:_formKey,
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
                                        "Products",
                                        style: TextStyle(
                                            fontSize: 2.h, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 14.h,
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
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // _scaffoldKey.currentState?.openDrawer();
                                      },
                                      icon: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Colors.white,
                                        size: 3.h,
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
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: TextField(
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  // searchapi(value);
                                } else if (value.isEmpty) {
                                  // Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => products_1()));
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
                                // ),
                              ),
                            ),
                          ),
                    displayallcolor?.status == "fail"
                        ? Text('No Data Found',
                            style: TextStyle(
                                fontSize: 2.h, fontWeight: FontWeight.bold))
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 55.h,
                                        width: MediaQuery.of(context).size.width,
                                        // color: Colors.red,
                                      ),
                                      Positioned(
                                        top: 0.0,
                                        left: 0.0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                              // color: Colors.green,
                                            ),
                                            height: 55.h,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: (displayallcolor
                                                        ?.mumbaiStock?.length !=
                                                    0)
                                                ? (displayallcolor
                                                            ?.mumbaiStock?[0]
                                                            .menImageArray
                                                            ?.length ==
                                                        0)
                                                    ? CarouselSlider(
                                                        items: images.map((e) {
                                                          return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          28),
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              28),
                                                                    ),
                                                                    height: 54.h,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                            horizontal:
                                                                                5.w),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              28),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/default_product_image.png",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Opacity(
                                                                    opacity: 0.8,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5.w),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment
                                                                                .bottomCenter,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient: LinearGradient(
                                                                                begin: Alignment.topRight,
                                                                                colors: [
                                                                                  Colors.transparent,
                                                                                  Colors.black
                                                                                ]),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomRight:
                                                                                  Radius.circular(28),
                                                                              bottomLeft:
                                                                                  Radius.circular(28),
                                                                              topRight:
                                                                                  Radius.circular(28),
                                                                              topLeft:
                                                                                  Radius.circular(28),
                                                                            ),
                                                                          ),
                                                                          height:
                                                                              23.h,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 35.h,
                                                                    left: 8.w,
                                                                    right: 8.w,
                                                                    child:
                                                                        Container(
                                                                      // height: 10.h,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      // color:Colors.red,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Container(
                                                                            width: MediaQuery.of(context)
                                                                                .size
                                                                                .width,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    // Container(
                                                                                    //   alignment: Alignment.center,
                                                                                    //   width: MediaQuery.of(context).size.width * 0.2,
                                                                                    //   height: MediaQuery.of(context).size.height * 0.03,
                                                                                    //   decoration: BoxDecoration(
                                                                                    //     color: Color(0xfff7c7773),
                                                                                    //     borderRadius: BorderRadius.all(
                                                                                    //       Radius.circular(8),
                                                                                    //     ),
                                                                                    //   ),
                                                                                    //   child: Padding(
                                                                                    //     padding: EdgeInsets.all(0.5.h),
                                                                                    //     child: Text(
                                                                                    //       "Brand Name",
                                                                                    //       style: TextStyle(
                                                                                    //         fontSize: 1.3.h,
                                                                                    //         color: Colors.white,
                                                                                    //       ),
                                                                                    //     ),
                                                                                    //   ),
                                                                                    // ),
                                                                                    // SizedBox(
                                                                                    //   height: 1.h,
                                                                                    // ),
                                                                                    Container(
                                                                                      child: Text(
                                                                                        widget.pronamenevigatior ?? 'N/A',
                                                                                        style: TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                      ),
                                                                                    ),
                                                                                    // Container(
                                                                                    //   child: Text(
                                                                                    //     "Artist Name",
                                                                                    //     style: TextStyle(fontSize: 1.9.h, color: Colors.grey.shade300),
                                                                                    //   ),
                                                                                    // ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    SizedBox(width: 3.w),
                                                                                    Container(
                                                                                      alignment: Alignment.center,
                                                                                      height: 4.h,
                                                                                      width: 9.w,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                                                                                      child: IconButton(
                                                                                        icon: Icon(
                                                                                          Icons.share,
                                                                                          color: Colors.grey,
                                                                                          size: 2.h,
                                                                                        ),
                                                                                        onPressed: () {},
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          // SizedBox()
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ));
                                                        }).toList(),
                                                        options: CarouselOptions(
                                                          height: 45.h,
                                                          enlargeCenterPage:
                                                              false,
                                                          autoPlay: true,
                                                          aspectRatio: 16 / 9,
                                                          autoPlayCurve: Curves
                                                              .fastOutSlowIn,
                                                          enableInfiniteScroll:
                                                              true,
                                                          autoPlayAnimationDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      800),
                                                          viewportFraction: 1,
                                                        ),
                                                      )
                                                    : CarouselSlider(
                                                        items: (displayallcolor
                                                                    ?.mumbaiStock?[
                                                                        0]
                                                                    .menImageArray ??
                                                                [])
                                                            .map((e) {
                                                          return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          28),
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              28),
                                                                    ),
                                                                    height: 54.h,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                            horizontal:
                                                                                5.w),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(28),
                                                                        child: CachedNetworkImage(
                                                                          imageUrl:
                                                                              e,
                                                                          imageBuilder:
                                                                              (context, imageProvider) =>
                                                                                  Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image:
                                                                                  DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder:
                                                                              (context, url) =>
                                                                                  Center(child: CircularProgressIndicator()),
                                                                          errorWidget: (context,
                                                                                  url,
                                                                                  error) =>
                                                                              Image.asset(
                                                                            "assets/default_product_image.png",
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                  Opacity(
                                                                    opacity: 0.8,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5.w),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment
                                                                                .bottomCenter,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient: LinearGradient(
                                                                                begin: Alignment.topRight,
                                                                                colors: [
                                                                                  Colors.transparent,
                                                                                  Colors.black
                                                                                ]),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomRight:
                                                                                  Radius.circular(28),
                                                                              bottomLeft:
                                                                                  Radius.circular(28),
                                                                              topRight:
                                                                                  Radius.circular(28),
                                                                              topLeft:
                                                                                  Radius.circular(28),
                                                                            ),
                                                                          ),
                                                                          height:
                                                                              23.h,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 35.h,
                                                                    left: 8.w,
                                                                    right: 8.w,
                                                                    child:
                                                                        Container(
                                                                      // height: 10.h,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      // color:Colors.red,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Container(
                                                                            width: MediaQuery.of(context)
                                                                                .size
                                                                                .width,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    // Container(
                                                                                    //   alignment: Alignment.center,
                                                                                    //   width: MediaQuery.of(context).size.width * 0.2,
                                                                                    //   height: MediaQuery.of(context).size.height * 0.03,
                                                                                    //   decoration: BoxDecoration(
                                                                                    //     color: Color(0xfff7c7773),
                                                                                    //     borderRadius: BorderRadius.all(
                                                                                    //       Radius.circular(8),
                                                                                    //     ),
                                                                                    //   ),
                                                                                    //   child: Padding(
                                                                                    //     padding: EdgeInsets.all(0.5.h),
                                                                                    //     child: Text(
                                                                                    //       "Brand Name",
                                                                                    //       style: TextStyle(
                                                                                    //         fontSize: 1.3.h,
                                                                                    //         color: Colors.white,
                                                                                    //       ),
                                                                                    //     ),
                                                                                    //   ),
                                                                                    // ),
                                                                                    // SizedBox(
                                                                                    //   height: 1.h,
                                                                                    // ),
                                                                                    Container(
                                                                                      child: Text(
                                                                                        widget.pronamenevigatior ?? 'N/A',
                                                                                        style: TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                      ),
                                                                                    ),
                                                                                    // Container(
                                                                                    //   child: Text(
                                                                                    //     "Artist Name",
                                                                                    //     style: TextStyle(fontSize: 1.9.h, color: Colors.grey.shade300),
                                                                                    //   ),
                                                                                    // ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      alignment: Alignment.center,
                                                                                      height: 4.h,
                                                                                      width: 9.w,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                                                                                      child: IconButton(
                                                                                        icon: Icon(
                                                                                          Icons.share,
                                                                                          color: Colors.grey,
                                                                                          size: 2.h,
                                                                                        ),
                                                                                        onPressed: () {},
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          // SizedBox()
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ));
                                                        }).toList(),
                                                        options: CarouselOptions(
                                                          height: 45.h,
                                                          enlargeCenterPage:
                                                              false,
                                                          autoPlay: true,
                                                          aspectRatio: 16 / 9,
                                                          autoPlayCurve: Curves
                                                              .fastOutSlowIn,
                                                          enableInfiniteScroll:
                                                              true,
                                                          autoPlayAnimationDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      800),
                                                          viewportFraction: 1,
                                                        ),
                                                      )
                                                : (displayallcolor?.tripurStock
                                                            ?.length !=
                                                        0)
                                                    ? (displayallcolor
                                                                ?.tripurStock?[0]
                                                                .menImageArray
                                                                ?.length ==
                                                            0)
                                                        ? CarouselSlider(
                                                            items:
                                                                images.map((e) {
                                                              return ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              28),
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(28),
                                                                        ),
                                                                        height:
                                                                            54.h,
                                                                        width: MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .width,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5.w),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(28),
                                                                          child: Image
                                                                              .asset(
                                                                            "assets/default_product_image.png",
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Opacity(
                                                                        opacity:
                                                                            0.8,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 5.w),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.bottomCenter,
                                                                            child:
                                                                                Container(
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topRight, colors: [
                                                                                  Colors.transparent,
                                                                                  Colors.black
                                                                                ]),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomRight: Radius.circular(28),
                                                                                  bottomLeft: Radius.circular(28),
                                                                                  topRight: Radius.circular(28),
                                                                                  topLeft: Radius.circular(28),
                                                                                ),
                                                                              ),
                                                                              height:
                                                                                  23.h,
                                                                              width:
                                                                                  MediaQuery.of(context).size.width,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top: 35.h,
                                                                        left: 8.w,
                                                                        right:
                                                                            8.w,
                                                                        child:
                                                                            Container(
                                                                          // height: 10.h,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          // color:Colors.red,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                               
                                                                                        Container(
                                                                                          child: Text(
                                                                                            widget.pronamenevigatior ?? 'N/A',
                                                                                            style: TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                          ),
                                                                                        ),
                                                                           
                                                                                      ],
                                                                                    ),

                                                                             

                                                                                    Row(
                                                                                      children: [
                                                                                        SizedBox(width: 3.w),
                                                                                        Container(
                                                                                          alignment: Alignment.center,
                                                                                          height: 4.h,
                                                                                          width: 9.w,
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                                                                                          child: IconButton(
                                                                                            icon: Icon(
                                                                                              Icons.share,
                                                                                              color: Colors.grey,
                                                                                              size: 2.h,
                                                                                            ),
                                                                                            onPressed: () {},
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                       
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ));
                                                            }).toList(),
                                                            options:
                                                                CarouselOptions(
                                                              height: 45.h,
                                                              enlargeCenterPage:
                                                                  false,
                                                              autoPlay: true,
                                                              aspectRatio: 16 / 9,
                                                              autoPlayCurve: Curves
                                                                  .fastOutSlowIn,
                                                              enableInfiniteScroll:
                                                                  true,
                                                              autoPlayAnimationDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          800),
                                                              viewportFraction: 1,
                                                            ),
                                                          )
                                                        : CarouselSlider(
                                                            items: (displayallcolor
                                                                        ?.mumbaiStock?[
                                                                            0]
                                                                        .menImageArray ??
                                                                    [])
                                                                .map((e) {
                                                              return ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              28),
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(28),
                                                                        ),
                                                                        height:
                                                                            54.h,
                                                                        width: MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .width,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5.w),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(28),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                e,
                                                                            imageBuilder: (context, imageProvider) =>
                                                                                Container(
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: imageProvider,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                CircularProgressIndicator(),
                                                                            errorWidget: (context, url, error) =>
                                                                                Image.asset(
                                                                              "assets/default_product_image.png",
                                                                          
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Opacity(
                                                                        opacity:
                                                                            0.8,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 5.w),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.bottomCenter,
                                                                            child:
                                                                                Container(
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topRight, colors: [
                                                                                  Colors.transparent,
                                                                                  Colors.black
                                                                                ]),
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomRight: Radius.circular(28),
                                                                                  bottomLeft: Radius.circular(28),
                                                                                  topRight: Radius.circular(28),
                                                                                  topLeft: Radius.circular(28),
                                                                                ),
                                                                              ),
                                                                              height:
                                                                                  23.h,
                                                                              width:
                                                                                  MediaQuery.of(context).size.width,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top: 35.h,
                                                                        left: 8.w,
                                                                        right:
                                                                            8.w,
                                                                        child:
                                                                            Container(
                                                                          // height: 10.h,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          // color:Colors.red,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          child: Text(
                                                                                            widget.pronamenevigatior ?? 'N/A',
                                                                                           
                                                                                            style: TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                          ),
                                                                                        ),
                                                                                        // Container(
                                                                                        //   child: Text(
                                                                                        //     "Artist Name",
                                                                                        //     style: TextStyle(
                                                                                        //         fontSize: 1.9.h,
                                                                                        //         // fontWeight:
                                                                                        //         //     FontWeight
                                                                                        //         //         .bold,
                                                                                        //         color: Colors.grey.shade300),
                                                                                        //   ),
                                                                                        // ),
                                                                                      ],
                                                                                    ),

                                                                                    // SizedBox(
                                                                                    //   width: 20.w,
                                                                                    // ),

                                                                                    Row(
                                                                                      children: [
                                                                                       
                                                                                        SizedBox(width: 3.w),
                                                                                        Container(
                                                                                          alignment: Alignment.center,
                                                                                          height: 4.h,
                                                                                          width: 9.w,
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                                                                                          child: IconButton(
                                                                                            icon: Icon(
                                                                                              Icons.share,
                                                                                              color: Colors.grey,
                                                                                              size: 2.h,
                                                                                            ),
                                                                                            onPressed: () {},
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              // SizedBox()
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ));
                                                            }).toList(),
                                                            options:
                                                                CarouselOptions(
                                                              height: 45.h,
                                                              enlargeCenterPage:
                                                                  false,
                                                              autoPlay: true,
                                                              aspectRatio: 16 / 9,
                                                              autoPlayCurve: Curves
                                                                  .fastOutSlowIn,
                                                              enableInfiniteScroll:
                                                                  true,
                                                              autoPlayAnimationDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          800),
                                                              viewportFraction: 1,
                                                            ),
                                                          )
                                                    : Text("No data found")
                                            // :Image.asset("assets/product_1_img.png")
                                            ),
                                      ),
                                      Positioned(
                                        top: 48.5.h,
                                        left: 41.w,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width:30.w,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.025,
                                          decoration: BoxDecoration(
                                            // border: Border.all(color: Colors.grey.shade200,),
                                            color: Color(0xff333389),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: SmoothPageIndicator(
                                            controller: controller,
                                            count: displayallcolor
                                                ?.mumbaiStock?[0].menImageArray?.length ?? 0,
                                            axisDirection: Axis.horizontal,
                                            effect: SlideEffect(
                                                spacing: 8.0,
                                                radius: 15.0,
                                                dotWidth: 7.0,
                                                dotHeight: 8.0,
                                                paintStyle: PaintingStyle.fill,
                                                strokeWidth: 1.5,
                                                dotColor: Colors.grey.shade300,
                                                activeDotColor: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.h),
                              
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.h),
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(top: 1.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Select Color",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 2.4.h,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 4.5.h,
                                                        width: 9.w,
                                                        child: CircleAvatar(
                                                          // radius: 7.w,
                                                          child: ClipOval(
                                                            child: Image.network(
                                                              product2color
                                                                      ?.data?[
                                                                          selectbtn]
                                                                      .colorImage ??
                                                                  '',
                                                              width: 12.w,
                                                              height: 13.w,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xffbababa))),
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Container(
                                                        width: 40.w,
                                                        child: Text(
                                                            product2color
                                                                    ?.data?[
                                                                        selectbtn]
                                                                    .colorName ??
                                                                '',
                                                            maxLines: 2,
                                                            // 'Red',
                                                            style: TextStyle(
                                                              fontSize: 2.5.h,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            )),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.h, right: 2.h),
                                          child: Divider(
                                              color: Colors.grey.shade400),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.h),
                                          child: Container(
                                              height: 18.18.h,
                                              width: 90.w,
                                              padding: EdgeInsets.all(9.0),
                                              child: GridView.builder(
                                                itemCount:
                                                    product2color?.data?.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 7,
                                                        crossAxisSpacing: 12.0,
                                                        childAspectRatio: 3 / 3,
                                                        mainAxisSpacing: 6.0),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          btn = index;
                                                          selectbtn = index;
                                                        });
                                                        selectimageapi();
                                                        displaycolor();
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 10.h,
                                                            width: 20.w,
                                                            child: CircleAvatar(
                                                              // radius: 7.w,
                                                              child: ClipOval(
                                                                child:
                                                                    Image.network(
                                                                  product2color
                                                                          ?.data?[
                                                                              index]
                                                                          .colorImage ??
                                                                      "",

                                                                  // 'assets/Red_Color.jpg',
                                                                  width: 10.w,
                                                                  height: 13.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              
                                                              ),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    // color: tripur[index],
                                                                    border: Border.all(
                                                                        color: Color(
                                                                            0xffbababa))),
                                                          ),
                                                          (btn == index)
                                                              ? Container(
                                                                  height: 10.h,
                                                                  width: 20.w,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .transparent),
                                                                  child: Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 15.sp,
                                                                  ),
                                                                )
                                                              : Container()
                                                        ],
                                                      ));
                                                },
                                              )),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.h),
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Select Gender",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2.4.h,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.h),
                                          child: Divider(
                                              color: Colors.grey.shade400),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.h),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      gen = 0;
                                                    });
                                                    displaycolor();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(0.1.h),
                                                    alignment: Alignment.center,
                                                    width: 10.h,
                                                    height: 5.h,
                                                    decoration: BoxDecoration(
                                                        color: (gen == 1)
                                                            ? Colors.white
                                                            : Color(0xfff333389),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff333389))),
                                                    child: Text(
                                                      'Men',
                                                      style: TextStyle(
                                                          color: (gen == 1)
                                                              ? Color(0xff333389)
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 2.h),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 0.6.h,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      gen = 1;
                                                      displaycolor();
                                                      _s.text = "";
                                                      _ts.text = "";
                                                      _totalms.text = "";

                                                      _xs.text = "";
                                                      _txs.text = "";
                                                      _totalxs.text = "";

                                                      _m.text = "";
                                                      _tm.text = "";
                                                      _totalmm.text = "";

                                                      _l.text = "";
                                                      _tl.text = "";
                                                      _total_ll.text = "";

                                                      _xl.text = "";
                                                      _txl.text = "";
                                                      _total_xl.text = "";

                                                      _xxl.text = "";
                                                      _txxl.text = "";
                                                      _total_xxl.text = "";

                                                      _3xl.text = "";
                                                      _t3xl.text = "";
                                                      _total_3xl.text = "";

                                                      _4xl.text = "";
                                                      _t4xl.text = "";
                                                      _total_4xl.text = "";

                                                      _5xl.text = "";
                                                      _t5xl.text = "";
                                                      _total_5xl.text = "";
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(0.1.h),
                                                    alignment: Alignment.center,
                                                    width: 14.h,
                                                    height: 5.h,
                                                    decoration: BoxDecoration(
                                                        color: (gen == 0)
                                                            ? Colors.white
                                                            : Color(0xfff333389),
                                                        // color:_selectedColor,

                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff333389))),
                                                    child: Text(
                                                      'Women',
                                                      style: TextStyle(
                                                          color: (gen == 0)
                                                              ? Color(0xff333389)
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 2.h),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Container(
                                            alignment: Alignment.center,
                                            height: 10.h,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            color: Color(0xfffeaeaf3),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.h),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 2.h),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 30.w,
                                                        child: Text(
                                                          "Color :",
                                                          style: TextStyle(
                                                            fontSize: 1.8.h,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 30.w,
                                                        child: Text(
                                                          "S - XL :",
                                                          style: TextStyle(
                                                            fontSize: 1.8.h,
                                                          ),
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   width: 6.h,
                                                      // ),

                                                      Container(
                                                        width: 30.w,
                                                        child: Text(
                                                          " 2XL - 3XL :",
                                                          style: TextStyle(
                                                            fontSize: 1.8.h,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 30.w,
                                                        child: Text(
                                                          // "Red",
                                                          product2color
                                                                  ?.data?[
                                                                      selectbtn]
                                                                  .colorName ??
                                                              '',
                                                          style: TextStyle(
                                                              fontSize: 2.h,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Color(
                                                                  0xfff333389)),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 30.w,
                                                        child: displayallcolor
                                                                        ?.priceArray?[
                                                                            0]
                                                                        .minPrice ==
                                                                    0 ||
                                                                displayallcolor
                                                                        ?.priceArray?[
                                                                            0]
                                                                        .minPrice ==
                                                                    null
                                                            ? Text(
                                                                "N/A",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        2.6.h,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xfff333389)),
                                                              )
                                                            : Text(
                                                                '₹' +
                                                                    (displayallcolor
                                                                            ?.priceArray?[
                                                                                0]
                                                                            .minPrice)
                                                                        .toString(),
                                                                // "₹125",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        2.6.h,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xfff333389)),
                                                              ),
                                                      ),
                                                      // SizedBox(
                                                      //   width: 6.h,
                                                      // ),

                                                      Container(
                                                        width: 30.w,
                                                        child: displayallcolor
                                                                        ?.priceArray?[
                                                                            0]
                                                                        .minPrice ==
                                                                    0 ||
                                                                displayallcolor
                                                                        ?.priceArray?[
                                                                            0]
                                                                        .minPrice ==
                                                                    null
                                                            ? Text(
                                                                "N/A",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        2.6.h,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xfff333389)),
                                                              )
                                                            : Text(
                                                                '₹' +
                                                                    (displayallcolor
                                                                            ?.priceArray?[
                                                                                0]
                                                                            .maxPrice)
                                                                        .toString(),
                                                                // " ₹150",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        2.6.h,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xfff333389)),
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                        SizedBox(
                                          height: 3.5.h,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 7.w, left: 3.w, bottom: 2.h),
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Size",
                                                  style: TextStyle(fontSize: 2.h),
                                                ),
                                                // SizedBox(width: 1.8.h),
                                                Text("Mumbai",
                                                    style:
                                                        TextStyle(fontSize: 2.h)),
                                                // SizedBox(width: 1.8.h),
                                                Text("Tripur",
                                                    style:
                                                        TextStyle(fontSize: 2.h)),
                                                // SizedBox(width: 1.8.h),
                                                Text("Total",
                                                    style:
                                                        TextStyle(fontSize: 2.h)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.all(8.0),
                                        //   child:
                                        //       Divider(color: Colors.grey.shade400),
                                        // ),

                                        Container(
                                          height: 12.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Color(0xfff9f9f9),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "XS",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      regex.hasMatch((displayallcolor
                                                                  ?.mumbaiStock?[
                                                                      0]
                                                                  .xs)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .xs)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.mumbaiStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .xs ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      // '432',
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color:
                                                                 Color(
                                                                    0xfff333389))),
                                                        child:TextFormField(
                                                          readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .xs)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .xs)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          validator:(value){
                                                            if(value!.isEmpty){

                                                            }
                                                          },

                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _xs,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,

                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // contentPadding: EdgeInsets.only(top: 0.1.w),

                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      regex.hasMatch((displayallcolor
                                                                  ?.tripurStock?[
                                                                      0]
                                                                  .xs)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .xs)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.tripurStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .xs ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      // '432',
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                           readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .xs)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .xs)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _txs,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',

                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      totalxs.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },

                                                          controller: _totalxs,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',

                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.h),
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "S ",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      regex.hasMatch((displayallcolor
                                                                  ?.mumbaiStock?[
                                                                      0]
                                                                  .s)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .s)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.mumbaiStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .s ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      // '432',
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          readOnly: regex.hasMatch(
                                                                  (displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .s)
                                                                      .toString())
                                                              ? (int.parse((displayallcolor
                                                                              ?.mumbaiStock?[0]
                                                                              .s)
                                                                          .toString()) >
                                                                      0)
                                                                  ? false
                                                                  : true
                                                              : true,
                                                          controller: _s,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,

                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // contentPadding: EdgeInsets.only(top: 0.1.w),

                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      regex.hasMatch((displayallcolor
                                                                  ?.tripurStock?[
                                                                      0]
                                                                  .s)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .s)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.tripurStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .s ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      // '432',
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                                readOnly: regex.hasMatch(
                                                                (displayallcolor
                                                                    ?.tripurStock?[
                                                                0]
                                                                    .s)
                                                                    .toString())
                                                                ? (int.parse((displayallcolor
                                                                ?.tripurStock?[0]
                                                                .s)
                                                                .toString()) >
                                                                0)
                                                                ? false
                                                                : true
                                                                : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },

                                                          controller: _ts,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',

                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      totals.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },

                                                          controller: _totalms,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 12.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Color(0xfff9f9f9),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "M ",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      regex.hasMatch((displayallcolor
                                                                  ?.mumbaiStock?[
                                                                      0]
                                                                  .m)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .m)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.mumbaiStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .m ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      // '432',
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .m)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .m)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _m,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                                  ?.tripurStock?[
                                                                      0]
                                                                  .m)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .m)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.tripurStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .m ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .m)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .m)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _tm,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      totalm.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },

                                                          controller: _totalmm,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.h),
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "L ",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                                  ?.mumbaiStock?[
                                                                      0]
                                                                  .l)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .l)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.mumbaiStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .l ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .l)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .l)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _l,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                                  ?.tripurStock?[
                                                                      0]
                                                                  .l)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .l)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.tripurStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .l ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .l)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .l)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _tl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      totall.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _total_ll,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 12.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Color(0xfff9f9f9),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "XL",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                                  ?.mumbaiStock?[
                                                                      0]
                                                                  .xl)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .xl)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.mumbaiStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .xl ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _xl,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                                  ?.tripurStock?[
                                                                      0]
                                                                  .xl)
                                                              .toString())
                                                          ? int.parse((displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .xl)
                                                                      .toString()) >=
                                                                  0
                                                              ? (displayallcolor
                                                                          ?.tripurStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                          ?.tripurStock?[
                                                                              0]
                                                                          .xl ??
                                                                      '')
                                                                  : ""
                                                              : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _txl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      totalxl.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _total_xl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.h),
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "2XL",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      regex.hasMatch((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .xxl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .xxl)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.mumbaiStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .xxl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .xxl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .xxl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _xxl,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .xxl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .xs)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.tripurStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .xxl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .xxl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .xxl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _txxl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      total2xl.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _total_xxl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 12.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Color(0xfff9f9f9),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "3XL",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s3xl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s3xl)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.mumbaiStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s3xl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .s3xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .s3xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _3xl,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s3xl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s3xl)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.tripurStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s3xl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .s3xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .s3xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _t3xl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      total3xl.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _total_3xl,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.h),
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "4XL",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s4xl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s4xl)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.mumbaiStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s4xl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .s4xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .s4xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _4xl,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s4xl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s4xl)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.tripurStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s4xl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .s4xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .s4xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _t4xl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      total4xl.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                         
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _total_4xl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 12.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Color(0xfff9f9f9),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "5XL",
                                                  style: TextStyle(
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s5xl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s5xl)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.mumbaiStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.mumbaiStock?[
                                                      0]
                                                          .s5xl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.mumbaiStock?[
                                                              0]
                                                                  .s5xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .s5xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _5xl,

                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      // '432',
                                                      regex.hasMatch((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s5xl)
                                                          .toString())
                                                          ? int.parse((displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s5xl)
                                                          .toString()) >=
                                                          0
                                                          ? (displayallcolor
                                                          ?.tripurStock
                                                          ?.length !=
                                                          0)
                                                          ? (displayallcolor
                                                          ?.tripurStock?[
                                                      0]
                                                          .s5xl ??
                                                          '')
                                                          : ""
                                                          : "0"
                                                          : "0",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                            readOnly: regex.hasMatch(
                                                              (displayallcolor
                                                                  ?.tripurStock?[
                                                              0]
                                                                  .s5xl)
                                                                  .toString())
                                                              ? (int.parse((displayallcolor
                                                              ?.tripurStock?[0]
                                                              .s5xl)
                                                              .toString()) >
                                                              0)
                                                              ? false
                                                              : true
                                                              : true,
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _t5xl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                                // SizedBox(width: 5.w),
                                                //
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      total5xl.toString(),
                                                      // "432",
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 10.h,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xfff333389))),
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            updateTotal(value);
                                                          },
                                                          controller: _total_5xl,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                InputBorder.none,
                                                            hintText: '',
                                                            // suffixIcon: Column(
                                                            //
                                                            //   children: [
                                                            //     Icon(Icons.arrow_drop_up),
                                                            //     Icon(Icons.arrow_drop_down),
                                                            //   ],
                                                            // )
                                                          ),
                                                          // child: Text(
                                                          //   "1000",
                                                          //   style: TextStyle(
                                                          //       color: Color(0xff5a5a9f), fontWeight: FontWeight.bold),
                                                          // ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: EdgeInsets.all(2.h),
                                        //   child: Container(
                                        //     child: Row(
                                        //       crossAxisAlignment: CrossAxisAlignment.center,
                                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //       children: [
                                        //         Text(
                                        //           "Available Qty",
                                        //           style: TextStyle(
                                        //               fontSize: 2.5.h,
                                        //               fontWeight: FontWeight.bold),
                                        //         ),
                                        //         // SizedBox(width: 5.w),
                                        //         Container(
                                        //           width: 20.w,
                                        //           child: Divider(
                                        //               thickness: 2,
                                        //               color: Color(0xfff333389)),
                                        //         ),
                                        //         // SizedBox(width: 5.w),
                                        //         Container(
                                        //             alignment: Alignment.center,
                                        //             width: 11.8.h,
                                        //             height: 5.8.h,
                                        //             decoration: BoxDecoration(
                                        //                 borderRadius:
                                        //                     BorderRadius.circular(
                                        //                         15),
                                        //                 border: Border.all(
                                        //                     color: Color(
                                        //                         0xfff333389))),
                                        //             child: Text("550",
                                        //                 style: TextStyle(
                                        //                     fontSize: 2.5.h,
                                        //                     color:
                                        //                         Color(0xfff333389),
                                        //                     fontWeight:
                                        //                         FontWeight.bold))),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: EdgeInsets.all(2.h),
                                        //   child: Container(
                                        //     child: Row(
                                        //         crossAxisAlignment: CrossAxisAlignment.center,
                                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //       children: [
                                        //         Text(
                                        //           "Enter Quantity",
                                        //           style: TextStyle(
                                        //               fontSize: 2.5.h,
                                        //               fontWeight: FontWeight.bold),
                                        //         ),
                                        //         // SizedBox(width: 5.w),
                                        //         // Container(
                                        //         //   width: 20.w,
                                        //         //   child: Divider(
                                        //         //       thickness: 2,
                                        //         //       color: Color(0xfff333389)),
                                        //         // ),
                                        //         // SizedBox(width: 5.w),
                                        //         Container(
                                        //             alignment: Alignment.center,
                                        //             width: 45.w,
                                        //             height: 5.8.h,
                                        //             decoration: BoxDecoration(
                                        //                 color: Color(0xfff333389),
                                        //                 borderRadius:
                                        //                     BorderRadius.circular(
                                        //                         10),
                                        //                 border: Border.all(
                                        //                     color: Color(
                                        //                         0xfff333389))),
                                        //             child: Text("550",
                                        //                 style: TextStyle(
                                        //                     fontSize: 2.h,
                                        //                     color: Colors.white,
                                        //                     fontWeight:
                                        //                         FontWeight.bold))),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),

                                        Padding(
                                          padding: EdgeInsets.all(2.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey.shade200),
                                                borderRadius:
                                                    BorderRadius.circular(12)

                                                // boxShadow: [
                                                //   // BoxShadow(
                                                //   //   // color: Colors.grey.withOpacity(0.5), // color of the shadow
                                                //   //   spreadRadius: 5, // spread radius
                                                //   //   // blurRadius: 7, // blur radius
                                                //   //   offset: Offset(0, 3), // changes position of shadow
                                                //   // ),
                                                // ],

                                                ),
                                            child: ExpansionTile(
                                              title: Text('Size Chart'),
                                              children: <Widget>[
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  child: Container(
                                                    // height: 100.h,
                                                    child: ListTile(
                                                        title: Column(
                                                      children: [
                                                        Text(
                                                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                                          style: TextStyle(
                                                              fontSize: 2.h,
                                                              color: Colors
                                                                  .grey.shade600),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                "Size Chart",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        SizedBox(height: 1.h),
                                                        Divider(
                                                            color: Colors
                                                                .grey.shade400),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            'assets/product_2_img2.png',
                                                            fit: BoxFit.cover,
                                                            height: 33.5.h,
                                                            width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                          ),
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: (displayallcolor
                                                                      ?.mumbaiStock
                                                                      ?.length !=
                                                                  0)
                                                              ? (displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .sizeChart ==
                                                                      "null")
                                                                  ? Image.asset(
                                                                      "assets/default_product_image.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          40.h,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                    )

                                                                  // 'assets/size_chart.png',

                                                                  : Image.network(
                                                                      displayallcolor
                                                                              ?.mumbaiStock?[0]
                                                                              .sizeChart ??
                                                                          'N/A',

                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          40.h,
                                                                    )
                                                              : (displayallcolor
                                                                          ?.tripurStock
                                                                          ?.length !=
                                                                      0)
                                                                  ? (displayallcolor
                                                                              ?.tripurStock?[
                                                                                  0]
                                                                              .sizeChart ==
                                                                          "null")
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/default_product_image.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              40.h,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                        )

                                                                      // 'assets/size_chart.png',

                                                                      : Image
                                                                          .network(
                                                                          displayallcolor?.mumbaiStock?[0].sizeChart ??
                                                                              'N/A',
                                                                          // errorBuilder:
                                                                          //     (BuildContext context,
                                                                          //     Object exception,
                                                                          //     StackTrace?
                                                                          //     stackTrace) {
                                                                          //   return Image.asset(
                                                                          //     'assets/size_chart.png',
                                                                          //     fit: BoxFit.cover,
                                                                          //     height: 40.h,
                                                                          //     width: MediaQuery.of(
                                                                          //         context)
                                                                          //         .size
                                                                          //         .width,
                                                                          //   );
                                                                          // },
                                                                          // 'assets/size_chart.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              40.h,
                                                                        )
                                                                  : Text(
                                                                      "No data found"),
                                                        ),

                                                        SizedBox(height: 4.h),
                                                        Container(
                                                            alignment:
                                                                Alignment.center,
                                                            child: Text(
                                                                'Available Downloads')),
                                                        SizedBox(height: 3.h),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,

                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.09,
                                                          // color: Color(0xfff333389),
                                                          // padding:
                                                          //     EdgeInsets.only(left: 35, right: 40, bottom: 10, top: 20),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  var response =
                                                                      await http.get(
                                                                          Uri.parse(
                                                                              "https://images.unsplash.com/photo-1679858511193-f124745ad28b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"));
                                                                  String
                                                                      fileName =
                                                                      DateTime.now()
                                                                              .millisecondsSinceEpoch
                                                                              .toString() +
                                                                          ".jpeg";
                                                                  Directory?
                                                                      storageDirectory =
                                                                      await getExternalStorageDirectory();
                                                                  String
                                                                      directoryPath =
                                                                      storageDirectory!
                                                                          .path;
                                                                  File file = File(
                                                                      '$directoryPath/$fileName');
                                                                  await file
                                                                      .writeAsBytes(
                                                                          response
                                                                              .bodyBytes);
                                                                  String
                                                                      filePath =
                                                                      '${storageDirectory.path}/$fileName';

                                                                  try {
                                                                    final savedFile =
                                                                        await GallerySaver
                                                                            .saveImage(
                                                                                filePath);
                                                                    print(
                                                                        "Image saved to gallery: $savedFile");
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text('Image saved to gallery')),
                                                                    );
                                                                    final result =
                                                                        await OpenFile
                                                                            .open(
                                                                                filePath);
                                                                    // Use the Image.file widget to display the image
                                                                    // in the UI after it has been downloaded and saved.
                                                                    // Make sure to import the `dart:io` library.
                                                                    Image.file(File(
                                                                        filePath));

                                                                    // Save the image to the gallery
                                                                  } catch (e) {
                                                                    print(e
                                                                        .toString());
                                                                  }
                                                                },


                                                                style:
                                                                    ElevatedButton
                                                                        .styleFrom(
                                                                  minimumSize:
                                                                      Size(40.w,
                                                                          6.h),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xfff333389),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  'Image',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          2.h),
                                                                ),
                                                              ),

                                                              ElevatedButton(


                                                                onPressed: () {
                                                                  displayallcolor
                                                                          ?.mumbaiStock?[
                                                                              0]
                                                                          .videoSpecification
                                                                          .toString() ??
                                                                      '';
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              VideoPlayerPage(
                                                                                videoFilePath: 'https://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_2mb.mp4',
                                                                              )));
                                                                },
                                                                style:
                                                                    ElevatedButton
                                                                        .styleFrom(
                                                                  minimumSize:
                                                                      Size(40.w,
                                                                          6.h),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xfff333389),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  'Video',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          2.h),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.065,
                                                          // color: Color(0xfff333389),
                                                          // padding:
                                                          //     EdgeInsets.only(left: 35, right: 40, bottom: 10, top: 20),
                                                          child: ElevatedButton(
                                                            onPressed: () async {
                                                              var response =
                                                                  await http.get(
                                                                      Uri.parse(
                                                                          ("https://www.africau.edu/images/default/sample.pdf")));
                                                              String fileName =
                                                                  url
                                                                      .toString()
                                                                      .split('/')
                                                                      .last;
                                                              Directory?
                                                                  storageDirectory =
                                                                  await getExternalStorageDirectory();
                                                              String
                                                                  directoryPath =
                                                                  storageDirectory!
                                                                      .path;
                                                              File file = File(
                                                                  '$directoryPath/$fileName');
                                                              // Directory directory = await getApplicationDocumentsDirectory();
                                                              await file.writeAsBytes(
                                                                  response
                                                                      .bodyBytes);
                                                              String filePath =
                                                                  '${storageDirectory.path}/$fileName';

                                                              try {
                                                                final result =
                                                                    await OpenFile
                                                                        .open(
                                                                            filePath);
                                                              } catch (e) {
                                                                print(
                                                                    e.toString());
                                                              }
                                                              // displayallcolor
                                                              //         ?.mumbaiStock?[
                                                              //             0]
                                                              //         .catalogue
                                                              //         .toString() ??
                                                              //     '';
                                                              // Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //         builder: (context) => products_1()));
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xfff333389),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Download Catalogue',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          2.h),
                                                                ),
                                                                // Icon(
                                                                //   Icons.arrow_forward,
                                                                //   color: Colors.white,
                                                                //   size: 24.0,
                                                                //   semanticLabel:
                                                                //   'Text to announce in accessibility modes',
                                                                // ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                    displayallcolor?.status == "fail"
                        ? Text('')
                        : Container(
                            width: MediaQuery.of(context).size.width * 1,
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
                                        (displayallcolor?.mumbaiStock?.length ==
                                                    0) ||
                                                (displayallcolor
                                                        ?.tripurStock?.length ==
                                                    0)
                                            ? showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Container(
                                                      height: 30.h,
                                                      width: 80.w,
                                                      // padding: EdgeInsets.all(5.w),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                16),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 30.h,
                                                            width: 80.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                            // borderRadius: BorderRadius.circular(16),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3.w),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        // Icon(Icons.edit,color:Colors.white ,),
                                                                        Text(
                                                                          "",
                                                                          style: TextStyle(
                                                                              decoration:
                                                                                  TextDecoration.underline,
                                                                              fontSize: 16.sp,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: "Poppins"),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color: Colors
                                                                              .black,
                                                                        ))
                                                                  ],
                                                                ),
                                                                Form(
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      Text(
                                                                        "No Data Found !",
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .sp,
                                                                            color: Colors
                                                                                .black,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontFamily:
                                                                                "Poppins"),
                                                                      ),
                                                                      Text(
                                                                        "There is no stock avaliable !",
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .sp,
                                                                            color: Colors
                                                                                .black,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontFamily:
                                                                                "Poppins"),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets
                                                                            .all(3
                                                                                .w),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              40.w,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xff333389),
                                                                            borderRadius:
                                                                                BorderRadius.circular(30.0),
                                                                          ),
                                                                          height:
                                                                              40.0,
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              alignment:
                                                                                  Alignment.center,
                                                                              // backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                                                              padding:
                                                                                  MaterialStateProperty.all(
                                                                                EdgeInsets.symmetric(vertical: 1.h),
                                                                              ),
                                                                              shape:
                                                                                  MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(20.sp),
                                                                              )),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  "Oky",
                                                                                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontFamily: "Poppins", fontWeight: FontWeight.bold),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.0,
                                                                                ),
                                                                                // Icon(
                                                                                //   Icon,
                                                                                //   color: Colors.grey.shade700,
                                                                                // )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            :
                                        setState(() {
                                          cart = 0;

                                        });
                                        blockapi();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.1.h),
                                        alignment: Alignment.center,
                                        width: 44.w,
                                        height: 5.5.h,
                                        decoration: BoxDecoration(
                                            color: (cart == 0)
                                                ? Color(0xfff333389)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.white)),
                                        child: Text(
                                          'Block',
                                          style: TextStyle(
                                              color: (cart == 0)
                                                  ? Colors.white
                                                  : Color(0xff333389),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 2.5.h),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {

                                        setState(() {
                                          cart = 1;

                                        });
                                        addtocartapi();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.1.h),
                                        alignment: Alignment.center,
                                        width: 44.w,
                                        height: 5.5.h,
                                        decoration: BoxDecoration(
                                            color: (cart == 1)
                                                ? Color(0xfff333389)
                                                : Colors.white,
                                            // color:_selectedColor,

                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.white)),
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(
                                              color: (cart == 1)
                                                  ? Colors.white
                                                  : Color(0xff333389),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 2.5.h),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            decoration: BoxDecoration(
                              color: Color(0xfff333389),
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(10),
                              // ),
                            ),
                          ),
                  ],
                ),
            ),
      ),
    );
  }
//color display
  colorapi() async {
    final Map<String, String> data = {};
    data['action'] = 'all_color_display';

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().product2_color(data).then((Response response) async {
          product2color = colorClass.fromJson(json.decode(response.body));
          isloading = false;
          if (response.statusCode == 200 &&
              product2color?.status == "success") {
            selectimageapi();
            displaycolor();

              isloading = false;


            if (kDebugMode) {

            }
          } else {

              isloading = false;

          }
        });
      } else {

          isloading = false;

      }
    });
  }
  //
  // imageapi() async {
  //   final Map<String, String> data = {};
  //   data['action'] = 'single_product_display';
  //   data['product_name'] = widget.pronamenevigatior.toString();
  //
  //   checkInternet().then((internet) async {
  //     if (internet) {
  //       Productprovider().product2_image(data).then((Response response) async {
  //         imageDisplay =
  //             product2Imageclass.fromJson(json.decode(response.body));
  //
  //         isloading = false;
  //
  //         if (response.statusCode == 200 && imageDisplay?.status == "success") {
  //           setState(() {
  //             isloading = false;
  //           });
  //           if (kDebugMode) {
  //
  //           }
  //         } else {
  //           setState(() {
  //             isloading = false;
  //           });
  //         }
  //       });
  //     } else {
  //       setState(() {
  //         isloading = false;
  //       });
  //     }
  //   });
  // }
// select image according to color
  selectimageapi() async {
    final Map<String, String> data = {};
    data['action'] = 'color_select_display_img';
    data['color_name'] = product2color?.data?[selectbtn].colorName ?? '';
    data['product_id'] = widget.coloridnevigator.toString();

    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .product2_selectimage(data)
            .then((Response response) async {
          selectimage =
              selectColorImageClass.fromJson(json.decode(response.body));



          if (response.statusCode == 200 && selectimage?.status == "success") {

              isloading = false;

            if (kDebugMode) {

            }
          } else {

              isloading = false;

          }
        });
      } else {

          isloading = false;

      }
    });
  }
// color,image,stock data
  displaycolor() async {

      final Map<String, String> data = {};
      data['action'] = 'color_select_display_all_data';
      data['product_name'] = widget.pronamenevigatior.toString();
      data['gender_type'] = gen == 0 ? "MEN" : "WOMEN";
      data['color_name'] = product2color?.data?[selectbtn].colorName ?? '';
      data['d_id'] = (userData?.logindata?.dId).toString();

      checkInternet().then((internet) async {
        if (internet) {
          Productprovider()
              .product2_displaycolorselect(data)
              .then((Response response) async {
            displayallcolor =
                colorDisplayClass.fromJson(json.decode(response.body));

            if (response.statusCode == 200 &&
                displayallcolor?.status == "success") {
              print("tapdid"+(displayallcolor?.tripurStock?[0].tApdId).toString());
              // colorapi();
              setState((){
                isloading = false;
                totalxs =  (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()) : 0)  + (int.parse((displayallcolor?.tripurStock?[0].xs).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].xs).toString()) : 0);
                totalm =  (int.parse((displayallcolor?.mumbaiStock?[0].m).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].m).toString()) : 0 ) + (int.parse((displayallcolor?.tripurStock?[0].m).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].m).toString()) : 0);
                totals =  (int.parse((displayallcolor?.mumbaiStock?[0].s).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].s).toString()) : 0 ) + (int.parse((displayallcolor?.tripurStock?[0].s).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].s).toString()) : 0);
                totall =  (int.parse((displayallcolor?.mumbaiStock?[0].l).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].l).toString()) : 0)  + (int.parse((displayallcolor?.tripurStock?[0].l).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].l).toString()) : 0);
                totalxl =  (int.parse((displayallcolor?.mumbaiStock?[0].xl).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].xl).toString()) : 0)  + (int.parse((displayallcolor?.tripurStock?[0].xl).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].xl).toString()) : 0);
                total2xl =  (int.parse((displayallcolor?.mumbaiStock?[0].xxl).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].xxl).toString()) : 0)  + (int.parse((displayallcolor?.tripurStock?[0].xxl).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].xxl).toString()) : 0);
                total3xl =  (int.parse((displayallcolor?.mumbaiStock?[0].s3xl).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].s3xl).toString()) : 0)  + (int.parse((displayallcolor?.tripurStock?[0].s3xl).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].s3xl).toString()) : 0);
                total4xl =  (int.parse((displayallcolor?.mumbaiStock?[0].s4xl).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].s4xl).toString()) : 0)  + (int.parse((displayallcolor?.tripurStock?[0].s4xl).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].s4xl).toString()) : 0);
                total5xl =  (int.parse((displayallcolor?.mumbaiStock?[0].s5xl).toString()) > 0 ?int.parse((displayallcolor?.mumbaiStock?[0].s5xl).toString()) : 0)  + (int.parse((displayallcolor?.tripurStock?[0].s5xl).toString()) > 0 ?int.parse((displayallcolor?.tripurStock?[0].s5xl).toString()) : 0);

              });
              if (kDebugMode) {}
            } else {

              setState((){
                isloading = false;
              });

            }
          });
        } else {

          setState((){
            isloading = false;
          });

        }
      });


  }

   updateTotal(value) {
    // S3
    int s1 = int.tryParse(_s.text) ?? 0;
    int s2 = int.tryParse(_ts.text) ?? 0;
    _totalms.text = (s1 + s2).toString();


    //XS
    int xs1 = int.tryParse(_xs.text) ?? 0;
    int xs2 = int.tryParse(_txs.text) ?? 0;
    _totalxs.text = (xs1 + xs2).toString();

    //M

    int m1 = int.tryParse(_m.text) ?? 0;
    int m2 = int.tryParse(_tm.text) ?? 0;
    _totalmm.text = (m1 + m2).toString();

    //L

    int l1 = int.tryParse(_l.text) ?? 0;
    int l2 = int.tryParse(_tl.text) ?? 0;
    _total_ll.text = (l1 + l2).toString();

    //XL

    int xl1 = int.tryParse(_xl.text) ?? 0;
    int xl2 = int.tryParse(_txl.text) ?? 0;
    _total_xl.text = (xl1 + xl2).toString();

    //2XL

    int xxl1 = int.tryParse(_xxl.text) ?? 0;
    int xxl2 = int.tryParse(_txxl.text) ?? 0;
    _total_xxl.text = (xxl1 + xxl2).toString();

    //3XL

    int xxxl1 = int.tryParse(_3xl.text) ?? 0;
    int xxxl2 = int.tryParse(_t3xl.text) ?? 0;
    _total_3xl.text = (xxxl1 + xxxl2).toString();

    //4XL

    int xxxxl1 = int.tryParse(_4xl.text) ?? 0;
    int xxxxl2 = int.tryParse(_t4xl.text) ?? 0;
    _total_4xl.text = (xxxxl1 + xxxxl2).toString();

    //5XL
    int xxxxxl1 = int.tryParse(_5xl.text) ?? 0;
    int xxxxxl2 = int.tryParse(_t5xl.text) ?? 0;
    _total_5xl.text = (xxxxxl1 + xxxxxl2).toString();
  }
//block product
  blockapi() async {

    if(_xs.text == "" && _txs.text == "" && _s.text == "" && _ts.text == ""
      && _m.text == "" && _tm.text == "" && _l.text == "" && _tl.text == ""
    && _xl.text == "" && _txl.text == "" && _xxl.text == "" && _txxl.text == ""
    && _3xl.text == "" && _t3xl.text == "" && _4xl.text == "" && _t4xl.text == ""
    && _5xl.text == "" && _t5xl.text == ""){

      buildErrorDialog(this.context,"","No Product Bolcked!");
    }
   else{

      final Map<String, String> data = {};
      data['action'] = 'block_produt_wise';
      data['t_ap_id'] = displayallcolor?.tripurStock?[0].tApId != null ? (displayallcolor?.tripurStock?[0].tApId).toString() : "0";
      data['t_apd_id'] =displayallcolor?.tripurStock?[0].tApdId !=null ? (displayallcolor?.tripurStock?[0].tApdId).toString() : "0";
      data['m_ap_id'] =displayallcolor?.mumbaiStock?[0].mApId != null ?(displayallcolor?.mumbaiStock?[0].mApId).toString(): "0";
      data['m_apd_id'] = displayallcolor?.mumbaiStock?[0].mApdId != null ? (displayallcolor?.mumbaiStock?[0].mApdId).toString() : "0";
      data['d_id'] = (userData?.logindata?.dId).toString();
      data['gender_type'] =gen == 0 ? "MEN" : "WOMEN";
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
              .product2blockprovider(data)
              .then((Response response) async {
            block = blockProductClass.fromJson(json.decode(response.body));
            if (response.statusCode == 200 && block?.status == "success") {
              isloading = false;
              Navigator.push(
                  this.context,
                  MaterialPageRoute(
                      builder: (context) => summary(
                          pronamenevigatior:
                          widget
                              .pronamenevigatior
                              .toString(),
                          coloridnevigator:product2color?.data?[btn].colorName,
                          gender: gen == 0
                              ? "MEN"
                              : "WOMEN",
                      cart:cart)));
              // _s.text = "";
              // _ts.text = "";
              // _totalms.text = "";
              //
              // _xs.text = "";
              // _txs.text = "";
              // _totalxs.text = "";
              //
              // _m.text = "";
              // _tm.text = "";
              // _totalmm.text = "";
              //
              // _l.text = "";
              // _tl.text = "";
              // _total_ll.text = "";
              //
              // _xl.text = "";
              // _txl.text = "";
              // _total_xl.text = "";
              //
              // _xxl.text = "";
              // _txxl.text = "";
              // _total_xxl.text = "";
              //
              // _3xl.text = "";
              // _t3xl.text = "";
              // _total_3xl.text = "";
              //
              // _4xl.text = "";
              // _t4xl.text = "";
              // _total_4xl.text = "";
              //
              // _5xl.text = "";
              // _t5xl.text = "";
              // _total_5xl.text = "";
              if (kDebugMode) {}
            } else {

              isloading = false;
              buildErrorDialog1(this.context, "", 'Already block product.',0);

            }
          });
        } else {

          isloading = false;

        }
      });
    }
  }
//add to cart
  addtocartapi() async {
    if(_xs.text == "" && _txs.text == "" && _s.text == "" && _ts.text == ""
        && _m.text == "" && _tm.text == "" && _l.text == "" && _tl.text == ""
        && _xl.text == "" && _txl.text == "" && _xxl.text == "" && _txxl.text == ""
        && _3xl.text == "" && _t3xl.text == "" && _4xl.text == "" && _t4xl.text == ""
        && _5xl.text == "" && _t5xl.text == ""){

      buildErrorDialog(this.context,"","No Product Bolcked!");
    }
    else{
      final Map<String, String> data = {};
      data['action'] = 'add_to_cart';
      data['t_ap_id'] = displayallcolor?.tripurStock?[0].tApId != null ? (displayallcolor?.tripurStock?[0].tApId).toString() : "0";
      data['t_apd_id'] =displayallcolor?.tripurStock?[0].tApdId !=null ? (displayallcolor?.tripurStock?[0].tApdId).toString() : "0";
      data['m_ap_id'] =displayallcolor?.mumbaiStock?[0].mApId != null ?(displayallcolor?.mumbaiStock?[0].mApId).toString(): "0";
      data['m_apd_id'] = displayallcolor?.mumbaiStock?[0].mApdId != null ? (displayallcolor?.mumbaiStock?[0].mApdId).toString() : "0";
      data['d_id'] = (userData?.logindata?.dId).toString();
      data['gender_type'] =gen == 0 ? "MEN" : "WOMEN";
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
      print(data);
      checkInternet().then((internet) async {
        if (internet) {
          Productprovider()
              .product2addtocartprovider(data)
              .then((Response response) async {
            add = addtoCartClass.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && add?.status == "success") {
              isloading = false;
              Navigator.of(this.context).push(MaterialPageRoute(builder: (context)=>summary(pronamenevigatior: widget.pronamenevigatior,
                  coloridnevigator:  product2color
                      ?.data?[
                  selectbtn]
                      .colorName ,gender: gen == 0 ? "MEN" : "WOMEN")));
              // _s.text = "";
              // _ts.text = "";
              // _totalms.text = "";
              //
              // _xs.text = "";
              // _txs.text = "";
              // _totalxs.text = "";
              //
              // _m.text = "";
              // _tm.text = "";
              // _totalmm.text = "";
              //
              // _l.text = "";
              // _tl.text = "";
              // _total_ll.text = "";
              //
              // _xl.text = "";
              // _txl.text = "";
              // _total_xl.text = "";
              //
              // _xxl.text = "";
              // _txxl.text = "";
              // _total_xxl.text = "";
              //
              // _3xl.text = "";
              // _t3xl.text = "";
              // _total_3xl.text = "";
              //
              // _4xl.text = "";
              // _t4xl.text = "";
              // _total_4xl.text = "";
              //
              // _5xl.text = "";
              // _t5xl.text = "";
              // _total_5xl.text = "";
              if (kDebugMode) {}
            } else {
              buildErrorDialog1(this.context, "",  'Already product added to cart',1);
              isloading = false;

            }
          });
        } else {

          isloading = false;

        }
      });
    }

  }

}
