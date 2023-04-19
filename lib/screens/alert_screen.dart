import 'dart:convert';

import 'package:casadealerapp/modal_class/convertblockorder.dart';
import 'package:casadealerapp/provider/productprovider.dart';
import 'package:casadealerapp/screens/order_detail.dart';
import 'package:casadealerapp/screens/order_id.dart';
import 'package:casadealerapp/screens/summary_b_edit.dart';
import 'package:casadealerapp/screens/your_block_order.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class alert_screen extends StatefulWidget {
  String? id;
   alert_screen({Key? key,this.id}) : super(key: key);

  @override
  State<alert_screen> createState() => _alert_screenState();
}

class _alert_screenState extends State<alert_screen> {
  convertblockorder? convertorder;
  int al = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: <Widget>[
            Container(
              height: 100.h,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff393939),
            ),
            Positioned(
              top: 65.h,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: 35.h,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        height: 0.5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Color(0xff333389),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Are you sure?',
                              style: TextStyle(
                                  color: Color(0xff333389),
                                  fontSize: 2.5.h,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 0.8.h),
                            Text(
                              'Want to unblock order.',
                              style: TextStyle(
                                  color: Color(0xff333389),
                                  fontSize: 2.5.h,
                                  fontWeight: FontWeight.w500),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.h),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    al = 1;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => your_block_order()));
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(0.1.h),
                                  alignment: Alignment.center,
                                  width: 40.w,
                                  height: 5.5.h,
                                  decoration: BoxDecoration(
                                      color: (al == 0)
                                          ? Colors.white
                                          : Color(0xfff333389),
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Color(0xff333389))),
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        color: (al == 0)
                                            ? Color(0xff333389)
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.h),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 0.6.h,
                              // ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    al = 0;
                                  });
                                  unblockorder();
                                  print("abcde");
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => order_id()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(0.1.h),
                                  alignment: Alignment.center,
                                  width: 40.w,
                                  height: 5.5.h,
                                  decoration: BoxDecoration(
                                      color: (al == 1)
                                          ? Colors.white
                                          : Color(0xfff333389),
                                      // color:_selectedColor,

                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Color(0xff333389))),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: (al == 1)
                                            ? Color(0xff333389)
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.h),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ]),
        ],
      ),
    );
  }
  unblockorder(){
    final Map<String, String> data = {};
    data['action'] = 'unblock_blockorder';
    data['d_id'] =(userData?.logindata?.dId).toString();
    data['order_no'] = widget.id.toString(); print(data);
    checkInternet().then((internet) async {
      if (internet) {
        Productprovider()
            .unblockblockorderapi(data)
            .then((Response response) async {
          convertorder = convertblockorder.fromJson(json.decode(response.body));
          print(response?.statusCode);
          if (response.statusCode == 200 && convertorder?.status == "success") {
            setState(() {
            });

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => your_block_order()));

          } else {

          }
        });
      } else {
      }
    });
  }
}
