import 'dart:convert';
import 'dart:io';

import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/order_detail.dart';
import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
import 'package:casadealerapp/screens/your_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/build_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class alert_screen2 extends StatefulWidget {
  String? id;
  alert_screen2({Key? key,this.id, required String oreder}) : super(key: key);

  @override
  State<alert_screen2> createState() => _alert_screen2State();
}

class _alert_screen2State extends State<alert_screen2> {
  convertblockorder? convertorder;
  int al = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cancelrequest();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      // body: Column(
      //   children: [
      //     Stack(children: <Widget>[
      //       Container(
      //         height: 100.h,
      //         width: MediaQuery
      //             .of(context)
      //             .size
      //             .width,
      //         color: Color(0xff393939),
      //       ),
      //       Positioned(
      //         top: 65.h,
      //         child: Container(
      //             decoration: BoxDecoration(
      //                 color: Color(0xffffffff),
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(20),
      //                     topRight: Radius.circular(20))),
      //             height: 35.h,
      //             width: MediaQuery
      //                 .of(context)
      //                 .size
      //                 .width,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 SizedBox(
      //                   height: 3.h,
      //                 ),
      //                 Container(
      //                   height: 0.5.h,
      //                   width: 10.w,
      //                   decoration: BoxDecoration(
      //                     color: Color(0xff333389),
      //                     borderRadius: BorderRadius.circular(15),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 4.h,
      //                 ),
      //                 Container(
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15),
      //                   ),
      //                   child: Column(
      //                     children: [
      //                       Text(
      //                         // 'Are you sure?',
      //                         (edit?.msg).toString(),
      //                         style: TextStyle(
      //                             color: Color(0xff333389),
      //                             fontSize: 2.5.h,
      //                             fontWeight: FontWeight.w500),
      //                       ),
      //                       // SizedBox(height: 0.8.h),
      //                       // Text(
      //                       //   'Want to unblock order.',
      //                       //   style: TextStyle(
      //                       //       color: Color(0xff333389),
      //                       //       fontSize: 2.5.h,
      //                       //       fontWeight: FontWeight.w500),
      //                       // ),
      //
      //
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 2.h,
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.all(2.h),
      //                   child: Container(
      //                     child: Row(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                       children: [
      //                         GestureDetector(
      //                           onTap: () {
      //                             setState(() {
      //                               al = 1;
      //                               // Navigator.push(
      //                               //     context,
      //                               //     MaterialPageRoute(
      //                               //         builder: (context) => your_block_order()));
      //                             });
      //                           },
      //                           child: Container(
      //                             padding: EdgeInsets.all(0.1.h),
      //                             alignment: Alignment.center,
      //                             width: 40.w,
      //                             height: 5.5.h,
      //                             decoration: BoxDecoration(
      //                                 color: (al == 0)
      //                                     ? Colors.white
      //                                     : Color(0xfff333389),
      //                                 borderRadius: BorderRadius.circular(8),
      //                                 border:
      //                                 Border.all(color: Color(0xff333389))),
      //                             child: Text(
      //                               'No',
      //                               style: TextStyle(
      //                                   color: (al == 0)
      //                                       ? Color(0xff333389)
      //                                       : Colors.white,
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 2.h),
      //                             ),
      //                           ),
      //                         ),
      //                         // SizedBox(
      //                         //   width: 0.6.h,
      //                         // ),
      //                         GestureDetector(
      //                           onTap: () {
      //                             setState(() {
      //                               al = 0;
      //                             });
      //                             // unblockorder();
      //                             // Navigator.push(
      //                             //     context,
      //                             //     MaterialPageRoute(
      //                             //         builder: (context) => order_id()));
      //                           },
      //                           child: Container(
      //                             padding: EdgeInsets.all(0.1.h),
      //                             alignment: Alignment.center,
      //                             width: 40.w,
      //                             height: 5.5.h,
      //                             decoration: BoxDecoration(
      //                                 color: (al == 1)
      //                                     ? Colors.white
      //                                     : Color(0xfff333389),
      //                                 // color:_selectedColor,
      //
      //                                 borderRadius: BorderRadius.circular(8),
      //                                 border:
      //                                 Border.all(color: Color(0xff333389))),
      //                             child: Text(
      //                               'Yes',
      //                               style: TextStyle(
      //                                   color: (al == 1)
      //                                       ? Color(0xff333389)
      //                                       : Colors.white,
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 2.h),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )),
      //       )
      //     ]),
      //   ],
      // ),
    );
  }

  // unblockorder() {
  //   final Map<String, String> data = {};
  //   data['action'] = 'unblock_blockorder';
  //   data['d_id'] = (userData?.logindata?.dId).toString();
  //   data['order_no'] = widget.id.toString();
  //   checkInternet().then((internet) async {
  //     if (internet) {
  //       Productprovider()
  //           .unblockblockorderapi(data)
  //           .then((Response response) async {
  //         convertorder = convertblockorder.fromJson(json.decode(response.body));
  //         if (response.statusCode == 200 && convertorder?.status == "success") {
  //           setState(() {});
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => your_block_order()));
  //         } else {
  //
  //         }
  //       });
  //     } else {}
  //   });
  // }

  cancelrequest() {
    final Map<String, String> data = {};
    data['action'] = 'cancle_order_request';
    data['order_no'] = widget.id.toString();
    data['d_id'] = (userData?.logindata?.dId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .canclerequestapi(data)
            .then((Response response) async {
          convertblockorder edit = convertblockorder.fromJson(
              json.decode(response.body));
          if (response.statusCode == 200 && edit?.status == "success") {
            setState(() {

            });
            navDialog1(this.context, "", (edit?.msg).toString());

            // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> your_order() ));

          } else {
            // isloading = false;
          }
        });
      } else {
        // isloading = false;
      }
    });
  }


  navDialog1(BuildContext context, String title, String contant) {
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
              height: (title == "") ? 20.h : 22.h,
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
                            // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> order_id() ));

                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  (title != "") ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ) : Container(),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                      children: [
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height: 40.0,
                            width: 30.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xff333389),
                            ),
                            child: Text("ok",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decorationColor: Colors.black,
                                    fontFamily: 'poppins')),
                          ),
                          onTap: () {
                            // Navigator.pop(context);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => your_order()));
                          },
                        ),
                        // GestureDetector(
                        //   child: Container(
                        //     height: 40.0,
                        //     width: 30.w,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.rectangle,
                        //       borderRadius: BorderRadius.circular(20.0),
                        //       color: Color(0xff333389),
                        //     ),
                        //     child: Center(
                        //       child: Text("No",
                        //           textAlign: TextAlign.center,
                        //           style:  TextStyle(
                        //               fontSize: 14.sp,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.white,
                        //               decorationColor: Colors.black,
                        //               fontFamily: 'poppins')),
                        //     ),
                        //   ),
                        //   onTap: () {
                        //
                        //     Navigator.pop(context);
                        //
                        //   },
                        // ),
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
              height: (title == "") ? 15.5.h : 19.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h,),
                  (title != "") ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ) : Container(),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                  Row(children: [
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
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decorationColor: Colors.black,
                                  fontFamily: 'poppins')),
                        ),
                      ),
                      onTap: () {
                        // Navigator.pop(context);


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
                              style: TextStyle(
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

}



