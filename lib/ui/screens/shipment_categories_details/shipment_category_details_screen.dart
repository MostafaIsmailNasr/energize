import 'package:energize_flutter/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../business/categoryDetailsController/CategoryDetailsController.dart';
import '../../../business/homeController/HomeController.dart';
import '../../../business/shipmentCategoryDetailsController/ShipmentCategoryDetailsController.dart';
import '../../../conustant/AppLocale.dart';
import '../../../conustant/my_colors.dart';
import '../../widget_Items_list/ListCategoryItem.dart';
import '../../widget_Items_list/shipmentListItem.dart';
import '../filters/home_filter/home_filter_screen.dart';
import '../shimer_pages/shimmer_category.dart';

class ShipmentCategoryDetailsScreen extends StatefulWidget{
  String appbarTitle;
  String state;
  ShipmentCategoryDetailsScreen({required this.appbarTitle,required this.state});

  @override
  State<StatefulWidget> createState() {
    return _ShipmentCategoryDetailsScreen(appbarTitle: appbarTitle,state: state);
  }
}

class _ShipmentCategoryDetailsScreen extends State<ShipmentCategoryDetailsScreen>with TickerProviderStateMixin{
  String appbarTitle;
  String state;
  var selectedFlage;
  _ShipmentCategoryDetailsScreen({required this.appbarTitle,required this.state});
  final shipmentCategoryController=Get.put(ShipmentCategoryDetailsController());
  final categoryDetailsController=Get.put(CategoryDetailsController());
  final homeController=Get.put(HomeController());
   ItemScrollController _scrollController = ItemScrollController();
  ScrollController _scrollControllerlist=ScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();


