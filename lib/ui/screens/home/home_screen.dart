import 'dart:io';

import 'package:energize_flutter/ui/screens/Add_payload/add_payload_screen.dart';
import 'package:energize_flutter/ui/widget_Items_list/Loader.dart';
import 'package:energize_flutter/ui/widget_Items_list/shipmentListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../business/homeController/HomeController.dart';
import '../../../conustant/AppLocale.dart';
import '../../../conustant/my_colors.dart';
import '../auth/login/login_screen.dart';
import '../filters/home_filter/home_filter_screen.dart';
import '../filters/home_filter2/HomeFilterScreen2.dart';
import '../menu/cities/cities_screen.dart';
import '../menu/profile/profile_screen.dart';
import '../shimer_pages/shimmer.dart';
import '../shipment_categories_details/shipment_category_details_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}


class _HomeScreen extends State<HomeScreen>with TickerProviderStateMixin{
  final homeController=Get.put(HomeController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    homeController.isLoading.value=true;
    homeController.getHomeData(0,0,0,0,context);
    super.initState();
    homeController.getData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            exit(0);
          },
          child:Obx(() =>!homeController.isLoading.value?
          Scaffold(
            body: OfflineBuilder(
              connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
                bool connected = true;
                if (connected)   {
                  return Builder(
                    builder: (context) {
                      return RefreshIndicator(
                          key: _refreshIndicatorKey,
                          color: Colors.white,
                          backgroundColor: MyColors.MAINCOLORS,
                          strokeWidth: 4.0,
                          onRefresh: () async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt("driverIdFilter", 0);
                            prefs.setInt("userIdFilter", 0);
                            prefs.setInt("delegateIdFilter", 0);
                            prefs.setInt("branchIdFilter", 0);
                            homeController.GraduationController.text="";
                        return homeController.getHomeData(0,0,0,0,context);
                      },
                        child: Directionality(
                          textDirection: homeController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                            child: ListView(
                              // mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomAppBar(),
                                SizedBox(height: 20,),
                                HomeCategories(),
                                //shimmer()
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                }
                else {
                  return  NoIntrnet();
                }
              },
              child: const Center(
                child: CircularProgressIndicator(
                  color: MyColors.MAINCOLORS,
                ),
              ),
            ),
            endDrawer: Drawer(width: 280,
              child: DrowerScreen(),
            ),
            drawer: Drawer(width: 280,
              child: DrowerScreen(),
            ),
          ):shimmer()
          )
        ),
      ),
    );
  }
  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/internet.svg'),
          SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_internet")}",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget CustomAppBar(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
                builder: (context) {
                  return IconButton(
                      onPressed: (){
                        if(homeController.lang.contains("en")){
                          Scaffold.of(context).openDrawer();
                        }else{
                          Scaffold.of(context).openEndDrawer();
                        }

                      },
                      icon:  Icon(Icons.dehaze_rounded,color: Colors.black,));
                }
            ),
            Center(
              child:Container(
                width: 143,
                height:40,
                child:Image(
                  image: AssetImage('assets/logo3.png'),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                ) ,
              ),
            ),
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/notification_screen");
                },
                icon:  SvgPicture.asset('assets/notification.svg')),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
                "${getLang(context, "Shipment_reports")}",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'din_next_arabic_bold',
                    fontWeight: FontWeight.w700,
                    color: MyColors.Dark1),
                textAlign: TextAlign.start,
              ),
            GestureDetector(
              onTap: ()async{
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt("driverIdFilter", 0);
                prefs.setInt("userIdFilter", 0);
                prefs.setInt("delegateIdFilter", 0);
                prefs.setInt("branchIdFilter", 0);
                homeController.GraduationController.text="";
                showModalBottomSheet<void>(
                    transitionAnimationController: AnimationController(vsync: this,duration: Duration(seconds: 1)),
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    //backgroundColor:MyColors.DarkWHITE,
                    builder: (BuildContext context)=>Padding(
                      padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.7,
                          minChildSize: 0.32,
                          maxChildSize: 0.9,
                          builder: (BuildContext context, ScrollController scrollController)=> SingleChildScrollView(
                            controller:scrollController,
                            child: HomeFilterScreen2(fromWhere: "HomeScreen"),
                          )
                      ),
                    )
                );
              },
              child: Container(
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 0,
                        color: MyColors.Dark3
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.Dark5,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ]
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset('assets/filter.svg'),
                      Text("${getLang(context, "filter")}",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget HomeCategories(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row1(),
            const SizedBox(height: 8,),
            Row2(),
            const SizedBox(height: 8,),
            Row3(),
            const SizedBox(height: 8,),
            Row4(),
            const SizedBox(height: 8,),
            Row5(),
            SizedBox(height: 5,),
            (homeController.role=="delegate"||homeController.role=="admin")? Button():Container(),
          ],
        ),
    );
  }
  //////////////////////////////////categories Rows///////////////////
  Widget Row1(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "requesting")}",state:"requesting");
                  }));
              //Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "loading")}");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.SideYELLOW,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/requesting.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.requesting!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "requesting")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 5,),
        /////////////قيد التحميل
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "loading")}",state:"loading");
                  }));
              //Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "loading")}");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                        color: MyColors.SideYELLOW,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/loading.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.pending!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "loading")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Row2(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///////////تم التحميل
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "uploaded")}",state:"uploaded");
                  }));
              //Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "uploaded")}");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.Sidebrowen,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/uploaded.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.uploaded!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "uploaded")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        /////////////فى الطريق
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "on_way")}",state:"on_way");
                  }));
             // Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "on_way")}");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.Sideblue,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/on_way.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.onWay!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "on_way")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Row3(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///////////تم الوصول
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "arrived")}",state:"arrived");
                  }));
              //Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "arrived")}");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.Sidegreen,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/arrived.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.arrived!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "arrived")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        /////////////تم ارسال السند
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "bond_sent")}",state:"bond_sent");
                  }));
              //Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "bond_sent")}");

            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.Secondry_Color,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/clipboard_export.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.bondSent!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "bond_sent")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Row4(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///////////تم استلام السند
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "bond_received")}",state:"bond_received");
                  }));
              //Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "bond_received")}");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.SideLimon,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/clipboard_import.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.bondReceived!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "bond_received")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        /////////////فى الطريق
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "late_shipments")}",state:"late_shipments");
                  }));
              // Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "on_way")}");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.Sideblue,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/truck_remove.svg'),
                            SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.lateShipments!.toString())??"",
                              style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "late_shipments")}",
                              style: TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Row5(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///////////الغاء
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ShipmentCategoryDetailsScreen(appbarTitle: "${getLang(context, "cancel")}",state:"cancelled");
                  }));
              //Navigator.pushNamed(context, '/shipment_category_details_screen',arguments: "${getLang(context, "bond_received")}");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.DarkWHITE,
                  boxShadow: const [
                    BoxShadow(
                      color: MyColors.Dark5,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 3,
                    height: 112,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: MyColors.Sidebrowen,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/cancel.svg'),
                            const SizedBox(height: 5,),
                            Text((homeController.homeResponse.value.data?.cancelled!.toString())??"",
                              style: const TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
                              textAlign: TextAlign.center,
                            ),
                            Text("${getLang(context, "cancel")}",
                              style: const TextStyle(fontSize: 20,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Button(){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        backgroundColor: MyColors.MAINCOLORS,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ));
    return Container(
      width: double.infinity,
      height: 60,
      child: TextButton(
        style: flatButtonStyle ,
        onPressed: (){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return AddPayloadScreen(fromWhere: "home");
              }));
          //Navigator.pushNamed(context, "/add_payload_screen");
        },
        child: Text("${getLang(context, "Add_a_payload")}",
          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
      ),
    );
  }
  /////////////////DrowerList/////////////////////////////
  Widget DrowerScreen(){
    return Directionality(
      textDirection: homeController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: MyColors.MAINCOLORS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: NetworkImage(
                          homeController.pic,
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        homeController.userName,maxLines: 2,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'din_next_arabic_bold',
                            fontWeight: FontWeight.w700,
                            color: MyColors.DarkWHITE),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        homeController.userPhone,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'din_next_arabic_regulare',
                            fontWeight: FontWeight.w400,
                            color: MyColors.DarkWHITE),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child: Center(
                  child: SvgPicture.asset(
                'assets/user.svg',
                width: 24,
                height: 24,
              )),
            ),
            title: Text(
              "${getLang(context, "profile")}",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return ProfileScreen();
                  }));
              //Navigator.pushNamed(context, '/profile_screen');
            },
          ),
          (homeController.role=="delegate"
              ||homeController.role=="admin")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/profile_2user.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "delegates")}",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/delegate_screen');
            },
          ):Container(),
          (homeController.role=="delegate"
              ||homeController.role=="admin")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/people.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "clients")}",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/clients_screen');
            },
          ):Container(),
          (homeController.role=="delegate"
              ||homeController.role=="admin")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child:  Center(
                  child: SvgPicture.asset('assets/driver2.svg'),
                  /*Image(
                    image: AssetImage('assets/driver.png',),
                    width: 24,
                    height: 24,)*/
              ),
            ),
            title: Text(
              "${getLang(context, "drivers")}",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/drivers_screen');
            },
          ):Container(),
          (homeController.role=="delegate"
              ||homeController.role=="admin")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child:  Center(
                child: SvgPicture.asset('assets/buildings_2.svg'),
              ),
            ),
            title: Text(
              "${getLang(context, "city")}",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/cities_screen');
            },
          ):Container(),
          (homeController.role=="admin"||
              homeController.role=="delegate")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/document_filter.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "Comprehensive_reports")}",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/comprehensive_reports_screen');
            },
          ):
          Container(),
          (homeController.role=="admin"||
              homeController.role=="user"||
              homeController.role=="delegate")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/menu_board.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "Customer_reports")}",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/customer_reports_screen');
            },
          ):
          Container(),
          (homeController.role=="delegate"
              ||homeController.role=="admin")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/buildings_2.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "branches")}",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/branches_screen');
            },
          ):Container(),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.Dark6),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/buildings_2.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "car_owner")}",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/car_owner_screen');
            },
          ),
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.frameRed),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/logout.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "logout")}",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.SideRed),
              textAlign: TextAlign.start,
            ),
            onTap: () async{
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              homeController.updateToken(context);
              await prefs.setBool('isLogin',false);
              //Navigator.pushNamedAndRemoveUntil(context,'/login_screen',ModalRoute.withName('/login_screen'));
            },
          ),
          (homeController.role=="admin")?
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: MyColors.frameRed),
              child: Center(
                  child: SvgPicture.asset(
                    'assets/logout.svg',
                    width: 24,
                    height: 24,
                  )),
            ),
            title: Text(
              "${getLang(context, "delete_account")}",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'din_next_arabic_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.SideRed),
              textAlign: TextAlign.start,
            ),
            onTap: () async{
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              // Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
              // await prefs.setBool('isLogin',false);
              Navigator.pushNamedAndRemoveUntil(context,'/login_screen',ModalRoute.withName('/login_screen'));
            },
          ):
          Container(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();

  // removeData()async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefs.setInt("driverId", 0);
  //     prefs.setInt("userId", 0);
  //     prefs.setInt("delegateId", 0);
  //     prefs.setInt("branchId", 0);
  //   });
  // }
}



