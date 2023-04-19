import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casadealerapp/modal_class/cartcount.dart';

import 'package:casadealerapp/modal_class/new_password_class.dart';
import 'package:casadealerapp/modal_class/profileU.dart';
import 'package:casadealerapp/modal_class/search_class.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/product_2.dart';

import 'package:casadealerapp/screens/profile_view.dart';
import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class updateProfile extends StatefulWidget {
  String? prfileFullName;
  String? prfilePhone1;
  String? prfilePhone2;
  String? prfileCompanyname;
  String? prfileEmailaddress;
  String? prfileCompanyaddress;
   updateProfile({Key? key,  this.prfileFullName,this.prfilePhone1,this.prfilePhone2,this.prfileEmailaddress,this.prfileCompanyname,this.prfileCompanyaddress}) : super(key: key);

  @override
  State<updateProfile> createState() => _updateProfileState();
}

class _updateProfileState extends State<updateProfile> {

  TextEditingController _search = TextEditingController();
  bool se_icon = false;
  bool check = false;
  search? searchproperty;


  changePassword? changepass;
  updateProfile2? upadateP;

  List<String> tabs = ["Profile", "Change Password"];
  int sumindex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _companyname = TextEditingController();
  TextEditingController _companyname1 = TextEditingController();

  TextEditingController _phone = TextEditingController();
  TextEditingController _phone1 = TextEditingController();

  // TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password1 = TextEditingController();
  TextEditingController _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible1 = false;
  bool _passwordVisible = false;
  cartcount? count;
  String? gender = "male";
  bool? check3 = false;
  var select = "i1";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateProapi();
    viewcount();

