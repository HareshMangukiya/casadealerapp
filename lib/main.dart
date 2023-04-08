
import 'package:casadealerapp/screens/forget_password.dart';
import 'package:casadealerapp/screens/getstarted.dart';

import 'package:casadealerapp/provider/productprovider.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'provider/login_authprovider.dart';

int? gen = 0;
int? totals = 0;
int? totalm = 0;
int? totall = 0;
int? totalxl = 0;
int? total2xl = 0;
int? total3xl = 0;
int? total4xl = 0;
int? total5xl = 0;
int? totalxs = 0;
int sumindex1 = 0;
int sumindex = 0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Authprovider()),
            ChangeNotifierProvider(create: (context) => Productprovider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: get_started(),
          ),
        );
      },
    );
  }
}
