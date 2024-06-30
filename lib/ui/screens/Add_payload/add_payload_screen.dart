import 'package:energize_flutter/ui/screens/home/home_screen.dart';
import 'package:energize_flutter/ui/screens/shimer_pages/shimmer.dart';
import 'package:energize_flutter/ui/screens/shipment_categories_details/shipment_category_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'as ddd ;
// import 'package:flutter_datetime_picker/src/datetime_picker_theme.dart' as theme;
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../business/addPayloadController/AddPayloadController.dart';
import '../../../conustant/AppLocale.dart';
import '../../../conustant/my_colors.dart';
import '../../../data/model/CarOwnerListModel/CarOwnerListResponse.dart';
import '../../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../../../data/model/addPayloadModel/carLengthModel/CarLengthResponse.dart';
import '../../../data/model/addPayloadModel/carTypeModel/CarTypeResponse.dart';
import '../../../data/model/addPayloadModel/cities/CitiesResponse.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:ui' as ui;

import '../../../data/model/shipmentCategoryDetailsModel/ShipmentCategoryDetailsResponse.dart';
import '../../widget_Items_list/Loader.dart';


enum dateGroup{cash,delay}
class AddPayloadScreen extends StatefulWidget{
  var fromWhere;
  final Orders2? shipmentCategoryList;

  AddPayloadScreen({this.fromWhere, this.shipmentCategoryList});

  @override
  State<StatefulWidget> createState() {
    return _AddPayloadScreen(fromWhere);
  }
}

class _AddPayloadScreen extends State<AddPayloadScreen>{
  final addPayloadController=Get.put(AddPayloadController());
  DateTime? selectedDateTime;
  DateTime? selectedDateTime2;
  DateTime? selectedDateTime3;
  dateGroup date=dateGroup.cash;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  var fromWhere;


  _AddPayloadScreen(this.fromWhere);

  @override
  void initState() {
    addPayloadController.isLoading.value=true;
    addPayloadController.getCarType();
    addPayloadController.getCarLength();
    addPayloadController.getCities();
    addPayloadController.getBranch();
    addPayloadController.getCarOwnerList();
    if(fromWhere=="edite"){
      if(widget.shipmentCategoryList!.carTypeName!=null
      &&widget.shipmentCategoryList!.carLengthName!=null
          &&widget.shipmentCategoryList!.startAreaName!=null
          &&widget.shipmentCategoryList!.reachAreaName!=null
          &&widget.shipmentCategoryList!.branchName!=null
          &&widget.shipmentCategoryList!.loadTime!=null
          &&widget.shipmentCategoryList!.startTime!=null
          &&widget.shipmentCategoryList!.endTime!=null){
        addPayloadController.car?.name=widget.shipmentCategoryList!.carTypeName;

        addPayloadController.dropdownValue=widget.shipmentCategoryList!.carTypeId;
        addPayloadController.carLeng?.name=widget.shipmentCategoryList!.carLengthName;
        addPayloadController.dropdownValue2=widget.shipmentCategoryList!.carLengthId;
        addPayloadController.city?.name=widget.shipmentCategoryList!.startAreaName;
        addPayloadController.launch_area=widget.shipmentCategoryList!.startAreaId;
        addPayloadController.cityArrived?.name=widget.shipmentCategoryList!.reachAreaName;
        addPayloadController.access_area=widget.shipmentCategoryList!.reachAreaId;
        addPayloadController.defultBranch?.name=widget.shipmentCategoryList!.branchName;
        addPayloadController.choose_branches=widget.shipmentCategoryList!.branchId;
        addPayloadController.chooseCarOwner=widget.shipmentCategoryList!.carOwnerId;
        addPayloadController.upT=widget.shipmentCategoryList!.loadTime;
        addPayloadController.strT=widget.shipmentCategoryList!.startTime;
        addPayloadController.accT=widget.shipmentCategoryList!.endTime;
      }
      if(widget.shipmentCategoryList!.salePrice!=null){
        addPayloadController.buyPriceController.text=widget.shipmentCategoryList!.salePrice.toString();
      }
      if(widget.shipmentCategoryList!.purchasePrice!=null){
        addPayloadController.purchasingPriceController.text=widget.shipmentCategoryList!.purchasePrice.toString();
      }
      if(widget.shipmentCategoryList!.graduationStatement!=null){
        addPayloadController.GraduationController.text=widget.shipmentCategoryList!.graduationStatement.toString();
      }
      if(widget.shipmentCategoryList!.loan!=null){
        addPayloadController.advanceController.text=widget.shipmentCategoryList!.loan.toString();
      }
      if(widget.shipmentCategoryList!.carNumber!=null){
        addPayloadController.carNumberController.text=widget.shipmentCategoryList!.carNumber.toString();
      }
      if(widget.shipmentCategoryList!.notes!=null){
        addPayloadController.notesController.text=widget.shipmentCategoryList!.notes.toString();
      }
      if(widget.shipmentCategoryList!.driverId!=null){
        setState(() {
          addPayloadController.DriverId=widget.shipmentCategoryList!.driverId;
          addPayloadController.DriverName= widget.shipmentCategoryList?.driverName;
        });
        print("ff"+widget.shipmentCategoryList!.driverId.toString());
      }
      if(widget.shipmentCategoryList!.delegateName!=null){
        setState(() {
          addPayloadController.DelegateId=widget.shipmentCategoryList!.createdBy.toString();
          addPayloadController.DelegateName= widget.shipmentCategoryList?.delegateName;
        });
      }
      if(widget.shipmentCategoryList!.userName!=null){
        setState(() {
          addPayloadController.UserId=widget.shipmentCategoryList!.userId;
          addPayloadController.ClientName= widget.shipmentCategoryList?.userName;
        });
        print("ff"+widget.shipmentCategoryList!.userId.toString());
      }
    }
    else{
      addPayloadController.DriverName=null;
      addPayloadController.ClientName=null;
      addPayloadController.DelegateName=null;
    }


    super.initState();
  }
  getName()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("driverName")!=null){
      print("poppp"+prefs.getString("driverName")!.toString());
      setState(() {
        addPayloadController.DriverName=prefs.getString("driverName")!;
      });
    }
    if(prefs.getString("userrName")!=null){
      print("poppp"+prefs.getString("userrName")!.toString());
      setState(() {
        addPayloadController.ClientName=prefs.getString("userrName")!;
      });
    }
    if(prefs.getString("delegateName")!=null){
      print("poppp"+prefs.getString("delegateName")!.toString());
      setState(() {
        addPayloadController.DelegateName=prefs.getString("delegateName")!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getName();
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
        final bool connected = true;//connectivity != ConnectivityResult.none;
        if (connected) {
          return Obx(() =>!addPayloadController.isLoading.value?
          SafeArea(
              child:  Directionality(
                  textDirection: addPayloadController.lang.contains("en")?ui.TextDirection.ltr:ui.TextDirection.rtl,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        iconSize:20,
                        onPressed: (){
                          if(fromWhere=="edite"){
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) {
                            //       return ShipmentCategoryDetailsScreen(appbarTitle: widget.shipmentCategoryList!.status!, state: widget.shipmentCategoryList!.status!);
                            //     }));
                            Navigator.pop(context);
                          }else{
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return HomeScreen();
                                }));
                          }
                          addPayloadController.upT=null;
                          addPayloadController.accT=null;
                          addPayloadController.strT=null;
                          addPayloadController.buyPriceController.clear();
                          addPayloadController.purchasingPriceController.clear();
                          addPayloadController.GraduationController.clear();
                          addPayloadController.advanceController.clear();
                          addPayloadController.advanceController.clear();
                          addPayloadController.carNumberController.clear();
                          addPayloadController.notesController.clear();
                        },
                        icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                    ),
                    title: Text(
                      "${getLang(context, "Add_pay")}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'din_next_arabic_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                      textAlign: TextAlign.start,
                    ),
                    backgroundColor: MyColors.DarkWHITE,
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Column(
                        children: [
                          CarRow(),
                          const SizedBox(height: 10,),
                          DriverClientRow(context),
                          const SizedBox(height: 10,),
                          addPayloadController.role=="admin"?
                          DelegateRow(context):Container(),
                          const SizedBox(height: 10,),
                          locationRow(),
                          const SizedBox(height: 10,),
                          branchesRow(),
                          const SizedBox(height: 10,),
                          carOwner(),
                          const SizedBox(height: 10,),
                          uploadingTimeRow(),
                          const SizedBox(height: 10,),
                          LanchAccessTimeRow(),
                          const SizedBox(height: 10,),
                          SaleBuyPriceRow(),
                          const SizedBox(height: 10,),
                          statementRow(),
                          const SizedBox(height: 10,),
                          LinkRow(),
                          const SizedBox(height: 10,),
                          LinkRowTo(),
                          const SizedBox(height: 10,),
                          paymentRow(),
                          const SizedBox(height: 10,),
                          CarNumberRow(),
                          const SizedBox(height: 10,),
                          NotsRow(),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 93,
                    child: Column(
                      children: [
                        Obx(() =>
                            Visibility(
                                visible: addPayloadController.isVisable
                                    .value,
                                child: Loader()
                            )),
                        //SizedBox(height: 8,),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 8,right: 8),
                            width: MediaQuery.of(context).size.width,
                            height: 53,
                            child: TextButton(
                              style: flatButtonStyle ,
                              onPressed: (){
                                if(fromWhere=="edite"){
                                  ValidationUpdate(context);
                                }else{
                                  ValidationAndApisCall(context);
                                }
                                //Navigator.pushNamed(context, '/home_screen');
                              },
                              child: Text("${getLang(context, "save")}",
                                style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          )
              :shimmer()
          );
        } else {
          return  Scaffold(body: NoIntrnet());
        }
      },
      child: const Center(
        child: CircularProgressIndicator(
          color: MyColors.MAINCOLORS,
        ),
      ),
    );
  }


  ValidationAndApisCall(BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      addPayloadController.DriverId=prefs.getInt("driverId");
      addPayloadController.UserId=prefs.getInt("userId");
    });
    if (addPayloadController.dropdownValue == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_carType')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.dropdownValue2 == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_carLength')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.launch_area == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_launchArea')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.access_area == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_arriveArea')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.choose_branches == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_branch')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.chooseCarOwner == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'add_car_owner')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    // else if (addPayloadController.DriverId == null) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_choose_driver')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    else if (addPayloadController.UserId == null ) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_user')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.upT == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_uploadTime')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.strT == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_startTime')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.accT == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_accessTime')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    // else if (addPayloadController.buyPriceController.text == null||
    //     addPayloadController.buyPriceController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_sellingPrice')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.purchasingPriceController.text == null||
    //     addPayloadController.purchasingPriceController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_purchasePrice')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    else if (addPayloadController.GraduationController.text == null||
        addPayloadController.GraduationController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_enter_gradu')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    // else if (addPayloadController.advanceController.text == null||
    //     addPayloadController.advanceController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_advance')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.carNumberController.text == null||
    //     addPayloadController.carNumberController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_carNumber')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.notesController.text == null||
    //     addPayloadController.notesController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'Enter_note_title')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    else {
      addPayloadController.isVisable.value = true;
      //controller.updateToken();
        addPayloadController.AddPayLoad(date.name.toString(),context);
    }
  }

  ValidationUpdate(BuildContext context) async{
    print("lop"+addPayloadController.DriverId.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      addPayloadController.DriverId=prefs.getInt("driverId")??widget.shipmentCategoryList!.driverId;
      addPayloadController.UserId=prefs.getInt("userId")??widget.shipmentCategoryList!.userId;
    });
    if (addPayloadController.dropdownValue == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_carType')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.dropdownValue2 == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_carLength')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.launch_area == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_launchArea')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.access_area == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_arriveArea')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.choose_branches == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_branch')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.chooseCarOwner == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'add_car_owner')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.DriverId == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_driver')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.DelegateId == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_delegate')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.UserId == null ) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_user')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.upT == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_uploadTime')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.strT == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_startTime')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addPayloadController.accT == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_choose_accessTime')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    // else if (addPayloadController.buyPriceController.text == null||
    //     addPayloadController.buyPriceController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_sellingPrice')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.purchasingPriceController.text == null||
    //     addPayloadController.purchasingPriceController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_purchasePrice')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.GraduationController.text == null||
    //     addPayloadController.GraduationController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_gradu')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.advanceController.text == null||
    //     addPayloadController.advanceController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_advance')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.carNumberController.text == null||
    //     addPayloadController.carNumberController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'please_enter_carNumber')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    // else if (addPayloadController.notesController.text == null||
    //     addPayloadController.notesController.text.isEmpty) {
    //   ScaffoldMessenger.of(context!).showSnackBar(
    //     SnackBar(
    //       content: Text("${getLang(context!, 'Enter_note_title')}"),
    //       duration: Duration(seconds: 1),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    else {
      addPayloadController.isVisable.value = true;
      //controller.updateToken();
        addPayloadController.updateOrder(date.name.toString(),context,widget.shipmentCategoryList!.id!);
    }
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

  Widget CarRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: DropdownSearch<dynamic>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (ctx, item, isSelected) {
                    return Container(
                      height: 40,
                      child: Text(
                        item.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    );
                  },
                ),
                items: addPayloadController.carType2.value,
              dropdownDecoratorProps:  DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: widget.shipmentCategoryList?.carTypeName!=null &&fromWhere=="edite"? widget.shipmentCategoryList!.carTypeName:"Select car",
                  hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.Dark5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
                onChanged: (dynamic? newValue) {
                  setState(() {
                    addPayloadController.car = newValue;
                  });
                  addPayloadController.dropdownValue = newValue!.id!;
                },
                filterFn: (item, query) {
                  return item.name.toLowerCase().contains(query.toLowerCase());
                },
                itemAsString: (dynamic item) {
                  TypeCar typeCar = item as TypeCar;
                  return typeCar!.name!;
                },
                //selectedItem: addPayloadController.car!.name.toString()),
            )
          ),
          SizedBox(width: 5,),
          Expanded(
            child: DropdownSearch<dynamic>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (ctx, item, isSelected) {
                    return Container(
                      height: 40,
                      child: Text(
                        item.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    );
                  },
                ),
                items: addPayloadController.carLength.value,
                dropdownDecoratorProps:  DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: widget.shipmentCategoryList?.carLengthName!=null &&fromWhere=="edite"? widget.shipmentCategoryList!.carLengthName:"Select Car Length",
                    hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.Dark5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                onChanged: (dynamic? newValue) {
                  setState(() {
                    addPayloadController.carLeng = newValue;
                  });
                  addPayloadController.dropdownValue2 = newValue!.id!;
                },
                filterFn: (item, query) {
                  return item.name.toLowerCase().contains(query.toLowerCase());
                },
                itemAsString: (dynamic item) {
                  CarLength carLength = item as CarLength;
                  return carLength!.name!;
                },
            )
                //selectedItem: addPayloadController.carLeng!.name),
          ),
        ],
      ),
    );
  }

  Widget DriverClientRow(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                //Get.toNamed('/choose_driver_screen');
                Navigator.pushNamed(context, '/choose_driver_screen');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 53,
                padding: EdgeInsets.only(left: 8,right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    //color: MyColors.Dark6,
                    border: Border.all(width: 1,color: MyColors.Dark5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(addPayloadController.DriverName==null?
                      widget.shipmentCategoryList?.driverName!=null&&fromWhere=="edite"?addPayloadController.DriverName! :
                      "${getLang(context, "choose_driver")}":addPayloadController.DriverName.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'din_next_arabic_regulare',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark2),
                        textAlign: TextAlign.start,maxLines: 2,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/choose_client_screen');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 53,
                padding: EdgeInsets.only(left: 8,right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    //color: MyColors.Dark6,
                    border: Border.all(width: 1,color: MyColors.Dark5)
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      child: Text(addPayloadController.ClientName==null?
                      widget.shipmentCategoryList?.userName!=null&&fromWhere=="edite"?addPayloadController.ClientName! :
                      "${getLang(context, "choose_client")}":addPayloadController.ClientName.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'din_next_arabic_regulare',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark2),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget DelegateRow(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                //Get.toNamed('/choose_driver_screen');
                Navigator.pushNamed(context, '/choose_delegate_sscreen');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 53,
                padding: EdgeInsets.only(left: 8,right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    //color: MyColors.Dark6,
                    border: Border.all(width: 1,color: MyColors.Dark5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(addPayloadController.DelegateName==null?
                    widget.shipmentCategoryList?.delegateName!=null&&fromWhere=="edite"?addPayloadController.DelegateName! :
                    "${getLang(context, "Choose_delegate")}":addPayloadController.DelegateName.toString(),
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'din_next_arabic_regulare',
                          fontWeight: FontWeight.w400,
                          color: MyColors.Dark2),
                      textAlign: TextAlign.start,
                    ),
                    Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget locationRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          /*Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1,color: MyColors.Dark5)
              ),
              child: Center(
                child:
                Obx(() => DropdownButton<dynamic>(
                  isExpanded: true,
                  icon:Image(image: AssetImage('assets/arrow-down- outline.png')) ,
                  underline:Container(),
                  alignment: Alignment.center,
                  value: addPayloadController.city,
                  items: addPayloadController.cities.value.map<DropdownMenuItem<City>>((dynamic value) {
                    return DropdownMenuItem<City>(
                      value: value,
                      child: Text(
                        value.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (dynamic? newValue) {
                    setState(() {
                      addPayloadController.city=newValue;
                    });
                    addPayloadController.launch_area = newValue!.id!;
                  },
                ),)
              ),
            ),
          ),*/
          Expanded(
            child: DropdownSearch<dynamic>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (ctx, item, isSelected) {
                    return Container(
                      height: 40,
                      child: Text(
                        item.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    );
                  },
                ),
                items: addPayloadController.cities.value,
                dropdownDecoratorProps:  DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: widget.shipmentCategoryList?.startAreaName!=null &&fromWhere=="edite"? widget.shipmentCategoryList!.startAreaName:"Select City",
                    hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.Dark5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                onChanged: (dynamic? newValue) {
                  setState(() {
                    addPayloadController.city = newValue;
                  });
                  addPayloadController.launch_area = newValue!.id!;
                },
                filterFn: (item, query) {
                  return item.name.toLowerCase().contains(query.toLowerCase());
                },
                itemAsString: (dynamic item) {
                  City city = item as City;
                  return city!.name!;
                },
                //selectedItem: addPayloadController.city!.name),
            )
          ),
          SizedBox(width: 5,),
          Expanded(
            child: DropdownSearch<dynamic>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (ctx, item, isSelected) {
                    return Container(
                      height: 40,
                      child: Text(
                        item.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    );
                  },
                ),
                items: addPayloadController.cities.value,
                dropdownDecoratorProps:  DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: widget.shipmentCategoryList?.reachAreaName!=null &&fromWhere=="edite"? widget.shipmentCategoryList!.reachAreaName:"Select City",
                    hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.Dark5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                onChanged: (dynamic? newValue) {
                  setState(() {
                    addPayloadController.cityArrived = newValue;
                  });
                  addPayloadController.access_area = newValue!.id!;
                },
                filterFn: (item, query) {
                  return item.name.toLowerCase().contains(query.toLowerCase());
                },
                itemAsString: (dynamic item) {
                  City city = item as City;
                  return city!.name!;
                },
                //selectedItem: addPayloadController.cityArrived!.name
            ),
          ),
          /*Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1,color: MyColors.Dark5)
              ),
              child: Center(
                child: Obx(() => DropdownButton<dynamic>(
                  isExpanded: true,
                  icon:Image(image: AssetImage('assets/arrow-down- outline.png')) ,
                  underline:Container(),
                  alignment: Alignment.center,
                  value: addPayloadController.cityArrived,
                  items: addPayloadController.cities.value.map<DropdownMenuItem<City>>((dynamic value) {
                    return DropdownMenuItem<City>(
                      value: value,
                      child: Text(
                        value.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (dynamic? newValue) {
                    setState(() {
                      addPayloadController.cityArrived=newValue;
                    });
                    addPayloadController.access_area = newValue!.id!;
                  },
                ),)
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget branchesRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
          child: Center(
              child:  Obx(() => DropdownSearch<dynamic>(
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    itemBuilder: (ctx, item, isSelected) {
                      return Container(
                        height: 40,
                        child: Text(
                          item.name??"",
                          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,),
                      );
                    },
                  ),
                  items: addPayloadController.branches.value,
                  dropdownDecoratorProps:  DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: widget.shipmentCategoryList?.branchName!=null &&fromWhere=="edite"? widget.shipmentCategoryList!.branchName: "Select Branch",
                      hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.Dark5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                  onChanged: (dynamic? newValue) {
                    setState(() {
                      addPayloadController.defultBranch = newValue;
                    });
                    addPayloadController.choose_branches = newValue!.id!;
                  },
                  filterFn: (item, query) {
                    return item.name.toLowerCase().contains(query.toLowerCase());
                  },
                  itemAsString: (dynamic item) {
                    brunch branch = item as brunch;
                    return branch!.name!;
                  },
                  //selectedItem: addPayloadController.defultBranch!.name
              ),
              )
          )

          /*Container(
            width: MediaQuery.of(context).size.width,
            height: 53,
            padding: EdgeInsets.only(left: 8,right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                //color: MyColors.Dark6,
                border: Border.all(width: 1,color: MyColors.Dark5)
            ),
            child: Center(
              child:  Obx(() => DropdownButton<dynamic>(
                isExpanded: true,
                icon:Image(image: AssetImage('assets/arrow-down- outline.png')) ,
                underline:Container(),
                alignment: Alignment.center,
                value: addPayloadController.defultBranch,
                items: addPayloadController.branches.value.map<DropdownMenuItem<brunch>>((dynamic value) {
                  return DropdownMenuItem<brunch>(
                    value: value,
                    child: Text(
                      value.name??"",
                      style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (dynamic? newValue) {
                  setState(() {
                    addPayloadController.defultBranch=newValue;
                  });
                  addPayloadController.choose_branches = newValue!.id!;
                },
              ),)
            ),
          ),*/
    );
  }

  Widget carOwner(){
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: Center(
            child:  Obx(() => DropdownSearch<dynamic>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (ctx, item, isSelected) {
                  return SizedBox(
                    height: 40,
                    child: Text(
                      item.name??"",
                      style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,),
                  );
                },
              ),
              items: addPayloadController.carOwnerList.value,
              dropdownDecoratorProps:  DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: widget.shipmentCategoryList?.carOwnerName!=null &&fromWhere=="edite"? widget.shipmentCategoryList!.carOwnerName.toString(): "Select Car Owner",
                  hintStyle: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.Dark5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              onChanged: (dynamic? newValue) {
                setState(() {
                  addPayloadController.defultCarOwner = newValue;
                });
                addPayloadController.chooseCarOwner = newValue!.id!;
              },
              filterFn: (item, query) {
                return item.name.toLowerCase().contains(query.toLowerCase());
              },
              itemAsString: (dynamic item) {
                CarOwner carOwner = item as CarOwner;
                return carOwner!.name!;
              },
              //selectedItem: addPayloadController.defultBranch!.name
            ),
            )
        )

      /*Container(
            width: MediaQuery.of(context).size.width,
            height: 53,
            padding: EdgeInsets.only(left: 8,right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                //color: MyColors.Dark6,
                border: Border.all(width: 1,color: MyColors.Dark5)
            ),
            child: Center(
              child:  Obx(() => DropdownButton<dynamic>(
                isExpanded: true,
                icon:Image(image: AssetImage('assets/arrow-down- outline.png')) ,
                underline:Container(),
                alignment: Alignment.center,
                value: addPayloadController.defultBranch,
                items: addPayloadController.branches.value.map<DropdownMenuItem<brunch>>((dynamic value) {
                  return DropdownMenuItem<brunch>(
                    value: value,
                    child: Text(
                      value.name??"",
                      style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (dynamic? newValue) {
                  setState(() {
                    addPayloadController.defultBranch=newValue;
                  });
                  addPayloadController.choose_branches = newValue!.id!;
                },
              ),)
            ),
          ),*/
    );
  }

  Widget uploadingTimeRow(){
    return GestureDetector(
      onTap: (){
        PickUpdoadTime2(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 53,
          padding: EdgeInsets.only(left: 8,right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              //color: MyColors.Dark6,
              border: Border.all(width: 1,color: MyColors.Dark5)
          ),
          child: Row(
            children: [
              SvgPicture.asset('assets/calendar.svg',color: MyColors.MAINCOLORS),
              SizedBox(width: 10,),
              Text(addPayloadController.upT!=null?addPayloadController.upT:
                "${getLang(context, 'load_time')}",
                style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget LanchAccessTimeRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                //PickStartTime();
                PickStartTime2(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 53,
                padding: EdgeInsets.only(left: 8,right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    //color: MyColors.Dark6,
                    border: Border.all(width: 1,color: MyColors.Dark5)
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/calendar.svg',color: MyColors.MAINCOLORS,),
                    SizedBox(width: 10,),
                    SizedBox(
                      width: 100,
                      child: Text(
                        addPayloadController.strT ?? "${getLang(context, "starting_time")}",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'din_next_arabic_regulare',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark2),
                          textAlign: TextAlign.start,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: GestureDetector(
              onTap: (){
                //PickArrivedTime(context);
                PickArrivedTime2(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 53,
                padding: EdgeInsets.only(left: 8,right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    //color: MyColors.Dark6,
                    border: Border.all(width: 1,color: MyColors.Dark5)
                ),
                child:Row(
                  children: [
                    SvgPicture.asset('assets/calendar.svg',color: MyColors.MAINCOLORS),
                    SizedBox(width: 5,),
                    SizedBox(
                      width: 100,
                      child: Text(addPayloadController.accT ?? "${getLang(context, "Access_time")}",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'din_next_arabic_regulare',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark2),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SaleBuyPriceRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.buyPriceController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "selling_price")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                keyboardType: const TextInputType.numberWithOptions(signed: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.purchasingPriceController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "Purchasing_price")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                keyboardType: const TextInputType.numberWithOptions(signed: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statementRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.GraduationController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "Graduation_statement")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.advanceController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "advance")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                keyboardType: const TextInputType.numberWithOptions(signed: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget LinkRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.fromLinkController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "Download_from")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                //keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget LinkRowTo(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.ToLinkController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "Download_to")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                //keyboardType: const TextInputType.numberWithOptions(signed: true),
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget paymentRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 24,
              child: Text(
                "${getLang(context, "payment_method")}",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'din_next_arabic_medium',
                    fontWeight: FontWeight.w500,
                    color: MyColors.Dark1),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            child: RadioListTile(
              activeColor: MyColors.MAINCOLORS,
              contentPadding: EdgeInsets.all(0),
              title: Text("${getLang(context, "cash")}",
                  style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400)),
              value: dateGroup.cash,
              groupValue: date,
              onChanged: (dateGroup? val){
                setState(() {
                  date = val!;
                });
              },
            ),
          ),
          Expanded(
            child: RadioListTile(
              activeColor: MyColors.MAINCOLORS,
              contentPadding: EdgeInsets.all(0),
              title: Text("${getLang(context, "late")}",
                  style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400)),
              value: dateGroup.delay,
              groupValue: date,
              onChanged: (dateGroup? val){
                setState(() {
                  date = val!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget CarNumberRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.carNumberController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "car_number")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                // keyboardType: const TextInputType.numberWithOptions(signed: true),
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget NotsRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 74,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 74,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: addPayloadController.notesController,
                maxLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "notes")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                //keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> PickUpdoadTime2(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.MAINCOLORS, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: MyColors.MAINCOLORS, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: MyColors.MAINCOLORS, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: MyColors.MAINCOLORS, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          final dateFormat = DateFormat('yyyy-MM-dd');
          final formattedDate = dateFormat.format(selectedDateTime!);

          final timeFormat = DateFormat('HH:mm');
          final formattedTime = timeFormat.format(selectedDateTime!);

          final dateTimeString = '$formattedDate $formattedTime';
          addPayloadController.upT = dateTimeString;
          print(dateTimeString);
        });
      }
    }
  }

  Future<void> PickStartTime2(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime3 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.MAINCOLORS, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: MyColors.MAINCOLORS, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: MyColors.MAINCOLORS, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: MyColors.MAINCOLORS, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime3 = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          final dateFormat = DateFormat('yyyy-MM-dd');
          final formattedDate = dateFormat.format(selectedDateTime3!);

          final timeFormat = DateFormat('HH:mm');
          final formattedTime = timeFormat.format(selectedDateTime3!);

          final dateTimeString = '$formattedDate $formattedTime';
          addPayloadController.strT = dateTimeString;
          print(dateTimeString);
        });
      }
    }
  }

  Future<void> PickArrivedTime2(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime2 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.MAINCOLORS, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: MyColors.MAINCOLORS, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: MyColors.MAINCOLORS, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: MyColors.MAINCOLORS, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime2 = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          final dateFormat = DateFormat('yyyy-MM-dd');
          final formattedDate = dateFormat.format(selectedDateTime2!);

          final timeFormat = DateFormat('HH:mm');
          final formattedTime = timeFormat.format(selectedDateTime2!);

          final dateTimeString = '$formattedDate $formattedTime';
          addPayloadController.accT = dateTimeString;
          print(dateTimeString);
        });
      }
    }
  }

}

