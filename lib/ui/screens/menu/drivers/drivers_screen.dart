import 'package:energize_flutter/ui/screens/menu/drivers/add_driver/add_driver_screen.dart';
import 'package:energize_flutter/ui/screens/shimer_pages/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/driverController/DriverController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget_Items_list/DelegateItem.dart';
import '../../update/update_driver/update_driver_screen.dart';
import '../cities/delete/DeleteScreen.dart';
import 'delete/DeleteDriverScreen.dart';

class DriverScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DriverScreen();
  }
}

class _DriverScreen extends State<DriverScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final driverController=Get.put(DriverController());

  @override
  void initState() {
    driverController.page=1;
    driverController.getDriverList(driverController.page,"");
    driverController.scroll.addListener(driverController.scrollListener);
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
              return  Obx(() =>!driverController.isLoading.value? SafeArea(
                child: Directionality(
                    textDirection: driverController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize:20,
                          onPressed: (){
                            driverController.searchController.clear();
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
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Column(
                        children: [
                          search(),
                          const SizedBox(height: 5,),
                          // Expanded(
                          //     child: DriverListView()
                          // ),
                          Obx(() => !driverController.isLoading2.value
                              ? Expanded(child: DriverListView()): driverController.page==1?
                          const Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.MAINCOLORS,
                                  ))):Expanded(child: DriverListView())
                          ),
                        ],
                      ),
                    ),
                    bottomNavigationBar:(driverController.role=="delegate"||driverController.role=="admin")?
                    Container(
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 93,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 8,right: 8),
                          width: MediaQuery.of(context).size.width,
                          height: 53,
                          child: TextButton(
                            style: flatButtonStyle ,
                            onPressed: (){
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return AddDriverScreen();
                                  }));
                              //Navigator.pushNamed(context, '/add_driver_screen');
                            },
                            child: Text("${getLang(context, "add_driver")}",
                              style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                          ),
                        ),
                      ),
                    ):
                    Container(
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 10,),
                  ),
                ),
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
              controller: driverController.searchController,
              onChanged: (vale){
                 if(vale.isEmpty){
                  driverController.getDriverList(1,"");
                }
              },//(query) => _filterItems(query),
              onEditingComplete: (){
                  driverController.getDriverList(1,driverController.searchController.text);
                 if(driverController.searchController.text.isEmpty){
                  driverController.getDriverList(1,"");
                }
              },
              onFieldSubmitted: (vale){
                driverController.getDriverList(1,vale);
                 if(vale.isEmpty){
                  driverController.getDriverList(1,"");
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
             // keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  void _filterItems(String query) {
    //log(query);
    final filter = driverController.chooseDriverResponse.value.data!
        .where((element){
      final name= element.mobile!.toLowerCase();
      final name2= element.name!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input)||name2.contains(input);
    }).toList();
    setState(() {
      driverController.DriverList.value=filter;
    });
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

  Widget DriverListView(){
    if(driverController.DriverList.isNotEmpty) {
      return ListView.builder(
          controller: driverController.scroll,
          itemCount: driverController.DriverList.length,
          itemBuilder: (context,int index){
        if(driverController.DriverList[index].name!="loading") {
          return Container(
                width: MediaQuery.of(context).size.width,
                height: 87,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: MyColors.Dark5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration:
                          driverController.DriverList![index].avatar!=null
                              ? BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(driverController
                                          .DriverList![index].avatar!),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(50))
                              : BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage("assets/pic.png")),
                                  borderRadius: BorderRadius.circular(50)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: 47,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              driverController.DriverList![index].name!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'din_next_arabic_medium',
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.Dark1),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              driverController.DriverList![index].mobile!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'din_next_arabic_regulare',
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.Dark2),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
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
                                onTap: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setInt('driverId',
                                      driverController.DriverList![index].id!);
                                  prefs.setString(
                                      'driverName',
                                      driverController
                                          .DriverList![index].name!);
                                  prefs.setString(
                                      'driverPhone',
                                      driverController
                                          .DriverList![index].mobile!);
                                  prefs.setString(
                                      'driverLicense',
                                      driverController
                                          .DriverList![index].licenseImg!);
                                  prefs.setString(
                                      'drivercarForm',
                                      driverController
                                          .DriverList![index].carFormImg!);
                                  prefs.setString(
                                      'driverresidence',
                                      driverController
                                          .DriverList![index].residenceImg!);
                                  prefs.setString(
                                      'driverToken',
                                      driverController
                                          .DriverList![index].token!);
                                  prefs.setInt(
                                      'statusFilterDriver',
                                      driverController
                                          .DriverList![index].status!);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateDreiverScreen();
                                  }));
                                  //Navigator.pushNamed(context, '/update_driver_screen');
                                },
                                child: Container(
                                    width: 24,
                                    height: 24,
                                    child: SvgPicture.asset(
                                      'assets/edit.svg',
                                    ))),
                          ),
                          (driverController.role == "admin")
                              ? Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            context: context,
                                            backgroundColor: MyColors.DarkWHITE,
                                            builder: (BuildContext context) =>
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: DeleteDriverScreen(
                                                        id: driverController
                                                            .DriverList[index]
                                                            .id!,
                                                        token: driverController
                                                            .DriverList![index]
                                                            .token!
                                                            .toString())));
                                      },
                                      child: Container(
                                          width: 24,
                                          height: 24,
                                          child: SvgPicture.asset(
                                            'assets/trash.svg',
                                          ))),
                                )
                              : Container(
                                  width: 5,
                                )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(color: MyColors.MAINCOLORS),
              );
            }
          }
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
        child: SingleChildScrollView(
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
      ),
    );
  }

}