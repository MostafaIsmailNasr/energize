import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/carOwnerController/CarOwnerController.dart';
import '../../../../business/cityController/CityController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/ToastClass.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget_Items_list/DelegateItem.dart';
import '../../shimer_pages/shimmer.dart';
import '../../update/update_car_owner/update_car_owner_screen.dart';
import '../../update/update_city/update_city_screen.dart';
import 'addCarOwner/add_car_owner_screen.dart';

class CarOwnerScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CarOwnerScreen();
  }
}

class _CarOwnerScreen extends State<CarOwnerScreen>with TickerProviderStateMixin{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final carOwnerController=Get.put(CarOwnerController());

  @override
  void initState() {
    carOwnerController.getCarOwnerList("");
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
              return   Obx(() =>!carOwnerController.isLoading.value? SafeArea(
                  child: Directionality(
                    textDirection: carOwnerController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                    child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize:20,
                            onPressed: (){
                              carOwnerController.searchController.clear();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                        ),
                        title: Text(
                          "${getLang(context, "car_owner")}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'din_next_arabic_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1),
                          textAlign: TextAlign.start,
                        ),
                        backgroundColor: MyColors.DarkWHITE,
                      ),
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Column(
                          children: [
                            search(),
                            const SizedBox(height: 5,),
                            Expanded(
                                child: carOwnerListView()
                            ),
                          ],
                        ),
                      ),
                      bottomNavigationBar:
                      Container(
                        color: Colors.white,
                        alignment: Alignment.bottomCenter,
                        width: MediaQuery.of(context).size.width,
                        height: 93,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(left: 8,right: 8),
                            width: MediaQuery.of(context).size.width,
                            height: 53,
                            child: TextButton(
                              style: flatButtonStyle ,
                              onPressed: (){
                                Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => AddCarOwnerScreen(),));
                              },
                              child: Text("${getLang(context, "add_car_owner")}",
                                style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                            ),
                          ),
                        ),
                      )
                    ),
                  )
              )
                  :shimmer());
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

  Widget search(){
    FocusNode textSecondFocusNode = new FocusNode();
    return Container(
      width: 372,
      height: 53,
      padding: const EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: MyColors.Dark6,
          border: Border.all(width: 1,color: MyColors.Dark5)
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/search_normal.svg'),
          SizedBox(
            width: 267,
            child: TextFormField(
              controller: carOwnerController.searchController,
              onChanged: (vale){
                if(vale.isEmpty){
                  carOwnerController.getCarOwnerList("");
                }
              },
              onEditingComplete: (){
                carOwnerController.getCarOwnerList(carOwnerController.searchController.text);
                if(carOwnerController.searchController.text.isEmpty){
                  carOwnerController.getCarOwnerList("");
                }
              },
              onFieldSubmitted: (vale){
                carOwnerController.getCarOwnerList(vale);
                if(vale.isEmpty){
                  carOwnerController.getCarOwnerList("");
                }
              },
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
                hintText: "${getLang(context, "Search_by_name_phone")}",
                hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
              ),
              style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
            ),
          ),
        ],
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

  Widget carOwnerListView(){
    if( carOwnerController.carOwnerList.isNotEmpty) {
      return ListView.builder(
          itemCount:  carOwnerController.carOwnerList.length,
          itemBuilder: (context,int index){
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1,color: MyColors.Dark5)
              ),
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(image: AssetImage('assets/logo2.png',),fit: BoxFit.fill),
                          border: Border.all(
                              width: 1,
                              color: MyColors.Dark3
                          )
                      )
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(carOwnerController.carOwnerList[index].name!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'din_next_arabic_medium',
                                fontWeight: FontWeight.w500,
                                color: MyColors.Dark1),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Text(carOwnerController.carOwnerList[index].phone!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'din_next_arabic_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 56,
                    height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: ()async{
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                //prefs.setString('cityName', cityController.cities[index].name!);
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => UpdateCarOwnerScreen(
                                    id: carOwnerController.carOwnerList[index].id,name: carOwnerController.carOwnerList[index].name,
                                    phone: carOwnerController.carOwnerList[index].phone),));
                              },
                              child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset('assets/edit.svg',)
                              )
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: (){
                                _onAlertButtonsPressed(context,
                                    "${getLang(
                                        context,
                                        'Do_you_want_to_confirm_the_deletion_owner')}",
                                carOwnerController.carOwnerId=carOwnerController.carOwnerList[index].id);
                              },
                              child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset('assets/trash.svg',)
                              )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
      );
    }else{
      return emptyDriver();
    }
  }

  _onAlertButtonsPressed(BuildContext context,String des,int id) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/delete_dialog_img.svg',),
      title: "${getLang(context, 'confirm_deletion')}",
      style: const AlertStyle(
        titleStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: MyColors.Dark1,fontFamily: 'din_next_arabic_bold'),
        descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.Dark2,fontFamily: 'din_next_arabic_regulare'),
      ),
      desc: des,
      buttons: [
        DialogButton(
          height: 53,
          child: Text(
            "${getLang(context, 'delete')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),
          onPressed: () => {
            carOwnerController.deleteCarOwner(context, id)
          },
          color: MyColors.SideRed,
        ),
        DialogButton(
          height: 53,
          onPressed: () => Navigator.pop(context),
          color: MyColors.Secondry_Color,
          child: Text(
            "${getLang(context, 'cancel')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),

        )
      ],
    ).show();
  }
}

class emptyDriver extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 60),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/error_img.svg'),
              SizedBox(height: 10,),
              Text("${getLang(context, "There_are_no_car_owner")}",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Text("${getLang(context, "You_havent_added_any_cities")}",
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}