    _firstname.text = widget.prfileFullName.toString();
    _companyname.text = widget.prfileCompanyname.toString();
    _companyname1.text = widget.prfileCompanyaddress.toString();
    _phone.text = widget.prfilePhone1.toString();
    _phone1.text = widget.prfilePhone2.toString();
    // _password.text = widget.prfile.toString();
    // _password1.text = widget.prfileFullName.toString();
    _email.text = widget.prfileEmailaddress.toString();

  }

  Widget build(BuildContext context) {
    return   Scaffold(

          backgroundColor: Color(0xfffFFFFFF),
          drawer: drawer(context),
          key: _scaffoldKey,
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: Color(0xfffFFFFFF),
              ),
              SingleChildScrollView(
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
                                    Column(
                                      children: [
                                        SizedBox(height:11),
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
                                                "Update Profile",
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
                      ],
                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                                          sumindex = index;
                                        });
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
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          (sumindex == 0)
                              ? Column(
                            children: [
                              //     SizedBox(
                              //   height: 2.h,
                              // ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  // upadateP?.updated?.fullName ?? '',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your full name";
                                    }
                                    return null;
                                  },
                                  controller: _firstname,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(2.h),
                                    hintText: 'Full Name',
                                    // suffixIcon: Icon(
                                    //   Icons.person_outline,
                                    //   color: Color(0xfff9696c1),
                                    //   size: 3.5.h,
                                    // ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your company name";
                                    }
                                    return null;
                                  },
                                  controller: _companyname,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(2.h),
                                    hintText: 'Company Name',
                                    // suffixIcon: Icon(
                                    //   Icons.shopping_bag_outlined,
                                    //   color: Color(0xfff9696c1),
                                    //   size: 3.5.h,
                                    // ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your company address";
                                    }
                                    return null;
                                  },
                                  controller: _companyname1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(2.h),
                                    hintText: 'Company Address',
                                    // suffixIcon: Icon(
                                    //   Icons.location_on_outlined,
                                    //   color: Color(0xfff9696c1),
                                    //   size: 3.5.h,
                                    // ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  validator: (value) {
                                    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                        "\\@" +
                                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                        "(" +
                                        "\\." +
                                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                        ")+";
                                    //Convert string p to a RegE  x
                                    RegExp regExp = RegExp(p);

                                    if (value!.isEmpty) {
                                      return 'Please enter Your Email';
                                    } else {
                                      //If email address matches pattern
                                      if (regExp.hasMatch(value)) {
                                        return null;
                                      } else {
                                        //If it doesn't match
                                        return 'Email is not valid';
                                      }
                                    }
                                  },
                                  controller: _email,
                                  decoration: InputDecoration(
                                    // suffixIcon: Icon(
                                    //   Icons.person_outline,
                                    //   color: Color(0xfff9696c1),
                                    //   size: 3.5.h,
                                    // ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(2.h),
                                    hintText: 'Email Address',
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value?.length != 10)
                                      return 'Mobile Number must be of 10 digit';
                                    else
                                      return null;
                                  },
                                  controller: _phone,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(2.h),
                                    hintText: 'Phone No. 1',
                                    // suffixIcon: Icon(
                                    //   Icons.phone_outlined,
                                    //   color: Color(0xfff9696c1),
                                    //   size: 3.5.h,
                                    // ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  // validator: (value) {
                                  //   if (value?.length != 10)
                                  //     return 'Mobile Number must be of 10 digit';
                                  //   else
                                  //     return null;
                                  // },
                                  controller: _phone1,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(2.h),
                                    hintText: 'Phone 2 (optional)',
                                    // suffixIcon: Icon(
                                    //   Icons.phone_outlined,
                                    //   color: Color(0xfff9696c1),
                                    //   size: 3.5.h,
                                    // ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.06,
                                // color: Color(0xfff333389),
                                // padding:
                                //     EdgeInsets.only(left: 35, right: 40, bottom: 10, top: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {

                                      updateProapi();



                                      // Navigator.push(
                                      // context,
                                      // MaterialPageRoute(
                                      // builder: (context) => profileView()));
                                    }
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(fontSize: 2.h),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xfff333389),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h,)
                            ],
                          )
                              : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  obscureText: !_passwordVisible,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                  controller: _password,
                                  decoration: InputDecoration(

                                    //  prefixIcon: Icon(Icons.login),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          color: Color(0xfff9696c1),
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(2.h),
                                      hintText: 'Create new Password'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfffFBFBFB),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  obscureText: !_passwordVisible1,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Re-Enter your password";
                                    }else if (value != _password.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },

                                  controller: _password1,
                                  decoration: InputDecoration(
                                    //  prefixIcon: Icon(Icons.login),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible1 = !_passwordVisible1;
                                          });
                                        },
                                        icon: Icon(
                                          color: Color(0xfff9696c1),
                                          _passwordVisible1
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(2.h),
                                      hintText: 'Re-Enter Password'),
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.06,
                                // color: Color(0xfff333389),
                                // padding:
                                //     EdgeInsets.only(left: 35, right: 40, bottom: 10, top: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // if (_formKey.currentState!.validate()) {
                                    print("Validate");
                                    changepass1Proapi();

                                    // Navigator.push(
                                    // context,
                                    // MaterialPageRoute(
                                    // builder: (context) => profileView()));
                                    // }
                                  },
                                  child: Text(
                                    'Change Password',
                                    style: TextStyle(fontSize: 2.h),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xfff333389),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
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

    );
  }

  updateProapi() async {
    final Map<String, String> data = {};
    data['action'] = "update_distributor_data";
    data['d_id'] = (userData?.logindata?.dId).toString();
    data['full_name'] = _firstname.text.trim().toString();
    data['company_name'] = _companyname.text.trim().toString();
    data['phone_one'] = _phone.text.trim().toString();
    data['phone_two'] = _phone1.text.trim().toString();
    data['email_id'] = _email.text.trim().toString();
    data['address'] = _companyname1.text.trim().toString();



    print(data);


    if (_formKey.currentState!.validate()) {
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider().UpdateprofileProvider(data).then((Response response) async {
          print(response.body);

          upadateP = updateProfile2.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && upadateP?.status == "success") {
            // print(upadateP?.status);

            setState(() {

              // viewProapi();
            });
            // SaveDataLocal.saveLogInData(userData!);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => profileView()));
            // Fluttertoast.showToast(
            //   msg: "Logged In Successfully",
            //   textColor: Colors.white,
            //   toastLength: Toast.LENGTH_SHORT,
            //   timeInSecForIosWeb: 1,
            //   gravity: ToastGravity.BOTTOM,
            //   backgroundColor: Colors.indigo,
            // );

            if (kDebugMode) {}


          } else {

            setState(() {


            });

            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return Dialog(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(16),
            //       ),
            //       backgroundColor: Colors.transparent,
            //       child: Container(
            //         height: 25.h,
            //         width: 80.w,
            //         // padding: EdgeInsets.all(5.w),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         child: Stack(
            //           children: [
            //
            //             Container(
            //               height: 25.h,
            //               width: 80.w,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(16),
            //               ),
            //               // borderRadius: BorderRadius.circular(16),
            //               padding: EdgeInsets.all(3.w),
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //
            //                       Row(
            //                         children: [
            //                           // Icon(Icons.edit,color:Colors.white ,),
            //                           Text(
            //                             "",
            //                             style: TextStyle(
            //                                 decoration: TextDecoration.underline,
            //                                 fontSize: 16.sp,
            //                                 color: Colors.white,
            //                                 fontWeight: FontWeight.bold,
            //                                 fontFamily: "Poppins"),
            //                           ),
            //                         ],
            //                       ),
            //                       IconButton(
            //                           onPressed: () {
            //                             Navigator.of(context).pop();
            //                           },
            //                           icon: Icon(
            //                             Icons.close,
            //                             color: Colors.black,
            //                           ))
            //                     ],
            //                   ),
            //                   Form(
            //
            //                     child: Column(
            //                       children: [
            //                         SizedBox(
            //                           height: 2.h,
            //                         ),
            //                         Text(
            //                           "User already exist",
            //                           style: TextStyle(
            //
            //                               fontSize: 12.sp,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.bold,
            //                               fontFamily: "Poppins"),
            //                         ),
            //
            //
            //                         // TextFormField(
            //                         //   controller: _title,
            //                         //   keyboardType: TextInputType.text,
            //                         //   validator: (value) {
            //                         //     if (value!.isEmpty) {
            //                         //       return 'Please enter your subject';
            //                         //     }
            //                         //     return null;
            //                         //   },
            //                         //   decoration: InputDecoration(
            //                         //     contentPadding: EdgeInsets.all(2.0),
            //                         //     prefixIcon: Icon(Icons.add,color: Colors.grey,),
            //                         //     filled: true,
            //                         //     hintText: "Subject",
            //                         //     hintStyle: textstyle,
            //                         //     fillColor: Colors.white,
            //                         //     enabledBorder: OutlineInputBorder(
            //                         //         borderSide: BorderSide.none,
            //                         //         borderRadius: BorderRadius.circular(30.0)),
            //                         //     focusedBorder: OutlineInputBorder(
            //                         //         borderSide: BorderSide.none,
            //                         //         borderRadius: BorderRadius.circular(30.0)),
            //                         //   ),
            //                         // ),
            //
            //                         Padding(
            //                           padding: EdgeInsets.all(3.w),
            //                           child: Container(
            //                             width: 40.w,
            //                             decoration: BoxDecoration(
            //                               color: Color(0xff333389),
            //                               borderRadius: BorderRadius.circular(30.0),
            //                               // boxShadow: [
            //                               //   BoxShadow(
            //                               //     color: Color(0xff333389),
            //                               //     offset: Offset(0, 10),
            //                               //     blurRadius: 10,
            //                               //     spreadRadius: -5,
            //                               //   ),
            //                               // ],
            //                               // border: Border.all(color: Colors.white,width: 1.0)
            //                             ),
            //                             height: 40.0,
            //                             child: TextButton(
            //                               style: ButtonStyle(
            //                                 alignment: Alignment.center,
            //                                 // backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            //                                 padding: MaterialStateProperty.all(
            //                                   EdgeInsets.symmetric(vertical: 1.h),
            //                                 ),
            //                                 shape:
            //                                 MaterialStateProperty.all<RoundedRectangleBorder>(
            //                                     RoundedRectangleBorder(
            //                                       borderRadius: BorderRadius.circular(20.sp),
            //                                     )),
            //                               ),
            //                               onPressed: () {
            //                                 Navigator.of(context).pop();
            //
            //                               },
            //                               child: Row(
            //                                 mainAxisAlignment: MainAxisAlignment.center,
            //                                 children: [
            //                                   Text(
            //                                     "Oky",
            //                                     style: TextStyle(
            //                                         color: Colors.white,
            //                                         fontSize: 14.sp,
            //                                         fontFamily: "Poppins",
            //                                         fontWeight: FontWeight.bold),
            //                                   ),
            //                                   SizedBox(
            //                                     width: 5.0,
            //                                   ),
            //                                   // Icon(
            //                                   //   Icon,
            //                                   //   color: Colors.grey.shade700,
            //                                   // )
            //
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );
          }
        });
      } else {}
    });

  }
}

  changepass1Proapi() async {
    final Map<String, String> data = {};
    data['action'] = "change_password_page";
    data['myNew_password'] = _password.text.trim().toString();
    data['d_id'] =  (userData?.logindata?.dId).toString();
    if (_formKey.currentState!.validate()) {
      checkInternet().then((internet) async {
        if (internet) {
          Productprovider().updatePasswordProvider(data).then((Response response) async {
            print(response.body);

            changepass = changePassword.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && changepass?.status == "success") {
              // print(upadateP?.status);

              setState(() {

                // viewProapi();
              });

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.transparent,
                    child: Container(
                      height: 25.h,
                      width: 80.w,
                      // padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [

                          Container(
                            height: 25.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            // borderRadius: BorderRadius.circular(16),
                            padding: EdgeInsets.all(3.w),
                            child: Column(
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
                                Form(

                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        "Password changed successfully",
                                        style: TextStyle(

                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),


                                      // TextFormField(
                                      //   controller: _title,
                                      //   keyboardType: TextInputType.text,
                                      //   validator: (value) {
                                      //     if (value!.isEmpty) {
                                      //       return 'Please enter your subject';
                                      //     }
                                      //     return null;
                                      //   },
                                      //   decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.all(2.0),
                                      //     prefixIcon: Icon(Icons.add,color: Colors.grey,),
                                      //     filled: true,
                                      //     hintText: "Subject",
                                      //     hintStyle: textstyle,
                                      //     fillColor: Colors.white,
                                      //     enabledBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide.none,
                                      //         borderRadius: BorderRadius.circular(30.0)),
                                      //     focusedBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide.none,
                                      //         borderRadius: BorderRadius.circular(30.0)),
                                      //   ),
                                      // ),

                                      Padding(
                                        padding: EdgeInsets.all(3.w),
                                        child: Container(
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            color: Color(0xff333389),
                                            borderRadius: BorderRadius.circular(30.0),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Color(0xff333389),
                                            //     offset: Offset(0, 10),
                                            //     blurRadius: 10,
                                            //     spreadRadius: -5,
                                            //   ),
                                            // ],
                                            // border: Border.all(color: Colors.white,width: 1.0)
                                          ),
                                          height: 40.0,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              alignment: Alignment.center,
                                              // backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                              padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(vertical: 1.h),
                                              ),
                                              shape:
                                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.sp),
                                                  )),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();

                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Oky",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.bold),
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
              );




              // SaveDataLocal.saveLogInData(userData!);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => profileView()));
              // Fluttertoast.showToast(
              //   msg: "Logged In Successfully",
              //   textColor: Colors.white,
              //   toastLength: Toast.LENGTH_SHORT,
              //   timeInSecForIosWeb: 1,
              //   gravity: ToastGravity.BOTTOM,
              //   backgroundColor: Colors.indigo,
              // );

              if (kDebugMode) {}


            } else {

              setState(() {


              });


            }
          });
        } else {}
      });

    }
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
