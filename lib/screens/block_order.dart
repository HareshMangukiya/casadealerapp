//
// import 'package:casadealerapp/screens/summary.dart';
// import 'package:casadealerapp/screens/your_block_order.dart';
// import 'package:casadealerapp/widget/drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// class block_order extends StatefulWidget {
//   const block_order({Key? key}) : super(key: key);
//
//   @override
//   State<block_order> createState() => _block_orderState();
// }
//
// class _block_orderState extends State<block_order> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool? check = false;
//   int sum = 0;
//   int sumindex = 0;
//   List<String> tabs = ["Blocked", "Cart"];
//   List<bool> checkbox = [
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false
//   ];
//
//   int cart = 0;
//   int i = 1000;
//
//   final controller = PageController(viewportFraction: 0.8, keepPage: true);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: Color(0xfffFFFFFF),
//       drawer: drawer(context),
//       key: _scaffoldKey,
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 1,
//               height: 8.h,
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: 0.h, left: 2.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             _scaffoldKey.currentState?.openDrawer();
//                           },
//                           icon: Icon(
//                             Icons.menu,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 2.3.h,
//                         ),
//                         Container(
//                           // padding: EdgeInsets.only(top: 1.5.h),
//                           // alignment: Alignment.center,
//                           child: Text(
//                             "Blocked Orders",
//                             style:
//                                 TextStyle(fontSize: 2.h, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 8.h,
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             // _scaffoldKey.currentState?.openDrawer();
//                           },
//                           icon: Icon(
//                             Icons.search,
//                             color: Colors.white,
//                             size: 3.h,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 1.h,
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // _scaffoldKey.currentState?.openDrawer();
//                           },
//                           icon: Icon(
//                             Icons.shopping_bag_outlined,
//                             color: Colors.white,
//                             size: 3.h,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: Color(0xfff333389),
//                 // borderRadius: BorderRadius.all(
//                 //   Radius.circular(10),
//                 // ),
//               ),
//             ),
//             SizedBox(height: 0.8.h),
//             Column(
//               children: [
//                 Container(
//                   height: 79.h,
//                   child: ListView.builder(
//                     // padding: EdgeInsets.all(0),
//                     // visualDensity: VisualDensity(horizontal: 4, vertical: 4),
//                     // horizontalTitleGap: 0.0,
//
//                     itemCount: checkbox.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Container(
//                         // padding: EdgeInsets.all(0),
//                         // alignment: Alignment.center,
//                         height: 15.h,
//                         margin: EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: Color(0xfffafafa),
//                           border: Border.all(color: Color(0xffe8e8e8)),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.asset(
//                                 'assets/product_1_img2.png',
//                                 height: 15.h,
//                                 width: 25.w,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             // SizedBox(
//                             //   width: 5.w,
//                             // ),
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(1.h),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Street Wear',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 2.3.h),
//                                           ),
//                                           SizedBox(width: 5.w),
//                                           Text(
//                                             '₹125',
//                                             style: TextStyle(
//                                                 color: Color(0xff5a5a9f)),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 1.5.h),
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Color : Red   Size : M',
//                                             style: TextStyle(
//                                                 color: Color(0xff5a5a9f),
//                                                 fontSize: 1.7.h),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 2.h),
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Qty :',
//                                             style: TextStyle(
//                                                 color: Color(0xff5a5a9f)),
//                                           ),
//                                           SizedBox(width: 2.h),
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: 4.h,
//                                             width: 25.w,
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                 color: Color(0xff5a5a9f),
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         if (i > 1) {
//                                                           i--;
//                                                         }
//                                                       });
//                                                     },
//                                                     child: Icon(
//                                                       Icons.remove,
//                                                       size: 2.h,
//                                                       color: Color(0xff5a5a9f),
//                                                     )),
//                                                 Text(
//                                                   i.toString(),
//                                                   style: TextStyle(
//                                                       color: Color(0xff5a5a9f),
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                                 GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         i++;
//                                                       });
//                                                     },
//                                                     child: Icon(
//                                                       Icons.add,
//                                                       size: 2.h,
//                                                       color: Color(0xff5a5a9f),
//                                                     ))
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: 1.3.w),
//                                 Padding(
//                                   padding: EdgeInsets.all(0.2.h),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 5.h,
//                                         width: 18.w,
//                                         child: Checkbox(
//                                           // checkColor: Color(0xff333389),
//                                           activeColor: Color(0xff333389),
//
//                                           value: checkbox[index],
//                                           onChanged: (value) {
//                                             setState(() {
//                                               checkbox[index] = value!;
//                                             });
//
//                                             // Handle checkbox value change
//                                           },
//                                         ),
//                                       ),
//                                       SizedBox(height: 3.h),
//                                       Container(
//                                         margin: EdgeInsets.only(left: 3.9.w),
//                                         decoration: BoxDecoration(
//                                           color: Color(0xffe2e2ed),
//
//                                           // border: Border.all(
//                                           //   // color:  Color(0xff5a5a9f),
//                                           // ),
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         height: 5.h,
//                                         width: 10.w,
//                                         child: Icon(
//                                           Icons.more_vert,
//                                           color: Color(0xff5a5a9f),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 9.h,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.h),
//                     child: Container(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => summary()));
//                               setState(() {
//                                 cart = 1;
//                               });
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(0.1.h),
//                               alignment: Alignment.center,
//                               width: 40.w,
//                               height: 8.h,
//                               decoration: BoxDecoration(
//                                   color: (cart == 0)
//                                       ? Colors.white
//                                       : Color(0xfff333389),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(color: Colors.white)),
//                               child: Text(
//                                 'Exit',
//                                 style: TextStyle(
//                                     color: (cart == 0)
//                                         ? Color(0xff333389)
//                                         : Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 2.2.h),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 2.w,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           your_block_order()));
//                               setState(() {
//                                 cart = 0;
//                               });
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(0.1.h),
//                               alignment: Alignment.center,
//                               width: 40.w,
//                               height: 8.h,
//                               decoration: BoxDecoration(
//                                   color: (cart == 1)
//                                       ? Colors.white
//                                       : Color(0xfff333389),
//                                   // color:_selectedColor,
//
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(color: Colors.white)),
//                               child: Text(
//                                 'Confirm',
//                                 style: TextStyle(
//                                     color: (cart == 1)
//                                         ? Color(0xff333389)
//                                         : Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 2.2.h),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     // borderRadius: BorderRadius.all(
//                     //   Radius.circular(10),
//
//                     // ),
//
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 15.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }
