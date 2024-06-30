import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../business/categoryDetailsController/CategoryDetailsController.dart';
import '../../../conustant/AppLocale.dart';
import '../../../conustant/my_colors.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dialogs/add_notes/add_notes_screen.dart';
import '../filters/filter_change_shipment_status/filter_change_shipment_status_screen.dart';
import '../shipment_categories_details/shipment_category_details_screen.dart';

class ShipmentDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ShipmentDetailsScreen();
  }
}

class _ShipmentDetailsScreen extends State<ShipmentDetailsScreen>with TickerProviderStateMixin{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final shipmentDetailsController=Get.put(CategoryDetailsController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    shipmentDetailsController.getCategoryDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return Directionality(
                    textDirection: shipmentDetailsController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child:Obx(() =>! shipmentDetailsController.isLoading.value? Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize:20,
                          onPressed: ()async{
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            var title=await prefs.getString("tittle");
                            var Homestate= prefs.getString("HomeStatus")!;
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) {
                            //       return ShipmentCategoryDetailsScreen(appbarTitle: title!,state: Homestate);
                            //     }));
                            //Navigator.pop(context);
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                      ),
                      title: Text(
                        "${getLang(context, "shipment_details")}",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'din_next_arabic_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                        textAlign: TextAlign.start,
                      ),
                      backgroundColor: MyColors.DarkWHITE,
                    ),
                    body: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.white,
                      backgroundColor: MyColors.MAINCOLORS,
                      strokeWidth: 4.0,
                      onRefresh: () async {
                        return shipmentDetailsController.getCategoryDetails();
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 15,right: 15,top: 20),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "shipment_details")}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'din_next_arabic_medium',
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data?.id.toString()??"",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark2),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              ////////////date////////////
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "date")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.createdAt!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////carNumber////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "car_number")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.carNumber??"",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////cartype////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "car_type")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.carTypeName!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////carLength////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "car_length")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.carLengthName!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////driverName////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "driver_name")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.driverName??"",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////driverphone////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          //width: 227,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getLang(context, "driver_phone_number")}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'din_next_arabic_regulare',
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.Dark3),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                shipmentDetailsController.categoryDetailsResponse.value.data!.driverMobile??"",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'din_next_arabic_regulare',
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.Dark1),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 15,),
                                        Container(
                                          //width: 100,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    whatsapp(shipmentDetailsController.categoryDetailsResponse.value.data!.driverMobile.toString());
                                                  },
                                                  icon: SvgPicture.asset('assets/whats.svg')),
                                              IconButton(
                                                  onPressed: () async {
                                                    var phone=shipmentDetailsController.categoryDetailsResponse.value.data!.driverMobile.toString();
                                                    _makePhoneCall('tel:$phone');
                                                  },
                                                  icon: SvgPicture.asset('assets/phone.svg'))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],
                                ),
                              ),

                              ////////////OwnerName////////////
                              SizedBox(height: 10,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "car_owner_name")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.carOwnerName??"",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////Ownerphone////////////
                              const SizedBox(height: 10,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          //width: 227,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getLang(context, "car_owner_phone")}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'din_next_arabic_regulare',
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.Dark3),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                shipmentDetailsController.categoryDetailsResponse.value.data!.carOwnerMobile??"",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'din_next_arabic_regulare',
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.Dark1),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 15,),
                                        SizedBox(
                                          //width: 100,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    whatsapp(shipmentDetailsController.categoryDetailsResponse.value.data!.carOwnerMobile.toString()??"");
                                                  },
                                                  icon: SvgPicture.asset('assets/whats.svg')),
                                              IconButton(
                                                  onPressed: () async {
                                                    var phone=shipmentDetailsController.categoryDetailsResponse.value.data!.carOwnerMobile.toString()??"";
                                                    _makePhoneCall('tel:$phone');
                                                  },
                                                  icon: SvgPicture.asset('assets/phone.svg'))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],
                                ),
                              ),

                              ////////////clientName////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                          "${getLang(context, "client_name")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                    Text(
                                      shipmentDetailsController.categoryDetailsResponse.value.data!.userName??"",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark1),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////delegateName////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "delegate_name")}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark3),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      shipmentDetailsController.categoryDetailsResponse.value.data!.delegateName??"",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark1),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////delegateNumber////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "delegate_number")}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark3),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      shipmentDetailsController.categoryDetailsResponse.value.data!.delegateMobile??"",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark1),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),

                              ////////////clientphone////////////
                              const SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          //width: 227,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getLang(context, "client_phone_number")}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'din_next_arabic_regulare',
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.Dark3),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                shipmentDetailsController.categoryDetailsResponse.value.data!.userMobile??"",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'din_next_arabic_regulare',
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.Dark1),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 15,),
                                        Container(
                                          //width: 100,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    whatsappClient();
                                                  },
                                                  icon: SvgPicture.asset('assets/whats.svg')),
                                              IconButton(
                                                  onPressed: () async {
                                                    var phone=shipmentDetailsController.categoryDetailsResponse.value.data!.userMobile!;
                                                    _makePhoneCall('tel:$phone');
                                                  },
                                                  icon: SvgPicture.asset('assets/phone.svg'))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],
                                ),
                              ),
                              ////////////status////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "status")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.status!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.SideYELLOW),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////Purchasingprice////////////
                              SizedBox(height: 10,),
                              (shipmentDetailsController.role=="delegate"
                                  ||shipmentDetailsController.role=="admin")?
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "purchasing_price")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.purchasePrice??"",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ):Container(),
                              ////////////selling price////////////
                              SizedBox(height: 10,),
                              (shipmentDetailsController.role=="delegate"
                                  ||shipmentDetailsController.role=="admin")?
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "selling_price")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.salePrice??"",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ):Container(),
                              ////////////Graduation_statement////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "Graduation_statement")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.graduationStatement??"",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////advance////////////
                              SizedBox(height: 10,),
                              (shipmentDetailsController.role=="delegate"
                                  ||shipmentDetailsController.role=="admin")?
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "advance")}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.loan??"",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ):Container(),
                              ////////////payment_method////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "payment_method")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.paymentMethod!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////staging_area////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "staging_area")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.startAreaName!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////access_area////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "access_area")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.reachAreaName!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////load time////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "load_time")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.loadTime!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////start time////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "starting_time")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.startTime!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////Access time////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "Access_time")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.endTime!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////difference_date time////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ////////////////////
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${getLang(context, "expected_time")}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark3),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          shipmentDetailsController.categoryDetailsResponse.value.data!.differenceDate!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////fromLink////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "Download_from")}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark3),
                                      textAlign: TextAlign.start,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        launchURL(shipmentDetailsController.categoryDetailsResponse.value.data!.shippingLocation!);
                                      },
                                      child: Text(
                                        shipmentDetailsController.categoryDetailsResponse.value.data!.shippingLocation??"",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'din_next_arabic_regulare',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////ToLink////////////
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "Download_to")}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark3),
                                      textAlign: TextAlign.start,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        launchURL(shipmentDetailsController.categoryDetailsResponse.value.data!.arrivalLocation!);
                                      },
                                      child: Text(
                                        shipmentDetailsController.categoryDetailsResponse.value.data!.arrivalLocation??"",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'din_next_arabic_regulare',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ),
                              ////////////bond_sent_image////////////
                              SizedBox(height: 10,),
                              shipmentDetailsController.categoryDetailsResponse.value.data!.bondSentImage!=null?Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "bond_sent_image")}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark3),
                                      textAlign: TextAlign.start,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                              opaque: false,
                                              barrierDismissible: true,
                                              pageBuilder:  (BuildContext context,_,__){
                                                return Scaffold(appBar: AppBar(
                                                    leading: IconButton(
                                                        iconSize:20,
                                                        onPressed: (){
                                                          Navigator.pop(context);
                                                        },
                                                        icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                                                    ),
                                                    backgroundColor: MyColors.DarkWHITE),
                                                    body: Center(child: Hero(tag: "Zoom", child: Image(image: NetworkImage(shipmentDetailsController.categoryDetailsResponse.value.data!.bondSentImage!),))));
                                              },));
                                      },
                                      child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration:  BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: MyColors.Dark5,
                                              image:  DecorationImage(
                                                  image: NetworkImage(shipmentDetailsController.categoryDetailsResponse.value.data!.bondSentImage!)
                                                  ,fit: BoxFit.fill),
                                              border: Border.all(
                                                  width: 1,
                                                  color: MyColors.Dark3
                                              )
                                          ))
                                    ),
                                    const SizedBox(height: 10,),
                                    SvgPicture.asset('assets/separator1.svg'),
                                  ],

                                ),
                              ):Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottomNavigationBar:
                    ((shipmentDetailsController.role=="delegate"
                        ||shipmentDetailsController.role=="admin"
                        ||shipmentDetailsController.role=="driver")
                        &&shipmentDetailsController.categoryDetailsResponse.value.data?.status!="cancelled")?
                    Container(
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 106,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 21,
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showModalBottomSheet<void>(
                                        transitionAnimationController: AnimationController(vsync: this,duration: const Duration(milliseconds:500)),
                                        isScrollControlled: true,
                                        context: context,
                                        backgroundColor:MyColors.DarkWHITE,
                                        builder: (BuildContext context)=> Padding(
                                            padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                            child: AddNotesScreen(orderId:shipmentDetailsController.categoryDetailsResponse.value.data!.id!)
                                        )
                                    );
                                  },
                                  child: Container(
                                    width: 101,
                                    height: 21,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/add_circle.svg'),
                                        Text(
                                          "${getLang(context, 'Add_note')}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Secondry_Color),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/notes_screen',arguments: shipmentDetailsController.categoryDetailsResponse.value.data!.id!);
                                  },
                                  child: Text(
                                    "${getLang(context, 'view_notes')}",
                                    style: const TextStyle(
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
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 8,right: 8),
                              width: MediaQuery.of(context).size.width,
                              height: 53,
                              child: TextButton(
                                style: flatButtonStyle ,
                                onPressed: (){
                                  if (shipmentDetailsController
                                                    .categoryDetailsResponse
                                                    .value
                                                    .data
                                                    ?.driverName !=
                                                null &&
                                            shipmentDetailsController
                                                    .categoryDetailsResponse
                                                    .value
                                                    .data
                                                    ?.driverId !=
                                                null &&
                                            shipmentDetailsController
                                                    .categoryDetailsResponse
                                                    .value
                                                    .data
                                                    ?.graduationStatement !=
                                                null &&
                                            shipmentDetailsController
                                                    .categoryDetailsResponse
                                                    .value
                                                    .data
                                                    ?.purchasePrice !=
                                                null &&
                                            shipmentDetailsController
                                                    .categoryDetailsResponse
                                                    .value
                                                    .data
                                                    ?.salePrice !=
                                                null &&
                                            shipmentDetailsController
                                                    .categoryDetailsResponse
                                                    .value
                                                    .data
                                                    ?.carNumber !=
                                                null &&
                                            shipmentDetailsController
                                                    .categoryDetailsResponse
                                                    .value
                                                    .data
                                                    ?.delegateName !=
                                                null) {
                                          showModalBottomSheet<void>(
                                              transitionAnimationController:
                                                  AnimationController(
                                                      vsync: this,
                                                      duration:
                                                          Duration(seconds: 1)),
                                              isScrollControlled: true,
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),
                                              ),
                                              //backgroundColor:MyColors.DarkWHITE,
                                              builder: (BuildContext context) =>
                                                  DraggableScrollableSheet(
                                                      expand: false,
                                                      initialChildSize: 0.9,
                                                      minChildSize: 0.32,
                                                      maxChildSize: 0.9,
                                                      builder: (BuildContext
                                                                  context,
                                                              ScrollController
                                                                  scrollController) =>
                                                          SingleChildScrollView(
                                                            controller:
                                                                scrollController,
                                                            child: FilterChangeShipmentStatusScreen(
                                                                id: shipmentDetailsController
                                                                    .id!,
                                                                status: shipmentDetailsController
                                                                    .categoryDetailsResponse
                                                                    .value
                                                                    .data!
                                                                    .status!),
                                                          )
                                                      //return FilterOrdersScreen();
                                                      ));
                                        }else{
                                    ScaffoldMessenger.of(context!).showSnackBar(
                                      SnackBar(
                                        content: Text("${getLang(context!, 'please_complete_data')}"),
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                      },
                                child: Text("${getLang(context, "Change_shipment_status")}",
                                  style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ):
                    Container(
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 21,
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showModalBottomSheet<void>(
                                        transitionAnimationController: AnimationController(vsync: this,duration: const Duration(milliseconds:500)),
                                        isScrollControlled: true,
                                        context: context,
                                        backgroundColor:MyColors.DarkWHITE,
                                        builder: (BuildContext context)=> Padding(
                                            padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                            child: AddNotesScreen(orderId: shipmentDetailsController.categoryDetailsResponse.value.data!.id!,)
                                        )
                                    );
                                  },
                                  child: Container(
                                    width: 101,
                                    height: 21,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/add_circle.svg'),
                                        Text(
                                          "${getLang(context, 'Add_note')}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.Secondry_Color),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/notes_screen',arguments: shipmentDetailsController.categoryDetailsResponse.value.data!.id!);
                                  },
                                  child: Text(
                                    "${getLang(context, 'view_notes')}",
                                    style: const TextStyle(
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
                        ],
                      ),
                    )
                  ):const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,))),
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

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  whatsapp(String phone2)async{
   // var phone2="+966"+shipmentDetailsController.categoryDetailsResponse.value.data!.driverMobile.toString();
    var iosUrl = "https://wa.me/$phone2";
    var  url='https://api.whatsapp.com/send?phone=$phone2';
    if(Platform.isIOS){
      await launchUrl(Uri.parse(iosUrl));
    }
    else{
      await launch(url);
    }
    // if(await canLaunch(url)){
    //   await launch(url);
    // }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  whatsappClient()async{
    var phone2="+966"+shipmentDetailsController.categoryDetailsResponse.value.data!.userMobile.toString();
    var iosUrl = "https://wa.me/$phone2";
    var  url='https://api.whatsapp.com/send?phone=$phone2';
    if(Platform.isIOS){
      await launchUrl(Uri.parse(iosUrl));
    }
    else{
      await launch(url);
    }
  }


}