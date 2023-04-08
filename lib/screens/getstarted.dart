
import 'dart:async';


import 'package:casadealerapp/screens/login.dart';
import 'package:casadealerapp/screens/products_1.dart';
import 'package:casadealerapp/widget/CONST.dart';
import 'package:casadealerapp/widget/shared_preference.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class get_started extends StatefulWidget {
  const get_started({Key? key}) : super(key: key);

  @override
  State<get_started> createState() => _get_startedState();
}

class _get_startedState extends State<get_started> {
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      userData == null
          ? Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => login(),
            ))
          : Navigator.of(this.context).pushReplacement(MaterialPageRoute(
              builder: (context) => products_1(),
            ));
      // Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) => login())):
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => products_1()));
    });
  }

  getdata() async {
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Stack(children: [
          Column(
            children: [
              Container(
                height: 70.h,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/get_started2.png',
                  fit: BoxFit.fill,
                  // height: MediaQuery.of(context).size.height * 1,
                  // width: MediaQuery.of(context).size.width * 2,
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                height: 12.h,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/get_started_logo.png',
                  fit: BoxFit.contain,
                  // height: MediaQuery.of(context).size.height * 1,
                  // width: MediaQuery.of(context).size.width * 2,
                ),
              ),
            ],
          ),


        ]),
      ),
    );
  }
}
