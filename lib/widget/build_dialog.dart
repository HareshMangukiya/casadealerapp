import 'dart:convert';
import 'dart:io';
import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/screens/summary.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';


buildErrorDialog(BuildContext context,String title, String contant,
    {VoidCallback? callback, String? buttonname}) {
  Widget okButton = GestureDetector(
    child: Container(
      height: 40.0,
      width: 30.w,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xff333389),
      ),
      child: Center(
        child: Text(buttonname ?? 'OK',
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
      // if (callback == null) {
      Navigator.pop(context);
      // } else {

      // }
    },
  );

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
            height: (title == "")?20.h :22.h,
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
                okButton,
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
            height: (title == "")?15.5.h :19.h,
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
                okButton,
                SizedBox(height: 2.h,),
              ],
            ),
          ),
        );
      },
    );
    // CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
    //   title: Text(title,
    //       style: TextStyle(
    //           color: Colors.black,
    //           decorationColor: Colors.black,
    //           fontFamily: 'poppins')),
    //   content: Text(contant,
    //       style: const TextStyle(
    //           color: Colors.black,
    //           decorationColor: Colors.black,
    //           fontFamily: 'poppins')),
    //   actions: [
    //     okButton,
    //   ],
    // );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return cupertinoAlertDialog;
    //   },
    // );
  }
  // show the dialog
}

buildErrorDialog1(BuildContext context,String title, String contant,int cart,
    {VoidCallback? callback, String? buttonname}) {
  Widget okButton = GestureDetector(
    child: Container(
      height: 40.0,
      width: 30.w,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xff333389),
      ),
      child: Center(
        child: Text(buttonname ?? 'OK',
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

      // if (callback == null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>summary(cart:cart)));
      // } else {

      // }
    },
  );

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
            height: (title == "")?18.5.h :22.h,
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
                okButton,
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
            height: (title == "")?15.5.h :19.h,
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
                okButton,
                SizedBox(height: 2.h,),
              ],
            ),
          ),
        );
      },
    );
    // CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
    //   title: Text(title,
    //       style: TextStyle(
    //           color: Colors.black,
    //           decorationColor: Colors.black,
    //           fontFamily: 'poppins')),
    //   content: Text(contant,
    //       style: const TextStyle(
    //           color: Colors.black,
    //           decorationColor: Colors.black,
    //           fontFamily: 'poppins')),
    //   actions: [
    //     okButton,
    //   ],
    // );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return cupertinoAlertDialog;
    //   },
    // );
  }
  // show the dialog
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
            height: (title == "")?20.h :22.h,
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
            height: (title == "")?15.5.h :19.h,
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
navDialog(BuildContext context,String title, String contant) {


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
            height: (title == "")?20.h :22.h,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
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

                      navDialog1(context, "", (edit?.msg).toString());
                      // Navigator.pop(context);

                    },
                  ),
                  SizedBox(width: 2.w,),
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
            height: (title == "")?15.5.h :19.h,
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