  @override
  void initState() {
    //shipmentCategoryController.statuse="";
    getData();
    shipmentCategoryController.filterKey="";
    shipmentCategoryController.filterStartDate="";
    shipmentCategoryController.filterEndDate="";
    shipmentCategoryController.userId=0;
    shipmentCategoryController.driverId=0;
    shipmentCategoryController.delegateId=0;
    shipmentCategoryController.GraduationController.text=homeController.GraduationController.text;
    shipmentCategoryController.CarNumController.text=homeController.CarNumController.text;
    shipmentCategoryController.page=1;
    GetShipmentCategoryWithStatus();
    shipmentCategoryController.scroll.addListener(shipmentCategoryController.scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Future. delayed(Duration(seconds: 2), ()=> _scrollToItem());
      Future. delayed(const Duration(seconds: 3), ()=> selectedList(state));
    });
    super.initState();
  }
  getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("driverId2", 0);
    prefs.setInt("userId2", 0);
    prefs.setInt("delegateId2", 0);
  }
  void _scrollToItem() {
    // Replace `indexToScroll` with the index of the item you want to scroll to
    selectedFlage=5;
     int indexToScroll = selectedFlage;

    // Replace `itemExtent` with the height of each item in the ListView
    const double itemExtent = 100.0;

    _scrollControllerlist.animateTo(
      indexToScroll * itemExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }


  selectedList(String name){
    switch(name){
      case "requesting":
        selectedFlage=0;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
      break;
      case "loading":
        selectedFlage=1;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        break;
      case "uploaded":
        selectedFlage=2;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        break;
      case "on_way":
        selectedFlage=3;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        break;
      case "arrived":
        selectedFlage=4;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        break;
      case "bond_sent":
        selectedFlage=5;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        break;
      case "bond_received":
        selectedFlage=6;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        break;
      case "late_shipments":
        selectedFlage=7;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        break;
      case "cancelled":
        selectedFlage=8;
        setState(() {
          _scrollController.jumpTo(index: selectedFlage,);
        });
        // _scrollController.scrollTo(
        //   index: selectedFlage,
        //   duration: Duration(seconds: 5),
        // );
        break;
    }
  }

  GetShipmentCategoryWithStatus()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("HomeStatus", state);
    switch(state){
      case "requesting":
        shipmentCategoryController.statuse="requesting";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "loading":
        shipmentCategoryController.statuse="pending";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "uploaded":
        shipmentCategoryController.statuse="uploaded";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "on_way":
        shipmentCategoryController.statuse="on_way";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "arrived":
        shipmentCategoryController.statuse="arrived";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "bond_sent":
        shipmentCategoryController.statuse="bond_sent";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "bond_received":
        shipmentCategoryController.statuse="bond_received";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "late_shipments":
        shipmentCategoryController.statuse="late_shipments";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
      case "cancelled":
        shipmentCategoryController.statuse="cancelled";
        shipmentCategoryController.page=1;
        shipmentCategoryController.GetShipmentCategory(
            shipmentCategoryController.statuse,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate,
            shipmentCategoryController.GraduationController.text,
            shipmentCategoryController.CarNumController.text,
            shipmentCategoryController.page=1);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
            const bool connected =true; //connectivity != ConnectivityResult.none;
            if (connected) {
              return Directionality(
                  textDirection: shipmentCategoryController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                child:  Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        iconSize: 20,
                        onPressed: () async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt("driverIdFilter", 0);
                          prefs.setInt("userIdFilter", 0);
                          prefs.setInt("delegateIdFilter", 0);
                          prefs.setInt("branchIdFilter", 0);
                          prefs.setInt("driverIdCat", 0);
                          prefs.setInt("userIdCat", 0);
                          prefs.setInt("delegateIdCat", 0);
                          prefs.setInt("branchIdCat", 0);
                          prefs.setInt("branchId", 0);
                          shipmentCategoryController.GraduationController.text="";
                          homeController.GraduationController.text="";
                          shipmentCategoryController.CarNumController.text="";
                          homeController.CarNumController.text="";
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: MyColors.Dark1)),
                    title: Text(
                      appbarTitle,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'din_next_arabic_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                      textAlign: TextAlign.start,
                    ),
                    actions: [
                      GestureDetector(
                        onTap: ()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("status1", shipmentCategoryController.statuse);
                          // ignore: use_build_context_synchronously
                          showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              transitionAnimationController: AnimationController(vsync: this,duration: Duration(seconds: 1)),
                              builder: (BuildContext context)=>DraggableScrollableSheet(
                                  expand: false,
                                  initialChildSize: 0.9,
                                  minChildSize: 0.32,
                                  maxChildSize: 0.9,
                                  builder: (BuildContext context, ScrollController scrollController)=> SingleChildScrollView(
                                    controller:scrollController,
                                    child: HomeFilterScreen(fromWhere: "ShipmentCategoryDetailsScreen"),
                                  )
                              )
                          );
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(left: 24,right: 24),
                            child: SvgPicture.asset('assets/filter.svg')),
                      ),
                    ],
                    backgroundColor: MyColors.Dark6,
                  ),
                  body: Obx(() =>!shipmentCategoryController.isLoading.value? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() =>  HoriZontalListCategory()),
                      //Obx(() => Expanded(child: VerticalList())),
                      Obx(() => !shipmentCategoryController.isLoading2.value
                          ? Expanded(child: VerticalList()): shipmentCategoryController.page==1?
                      const Center(
                          child: CircularProgressIndicator(
                            color: MyColors.MAINCOLORS,
                          )):Expanded(child: VerticalList())),
                      const SizedBox(height: 10,)
                    ],
                  )
                      :ShimmerCategory()),
              ));
            } else {
              return  Scaffold(body: NoIntrnet());
            }
          },
          child: const Center(
            child: CircularProgressIndicator(
              color: MyColors.MAINCOLORS,
            ),
          ),
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
          const SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_internet")}",
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget HoriZontalListCategory(){
    List<Widget> _list =[
      ListCategoryItem(
          Icon:'assets/requesting.svg',
          Name: "${getLang(context, "requesting")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.requesting.toString()??"",
          is_selected:selectedFlage==0,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=0;
              shipmentCategoryController.statuse="requesting";
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,
                  shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/loading.svg',
          Name: "${getLang(context, "loading")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.pending.toString()??"",
          is_selected:selectedFlage==1,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=1;
              shipmentCategoryController.statuse="pending";
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/uploaded.svg',
          Name: "${getLang(context, "uploaded")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.uploaded.toString()??"",
          is_selected:selectedFlage==2,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=2;
              shipmentCategoryController.statuse="uploaded";
              print(selectedFlage);
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/on_way.svg',
          Name: "${getLang(context, "on_way")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.onWay.toString()??"",
          is_selected:selectedFlage==3,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=3;
              shipmentCategoryController.statuse="on_way";
              print(selectedFlage);
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/arrived.svg',
          Name: "${getLang(context, "arrived")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.arrived.toString()??"",
          is_selected:selectedFlage==4,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=4;
              shipmentCategoryController.statuse="arrived";
              print(selectedFlage);
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/clipboard_export.svg',
          Name: "${getLang(context, "bond_sent")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.bondSent.toString()??"",
          is_selected:selectedFlage==5,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=5;
              shipmentCategoryController.statuse="bond_sent";
              print(selectedFlage);
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/clipboard_import.svg',
          Name: "${getLang(context, "bond_received")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.bondReceived.toString()??"",
          is_selected:selectedFlage==6,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=6;
              shipmentCategoryController.statuse="bond_received";
              print(selectedFlage);
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/truck_remove.svg',
          Name: "${getLang(context, "late_shipments")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.lateShipments.toString()??"",
          is_selected:selectedFlage==7,
          onTap: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=7;
              shipmentCategoryController.statuse="late_shipments";
              print(selectedFlage);
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
      ListCategoryItem(
          Icon:  'assets/cancel.svg',
          Name: "${getLang(context, "cancel")}",
          value: shipmentCategoryController.shipmentCategoryDetailsResponse.value.data?.statues?.cancelled.toString()??"",
          is_selected:selectedFlage==8,
          onTap: () async {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.setInt("driverIdCat", 0);
            prefs.setInt("userIdCat", 0);
            prefs.setInt("delegateIdCat", 0);
            prefs.setInt("branchIdCat", 0);
            prefs.setInt("branchId", 0);
            shipmentCategoryController.GraduationController.text="";
            homeController.GraduationController.text="";
            shipmentCategoryController.CarNumController.text="";
            homeController.CarNumController.text="";
            setState(() {
              selectedFlage=8;
              shipmentCategoryController.statuse="cancelled";
              print(selectedFlage);
              shipmentCategoryController.filterKey="";
              shipmentCategoryController.filterStartDate="";
              shipmentCategoryController.filterEndDate="";
              shipmentCategoryController.userId=0;
              shipmentCategoryController.driverId=0;
              shipmentCategoryController.delegateId=0;
              shipmentCategoryController.branchId=0;
              shipmentCategoryController.page=1;
              shipmentCategoryController.GetShipmentCategoryWithStatus(
                  shipmentCategoryController.statuse,shipmentCategoryController.filterKey,
                  shipmentCategoryController.filterStartDate,shipmentCategoryController.filterEndDate);
            });
          }
      ),
    ];
    return Container(
        height: 150,
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        // child: ListView(
        //   scrollDirection: Axis.horizontal,
        //   controller: _scrollControllerlist,
        //   children:_list,),
        child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
            itemScrollController: _scrollController,
          itemPositionsListener: itemPositionsListener,
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return _list[index];
            },
        )
    );
  }


  Widget VerticalList() {
    if(shipmentCategoryController.shipmentCategoryList.isNotEmpty){
      return ListView.builder(
        controller: shipmentCategoryController.scroll,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: shipmentCategoryController.shipmentCategoryList.length,
        itemBuilder: (BuildContext context, int index) {
          if (shipmentCategoryController.shipmentCategoryList[index].userName != "loading") {
            return ShipmentListItem(
              shipmentCategoryList: shipmentCategoryController.shipmentCategoryList[index],
              title: appbarTitle,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: MyColors.MAINCOLORS),
            );
          }
        },
      );
    }else{
      return emptyDriver();
    }
  }
}
class emptyDriver extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          children: [
            //Image(image: AssetImage('assets/error.png')),
            SvgPicture.asset('assets/error_img.svg'),
            SizedBox(height: 10,),
            Text("${getLang(context, "There_are_no_clients")}",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text("${getLang(context, "You_havent_added_any_clients")}",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}