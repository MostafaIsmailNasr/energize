import 'dart:developer';
import 'dart:ffi';

import 'package:energize_flutter/data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import 'package:energize_flutter/ui/screens/Add_payload/add_payload_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/chooseDriverController/ChooseDriverController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/addPayloadModel/chooseDriverModel/ChooseDriverResponse.dart';
import '../../../widget_Items_list/ClientAndDriverItem.dart';

class ChooseDriverScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChooseDriverScreen();
  }
}
class _ChooseDriverScreen extends State<ChooseDriverScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  int? selectedFlage;
  final chooseDriverController=Get.put(ChooseDriverController());


  @override
  void initState() {
    chooseDriverController.isLoading.value=true;
    chooseDriverController.page=1;
    chooseDriverController.ChooseDriverList(chooseDriverController.page,"");
    chooseDriverController.scroll.addListener(chooseDriverController.scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return  Directionality(
                  textDirection: chooseDriverController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        iconSize:20,
                        onPressed: (){
                          chooseDriverController.searchController.clear();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                    ),
                    title: Text(
                      "${getLang(context, "drivers")}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'din_next_arabic_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                      textAlign: TextAlign.start,
                    ),
                    backgroundColor: MyColors.DarkWHITE,
                  ),
                  body:Obx(() =>!chooseDriverController.isLoading.value? Container(
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                    child: Column(
                      children: [
                        search(),
                        // Obx(() =>!chooseDriverController.isLoading.value?
                        // Expanded(child: ClientListView()):
                        // const Expanded(child: Center(
                        //     child: CircularProgressIndicator(color: MyColors.MAINCOLORS)))
                        // ),
                        Obx(() => !chooseDriverController.isLoading2.value
                            ? Expanded(child: ClientListView()): chooseDriverController.page==1?
                        const Expanded(
                            child: Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.MAINCOLORS,
                                ))):Expanded(child: ClientListView())
                        ),
                      ],
                    ),
                  ):const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),)),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    alignment: Alignment.bottomCenter,
                    width: 375,
                    height: 93,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 8,right: 8),
                        width: 327,
                        height: 53,
                        child: TextButton(
                          style: flatButtonStyle ,
                          onPressed: (){
                            Validation();
                            //Navigator.pushNamed(context, "/home_screen");
                          },
                          child: Text("${getLang(context, "add_driver")}",
                            style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                        ),
                      ),
                    ),
                  ),
                ),
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

  Validation()async{
    if(chooseDriverController.id!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("driverId", chooseDriverController.id);
      prefs.setString("driverName", chooseDriverController.name);
      Get.back();

      //Get.to(AddPayloadScreen(chooseDriverController.id, 0),);
      //.popAndPushNamed(context,"/add_payload_screen",arguments: chooseDriverController.id);
      //Navigator.pushNamed(context, "/add_payload_screen",arguments: chooseDriverController.id);
    }else{
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_select_only_one_driver')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              controller: chooseDriverController.searchController,
              onChanged: (vale){
                if(vale.isEmpty){
                  chooseDriverController.ChooseDriverList(1,"");
                  selectedFlage = -1;
                }
              },
              onEditingComplete: (){
                chooseDriverController.ChooseDriverList(1,chooseDriverController.searchController.text);
                if(chooseDriverController.searchController.text.isEmpty){
                  chooseDriverController.ChooseDriverList(1,"");
                }
              },
              onFieldSubmitted: (vale){
                chooseDriverController.ChooseDriverList(1,vale);
                if(vale.isEmpty){
                  chooseDriverController.ChooseDriverList(1,"");
                }
              },
              //(query) => _filterItems(query),
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
                hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
              ),
              style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),

            ),
          ),
        ],
      ),
    );
  }


  void _filterItems(String query) {
    //log(query);
    final filter = chooseDriverController.chooseDriverResponse.value.data!
        .where((element){
      final name= element.mobile!.toLowerCase();
      final name2= element.name!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input)||name2.contains(input);
    }).toList();
    setState(() {
      chooseDriverController.DriverList.value=filter;
      selectedFlage=-1;
    });
  }

  Widget ClientListView(){
    if(chooseDriverController.DriverList.isNotEmpty) {
        return  ListView.builder(
          controller: chooseDriverController.scroll,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: chooseDriverController.DriverList.length,
          itemBuilder: (BuildContext context, int index) {
          if(chooseDriverController.DriverList[index].name!="loading") {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedFlage = index;
                  chooseDriverController.id =
                      chooseDriverController.DriverList[index].id;
                  chooseDriverController.name =
                      chooseDriverController.DriverList[index].name;
                  print("driveId" + chooseDriverController.id.toString());
                  print("driveName" + chooseDriverController.name.toString());
                });
              },
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: const EdgeInsetsDirectional.all(10),
                margin: const EdgeInsetsDirectional.only(
                    start: 8, end: 8, top: 8),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: MyColors.Dark5
                      )
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: chooseDriverController.DriverList[index]!.avatar!=null ?
                      BoxDecoration(
                          image: DecorationImage(image: NetworkImage(
                              chooseDriverController.DriverList[index]!
                                  .avatar!), fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(50)) :
                      BoxDecoration(
                          image: const DecorationImage(image: AssetImage(
                              "assets/pic.png")),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chooseDriverController.DriverList[index]!.name!,
                              style: const TextStyle(fontSize: 16,
                                fontFamily: 'din_next_arabic_medium',
                                fontWeight: FontWeight.w500,
                                color: MyColors.Dark1,),
                            ),
                            Text(
                              chooseDriverController.DriverList[index]!.mobile!,
                              style: const TextStyle(fontSize: 14,
                                fontFamily: 'din_next_arabic_regulare',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark2,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: selectedFlage == index ?
                      Center(
                        child: SvgPicture.asset('assets/checked.svg'),
                      ) :
                      const Center(
                        child: Image(image: AssetImage(
                            'assets/Rectangle_6.png')),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else {
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
            SvgPicture.asset('assets/error_img.svg'),
            SizedBox(height: 10,),
            Text("${getLang(context, "There_are_no_drivers")}",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text("${getLang(context, "You_havent_added_any_drivers")}",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}