// navDialog1(BuildContext context,String title, String contant) {
//
//
//   if (Platform.isAndroid) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           backgroundColor: Colors.transparent,
//           child: Container(
//             width: 73.w,
//             height: (title == "")?20.h :22.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//
//                     Row(
//                       children: [
//                         // Icon(Icons.edit,color:Colors.white ,),
//                         Text(
//                           "",
//                           style: TextStyle(
//                               decoration: TextDecoration.underline,
//                               fontSize: 16.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "Poppins"),
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> order_id() ));
//
//                         },
//                         icon: Icon(
//                           Icons.close,
//                           color: Colors.black,
//                         ))
//                   ],
//                 ),
//                 (title != "")?Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal:3.w),
//                       child: Text(
//                         title,
//                         textAlign: TextAlign.center,
//                         style:  TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             decorationColor: Colors.black,
//                             fontFamily: 'poppins'),
//                       ),
//                     ),
//                     SizedBox(height: 1.h),
//                   ],
//                 ):Container(),
//
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal:3.w),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 1.h),
//                       Text(
//                         contant,
//                         textAlign: TextAlign.center,
//                         style:  TextStyle(
//                             fontSize: 12.sp,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             decorationColor: Colors.black,
//                             fontFamily: 'poppins'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children:[
//                   GestureDetector(
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: 40.0,
//                       width: 30.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(20.0),
//                         color: Color(0xff333389),
//                       ),
//                       child: Text("ok",
//                           textAlign: TextAlign.center,
//                           style:  TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               decorationColor: Colors.black,
//                               fontFamily: 'poppins')),
//                     ),
//                     onTap: () {
//
//                       // Navigator.pop(context);
//
//                       Navigator.of(context).push(MaterialPageRoute(builder:(context)=> your_order() ));
//
//
//
//                     },
//                   ),
//                   // GestureDetector(
//                   //   child: Container(
//                   //     height: 40.0,
//                   //     width: 30.w,
//                   //     decoration: BoxDecoration(
//                   //       shape: BoxShape.rectangle,
//                   //       borderRadius: BorderRadius.circular(20.0),
//                   //       color: Color(0xff333389),
//                   //     ),
//                   //     child: Center(
//                   //       child: Text("No",
//                   //           textAlign: TextAlign.center,
//                   //           style:  TextStyle(
//                   //               fontSize: 14.sp,
//                   //               fontWeight: FontWeight.bold,
//                   //               color: Colors.white,
//                   //               decorationColor: Colors.black,
//                   //               fontFamily: 'poppins')),
//                   //     ),
//                   //   ),
//                   //   onTap: () {
//                   //
//                   //     Navigator.pop(context);
//                   //
//                   //   },
//                   // ),
//                 ]),
//                 SizedBox(height: 2.h,),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   if (Platform.isIOS) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           backgroundColor: Colors.transparent,
//           child: Container(
//             width: 70.w,
//             height: (title == "")?15.5.h :19.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 3.h,),
//                 (title != "")?Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal:3.w),
//                       child: Text(
//                         title,
//                         textAlign: TextAlign.center,
//                         style:  TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             decorationColor: Colors.black,
//                             fontFamily: 'poppins'),
//                       ),
//                     ),
//                     SizedBox(height: 1.h),
//                   ],
//                 ):Container(),
//
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal:3.w),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 1.h),
//                       Text(
//                         contant,
//                         textAlign: TextAlign.center,
//                         style:  TextStyle(
//                             fontSize: 12.sp,
//                             color: Colors.black,
//                             fontWeight: FontWeight.normal,
//                             decorationColor: Colors.black,
//                             fontFamily: 'poppins'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Divider(
//                   height: 1.0,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(height: 2.h),
//                 Row(children:[
//                   GestureDetector(
//                     child: Container(
//                       height: 40.0,
//                       width: 30.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(20.0),
//                         color: Color(0xff333389),
//                       ),
//                       child: Center(
//                         child: Text("Yes",
//                             textAlign: TextAlign.center,
//                             style:  TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 decorationColor: Colors.black,
//                                 fontFamily: 'poppins')),
//                       ),
//                     ),
//                     onTap: () {
//
//                       // Navigator.pop(context);
//
//
//                     },
//                   ),
//                   GestureDetector(
//                     child: Container(
//                       height: 40.0,
//                       width: 30.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(20.0),
//                         color: Color(0xff333389),
//                       ),
//                       child: Center(
//                         child: Text("No",
//                             textAlign: TextAlign.center,
//                             style:  TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 decorationColor: Colors.black,
//                                 fontFamily: 'poppins')),
//                       ),
//                     ),
//                     onTap: () {
//
//                       Navigator.pop(context);
//
//                     },
//                   ),
//                 ]
//                 ),
//                 SizedBox(height: 2.h,),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   // show the dialog
// }

// cancelrequest(){
//   final Map<String, String> data = {};
//   data['action'] = 'cancle_order_request';
//   data['order_no'] = widget.id.toString();
//   data['d_id'] =(userData?.logindata?.dId).toString();
//   checkInternet().then((internet) async {
//     if (internet) {
//       Productprovider()
//           .canclerequestapi(data)
//           .then((Response response) async {
//         convertblockorder edit = convertblockorder.fromJson(json.decode(response.body));
//         if (response.statusCode == 200 && edit?.status == "success") {
//           // setState(() {
//           // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> your_order() ));
//
//         } else {
//           // isloading = false;
//         }
//       });
//     } else {
//       // isloading = false;
//     }
//   });
// }



