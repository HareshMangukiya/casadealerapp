import 'dart:convert';

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:casadealerapp/main.dart';
import 'package:casadealerapp/modal_class/ViewCart.dart';
import 'package:casadealerapp/modal_class/add_to_cart_modal.dart';
import 'package:casadealerapp/modal_class/block_product_modal.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';
import 'package:casadealerapp/modal_class/category_wise_display.dart';
import 'package:casadealerapp/modal_class/color_display_all_class.dart';
import 'package:casadealerapp/modal_class/color_modal.dart';
import 'package:casadealerapp/modal_class/product2_image_modal.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
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
import 'package:badges/badges.dart' as badges;


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
  search? searchproperty;
  cartcount? count;
  bool check = false;

  //Api Total

  final PageController controller = PageController(initialPage: 0);
  List<products> images = [
    products("https://distributor-app.fableadtechnolabs.com/admin/src/img/Category/Screenshot_16.png", "Brand Name", "Street Wear",
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
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    await viewcount();
    await displaycolor();
    // await imageapi();
    await colorapi();
    await selectimageapi();
  }

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      isLoading: isLoading,
      scaffold: Scaffold(
        backgroundColor: Color(0xfffFFFFFF),
        drawer: drawer(context),
        key: _scaffoldKey,
        body: isLoading
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
                    displayallcolor?.status == "fail"
                        ? Text('No Data Found',
                            style: TextStyle(
                                fontSize: 2.h, fontWeight: FontWeight.bold))
                        : Expanded(
                            child: Stack(
                              children: [
                                SingleChildScrollView(
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
                                              child:
                                              

                                              (displayallcolor
                                                              ?.mumbaiStock?[0]
                                                              .menImageArray
                                                              ?.length !=
                                                          0)
                                                      ? GestureDetector(
                                                onTap:(){

                                                },

                                                        child: CarouselSlider(
                                                            items: (displayallcolor
                                                                ?.mumbaiStock?[
                                                            0]
                                                                .menImageArray ??
                                                                []).map((e) {
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
                                                                          child:  CachedNetworkImage(
                                                                            imageUrl:e,

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
                                                                                  "assets/product_1_img2.png",

                                                                                  fit:
                                                                                  BoxFit.cover,
                                                                                ),
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
                                                          ),
                                                      )

                                                  :
                                              (displayallcolor
                                                                  ?.tripurStock?[0]
                                                                  .menImageArray
                                                                  ?.length !=
                                                              0)
                                                          ? GestureDetector(
                                                // onTap:(){
                                                //   print("1234");
                                                //   print(displayallcolor
                                                //       ?.mumbaiStock?[
                                                //   0]
                                                //       .menImageArray);
                                                // },
                                                            child: CarouselSlider(
                                                                items:
                                                                (displayallcolor
                                                                    ?.tripurStock?[
                                                                0]
                                                                    .menImageArray ??
                                                                    []).map((e) {
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
                                                                              child:  CachedNetworkImage(
                                                                                imageUrl:e,

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
                                                                                      "assets/product_1_img2.png",

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
                                                              ),
                                                          )
                                                          : GestureDetector(
                                                // onTap:(){
                                                //   print("1234");
                                                //   print(displayallcolor
                                                //       ?.mumbaiStock?[
                                                //   0]
                                                //       .menImageArray);
                                                // },
                                                            child: CarouselSlider(
                                                                items: images
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
                                                                                    e.image.toString(),
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
                                                                                  "assets/product_1_img2.png",

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
                                                              ),
                                                          )


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
                                              count:( displayallcolor
                                                  ?.mumbaiStock?[0].menImageArray?.length   != 0) ? (displayallcolor
                                                  ?.mumbaiStock?[0].menImageArray?.length ?? 0) : (displayallcolor
                                                  ?.tripurStock?[0].menImageArray?.length ?? 0),
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
                                      height: 1.h,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: Container(
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
                                                      crossAxisAlignment:CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: 4.5.h,
                                                          width: 9.w,
                                                          child: CircleAvatar(
                                                            child: ClipOval(
                                                              child: Image.network(
                                                                product2color
                                                                        ?.data?[
                                                                            selectbtn]
                                                                        .colorImage ??
                                                                    '',
                                                                width: 13.w,
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
                                                                fontSize: 2.4.h,
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
                                                height: 20.h,
                                                width: 90.w,
                                                // child: GridView.builder(
                                                //   itemCount:
                                                //       product2color?.data?.length,
                                                //   gridDelegate:
                                                //       SliverGridDelegateWithFixedCrossAxisCount(
                                                //           crossAxisCount: 7,
                                                //           crossAxisSpacing: 12.0,
                                                //           childAspectRatio: 3 / 3,
                                                //           mainAxisSpacing: 6.0),
                                                //   itemBuilder:
                                                //       (BuildContext context,
                                                //           int index) {
                                                //     return GestureDetector(
                                                //         onTap: () {
                                                //           setState(() {
                                                //             btn = index;
                                                //             selectbtn = index;
                                                //           });
                                                //           selectimageapi();
                                                //           displaycolor();
                                                //         },
                                                //         child: Stack(
                                                //           children: [
                                                //             Container(
                                                //               // height: 10.h,
                                                //               // width: 20.w,
                                                //               child: CircleAvatar(
                                                //                 // radius: 7.w,
                                                //                 child: ClipOval(
                                                //                   child:
                                                //                       Image.network(
                                                //                     product2color
                                                //                             ?.data?[
                                                //                                 index]
                                                //                             .colorImage ??
                                                //                         "",
                                                //
                                                //                     // 'assets/Red_Color.jpg',
                                                //                     width: 10.w,
                                                //                     height: 13.w,
                                                //                     fit: BoxFit
                                                //                         .cover,
                                                //                   ),
                                                //
                                                //                 ),
                                                //               ),
                                                //               decoration:
                                                //                   BoxDecoration(
                                                //                       shape: BoxShape
                                                //                           .circle,
                                                //                       // color: tripur[index],
                                                //                       border: Border.all(
                                                //                           color: Color(
                                                //                               0xffbababa))),
                                                //             ),
                                                //             (btn == index)
                                                //                 ? Container(
                                                //                     height: 10.h,
                                                //                     width: 20.w,
                                                //                     decoration: BoxDecoration(
                                                //                         shape: BoxShape
                                                //                             .circle,
                                                //                         color: Colors
                                                //                             .transparent),
                                                //                     child: Icon(
                                                //                       Icons.check,
                                                //                       color: Colors
                                                //                           .white,
                                                //                       size: 15.sp,
                                                //                     ),
                                                //                   )
                                                //                 : Container()
                                                //           ],
                                                //         ));
                                                //   },
                                                // )
                                                child: CarouselSlider(

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
                                                  items: [
                                                    GridView.builder(
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
                                                                  // height: 10.h,
                                                                  // width: 20.w,
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
                                                    )
                                                  ],
                                                )
                                                ),
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
                                                          child: 
                                                               Text(
                                                        displayallcolor
                                                            ?.priceArray?[
                                                        0]
                                                            .minPrice ==
                                                        0 ||
                                                        displayallcolor
                                                            ?.priceArray?[
                                                        0]
                                                            .minPrice ==
                                                        null ?"N/A":'₹' +
                                                          (displayallcolor
                                                              ?.priceArray?[
                                                              0]
                                                              .minPrice)
                                                              .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          2.6.h,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xfff333389)),
                                                                )
                                                             
                                                        ),
                                                        Container(
                                                          width: 30.w,
                                                          child: 
                                                          Text(
                                                        displayallcolor
                                                            ?.priceArray?[
                                                        0]
                                                            .maxPrice ==
                                                        0 ||
                                                        displayallcolor
                                                            ?.priceArray?[
                                                        0]
                                                          .maxPrice ==
                                                          null ?
                                                                  "N/A" :'₹' +
                                                        (displayallcolor
                                                            ?.priceArray?[
                                                            0]
                                                            .maxPrice)
                                                            .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          2.6.h,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xfff333389)),
                                                                )
                                                             
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
                                                  Container(
                                                width:10.w,
                                                    alignment:Alignment.center,
                                                 
                                                    
                                                    child: Text(
                                                      "Size",
                                                      style: TextStyle(fontSize: 2.h),
                                                    ),
                                                  ),
                                              
                                                  Container(
                                                      width:20.w,
                                                    alignment:Alignment.center,
                                                   
                                                    child: Text("Mumbai",
                                                        style:
                                                            TextStyle(fontSize: 2.h)),
                                                  ),
                                        
                                                  Container(
                                                      width:18.w,
                                                 
                                                    alignment:Alignment.center,
                                                    child: Text("Tirupur",
                                                        style:
                                                            TextStyle(fontSize: 2.h)),
                                                  ),
                                               
                                                  Container(
                                                      width:18.w,
                                                 
                                                    alignment:Alignment.center,
                                                    child: Text("Total",
                                                        style:
                                                            TextStyle(fontSize: 2.h)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                       

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
                                                        style:textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                          child:TextField(
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
                                                            onChanged: (value) {

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _xs,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:inputDecoration())
                                                            ),
                                                    ]
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
                                                            : "0",                                                        // '432',
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
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

                                                               // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                               //      buildErrorDialog(context, "", "Please enter the stock  less  than " + (displayallcolor?.tripurStock?[0].xs).toString() +" ." );
                                                               // }
                                                               // else{
                                                               // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _txs,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:inputDecoration()
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
                                                      
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                        
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
                                                            decoration:inputDecoration())),
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                          
                                                          child: TextField(
                                                            onChanged: (value) {

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
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
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                        
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },

                                                            controller: _ts,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                     
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
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
                                                              decoration:inputDecoration(
                                                          ))),
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
                                                        style:textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                       
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _m,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                    
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
                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _tm,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                    
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
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                       
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _l,

                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                        
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _tl,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                   
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
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                         
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _xl,

                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                       
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _txl,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
                                                          )),
                                                    ],
                                                  ),
                                                 
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        totalxl.toString(),
                                                        // "432",
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                       
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
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                
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
                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _xxl,

                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                            .xxl)
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                       
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
                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                           
                                                              updateTotal(value);
                                                            },
                                                            controller: _txxl,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                           decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                         
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
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                                                                               

                                                          child: TextField(                                                                           readOnly: regex.hasMatch(
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))) {
                                                              //   buildErrorDialog(
                                                              //       context, "",
                                                              //       "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _3xl,

                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                         
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _t3xl,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                       
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
                                                              decoration:inputDecoration()
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
                                                        style:textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                         
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              // buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _4xl,

                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                        
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _t4xl,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
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
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                       
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.mumbaiStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _5xl,

                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style: textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                         
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

                                                              // if(int.parse(value) > (int.parse((displayallcolor?.tripurStock?[0].xs).toString()))){
                                                              //   buildErrorDialog(context, "", "please enter the lower value than available stock.");
                                                              // }
                                                              updateTotal(value);
                                                            },
                                                            controller: _t5xl,
                                                            textAlign:
                                                                TextAlign.center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                              decoration:inputDecoration()
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
                                                        style:textstyle3,
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 10.h,
                                                          height: 4.h,
                                                      
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
                                                              decoration:inputDecoration())),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(2.h),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey.shade200),
                                                  borderRadius:
                                                      BorderRadius.circular(12)
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
                                                          // Container(
                                                          //   alignment:
                                                          //       Alignment.center,
                                                          //   child: Image.asset(
                                                          //     'assets/product_2_img2.png',
                                                          //     fit: BoxFit.cover,
                                                          //     height: 33.5.h,
                                                          //     width: MediaQuery.of(
                                                          //             context)
                                                          //         .size
                                                          //         .width,
                                                          //   ),
                                                          // ),
                                                          // SizedBox(height: 1.h),
                                                            SizedBox(height: 1.h),
                                                          Container(
                                                            height: 61.h,
                                                            alignment:
                                                                Alignment.center,
                                                            child: (displayallcolor
                                                                        ?.mumbaiStock
                                                                        ?.length !=
                                                                    0)
                                                                ? (displayallcolor?.sizeChart?[0].sizeChart==
                                                                        "null")
                                                                    ? Image.asset(
                                                                        "assets/default_product_image.png",
                                                              fit: BoxFit.contain,
                                                              height:
                                                              60.h,
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width,
                                                                      )
                                                                    : Image.network(
                                                                        displayallcolor?.sizeChart?[0].sizeChart ??
                                                                            'N/A',

                                                                        fit: BoxFit.contain,
                                                                        height:
                                                                            60.h,
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width,
                                                                      )
                                                                // : (displayallcolor
                                                                //             ?.tripurStock
                                                                //             ?.length !=
                                                                //         0)
                                                                //     ? (displayallcolor
                                                                //                 ?.tripurStock?[
                                                                //                     0]
                                                                //                 .sizeChart ==
                                                                //             "null")
                                                                //         ? Image
                                                                //             .asset(
                                                                //             "assets/default_product_image.png",
                                                                //             fit: BoxFit
                                                                //                 .cover,
                                                                //             height:
                                                                //                 40.h,
                                                                //             width: MediaQuery.of(context)
                                                                //                 .size
                                                                //                 .width,
                                                                //           )
                                                                //
                                                                //         // 'assets/size_chart.png',
                                                                //
                                                                //         : Image
                                                                //             .network(
                                                                //             displayallcolor?.tripurStock?[0].sizeChart ??
                                                                //                 'N/A',
                                                                //
                                                                //             fit: BoxFit
                                                                //                 .cover,
                                                                //             height:
                                                                //                 40.h,
                                                                //           )
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

                                                                        displayallcolor
                                                                            ?.sizeChart?[0].sizeChart
                                                                            .toString() != "null" ?
                                                                        catlog( displayallcolor?.sizeChart?[0].sizeChart.toString())
                                                                            :buildErrorDialog(context, "", "No Image available");

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
                                                                        ?.sizeChart?[0].videoSpecification.toString() != "null" ?
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                VideoPlayerPage(
                                                                                  videoFilePath: (displayallcolor?.sizeChart?[0].videoSpecification).toString(),
                                                                                ))):buildErrorDialog(context, "", "No video available");
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
                                                                displayallcolor
                                                                    ?.sizeChart?[0].catalogue.toString()!= "null" ?
                                                                    catlog( displayallcolor
                                                                        ?.sizeChart?[0].catalogue.toString()):
                                                               buildErrorDialog(context, "", "No Catalogue available");
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
                                      ),)

                                  ],
                                ),
                              ),
                                  Positioned(
                                    // top: 20.h,
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
                            ]
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
  TextStyle textstyle3 = TextStyle(
      fontSize: 2.h,
      fontWeight:
      FontWeight.bold);
  InputDecoration inputDecoration() {
    return  InputDecoration(
        contentPadding:EdgeInsets.all(2.w),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color:Color( 0xfff333389)
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder:OutlineInputBorder(
          borderSide: BorderSide(
              color:Color( 0xfff333389)
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        )
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

          if (response.statusCode == 200 &&
              product2color?.status == "success") {
            selectimageapi();
            displaycolor();

              isLoading = false;

          } else {

              isLoading = false;

          }
        });
      } else {

          isLoading = false;

      }
    });
  }
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


              isLoading = false;


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
              print(displayallcolor?.tripurStock?[0].menImageArray ?? '');
              isLoading = false;
              // colorapi();
              setState((){

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
            } else {

                isLoading = false;

            }
          });
        } else {

            isLoading = false;

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

      buildErrorDialog(this.context,"No Product Blocked !"," Please add stock for block product");
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
              viewcount();
              buildErrorDialog(this.context, "",  (block?.msg).toString());
              // Navigator.push(
              //     this.context,
              //     MaterialPageRoute(
              //         builder: (context) => summary(
              //             pronamenevigatior:
              //             widget
              //                 .pronamenevigatior
              //                 .toString(),
              //             coloridnevigator:product2color?.data?[btn].colorName,
              //             gender: gen == 0
              //                 ? "MEN"
              //                 : "WOMEN",
              //         cart:cart)));
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
              if (kDebugMode) {}
            } else {

            setState((){
              isLoading = false;
            });
              buildErrorDialog(this.context, "", (block?.msg).toString());

            }
          });
        } else {

          setState((){
            isLoading = false;
          });

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

      buildErrorDialog(this.context,"No Product Added To Cart !"," Please add stock for add to cart");
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
      checkInternet().then((internet) async {
        if (internet) {
          Productprovider()
              .product2addtocartprovider(data)
              .then((Response response) async {
            add = addtoCartClass.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && add?.status == "success") {
              isLoading = false;
              buildErrorDialog(this.context, "",  (add?.msg).toString());
              viewcount();
              // Navigator.of(this.context).push(MaterialPageRoute(builder: (context)=>summary(pronamenevigatior: widget.pronamenevigatior,
              //     coloridnevigator:  product2color
              //         ?.data?[
              //     selectbtn]
              //         .colorName ,gender: gen == 0 ? "MEN" : "WOMEN")));
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
              if (kDebugMode) {}
            } else {
              buildErrorDialog(this.context, "",  (add?.msg).toString() );
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
              isLoading = false;

            });
            if (kDebugMode) { }
          } else {
            setState(() {
              isLoading = false;
            });}
        });
      } else {
        setState(() {
          isLoading = false;
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
