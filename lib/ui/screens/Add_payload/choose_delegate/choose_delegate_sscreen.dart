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

import '../../../../business/chooseDelegateController/ChooseDelegateController.dart';
import '../../../../business/chooseDriverController/ChooseDriverController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/addPayloadModel/chooseDriverModel/ChooseDriverResponse.dart';
import '../../../widget_Items_list/ClientAndDriverItem.dart';

class ChooseDelegateScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChooseDelegateScreen();
  }
}
class _ChooseDelegateScreen extends State<ChooseDelegateScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  int? selectedFlage;
  final chooseDelegateController=Get.put(ChooseDelegateController());


  @override
  void initState() {
    chooseDelegateController.isLoading.value=true;
    chooseDelegateController.page=1;
    chooseDelegateController.ChooseDelegateList(chooseDelegateController.page,"");
    chooseDelegateController.scroll.addListener(chooseDelegateController.scrollListener);
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
              textDirection: chooseDelegateController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      iconSize:20,
                      onPressed: (){
                        chooseDelegateController.searchController.clear();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                  ),
                  title: Text(
                    "${getLang(context, "delegates")}",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'din_next_arabic_medium',
                        fontWeight: FontWeight.w500,
                        color: MyColors.Dark1),
                    textAlign: TextAlign.start,
                  ),
                  backgroundColor: MyColors.DarkWHITE,
                ),
                body: Obx(() =>!chooseDelegateController.isLoading.value? Container(
                  width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                  child: Column(
                    children: [
                      search(),
                      /*Obx(() =>!chooseDelegateController.isLoading.value?
                      Expanded(child: ClientListView()):
                      Expanded(child: Center(
                          child: CircularProgressIndicator(color: MyColors.MAINCOLORS)),
                      )
                      ),*/
                      Obx(() => !chooseDelegateController.isLoading2.value
                          ? Expanded(child: ClientListView()): chooseDelegateController.page==1?
                      const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                                color: MyColors.MAINCOLORS,
                              ))):Expanded(child: ClientListView())
                      ),
                    ],
                  ),
                ):const Center(
                    child: CircularProgressIndicator(color: MyColors.MAINCOLORS))),
                bottomNavigationBar: Container(
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,
                  width: 375,
                  height: 93,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8,right: 8),
                      width: 327,
                      height: 53,
                      child: TextButton(
                        style: flatButtonStyle ,
                        onPressed: (){
                          Validation();
                          //Navigator.pushNamed(context, "/home_screen");
                        },
                        child: Text("${getLang(context, "add_delegate")}",
                          style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
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
    if(chooseDelegateController.id!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("delegateId", chooseDelegateController.id);
      prefs.setString("delegateName", chooseDelegateController.name);
      Get.back();
      //Get.to(AddPayloadScreen(chooseDriverController.id, 0),);
      //.popAndPushNamed(context,"/add_payload_screen",arguments: chooseDriverController.id);
      //Navigator.pushNamed(context, "/add_payload_screen",arguments: chooseDriverController.id);
    }else{
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_select_only_one_delegate')}"),
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
              controller: chooseDelegateController.searchController,
              onChanged: (vale){
                 if(vale.isEmpty){
                  chooseDelegateController.ChooseDelegateList(1,"");
                  selectedFlage = -1;
                }
              },
              onEditingComplete: (){
                chooseDelegateController.ChooseDelegateList(1,chooseDelegateController.searchController.text);
                if(chooseDelegateController.searchController.text.isEmpty){
                  chooseDelegateController.ChooseDelegateList(1,"");
                }
              },
              onFieldSubmitted: (vale){
                chooseDelegateController.ChooseDelegateList(1,vale);
                if(vale.isEmpty){
                  chooseDelegateController.ChooseDelegateList(1,"");
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
    final filter = chooseDelegateController.chooseDelegateResponse.value.data!
        .where((element){
      final name= element.name!.toLowerCase();
      final name2= element.mobile!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input)||name2.contains(input);
    }).toList();
    setState(() {
      chooseDelegateController.DelegateList.value=filter;
      selectedFlage = -1;
    });
  }

  Widget ClientListView(){
    if(chooseDelegateController.DelegateList.isNotEmpty) {
      return  ListView.builder(
        controller: chooseDelegateController.scroll,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: chooseDelegateController.DelegateList.length,
        itemBuilder: (BuildContext context, int index) {
        if(chooseDelegateController.DelegateList[index].name!="loading") {
          return InkWell(
            onTap: () {
              setState(() {
                selectedFlage = index;
                chooseDelegateController.id =
                    chooseDelegateController.DelegateList[index].id;
                chooseDelegateController.name =
                    chooseDelegateController.DelegateList[index].name;
                print("delegateId" + chooseDelegateController.id.toString());
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
                    decoration: chooseDelegateController.DelegateList[index]!.avatar!=null ?
                    BoxDecoration(
                        image: DecorationImage(image: NetworkImage(
                            chooseDelegateController.DelegateList[index]!
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
                            chooseDelegateController.DelegateList[index]!.name!,
                            style: const TextStyle(fontSize: 16,
                              fontFamily: 'din_next_arabic_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1,),
                          ),
                          Text(chooseDelegateController.DelegateList[index]!
                              .mobile!,
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
                      child: Image(image: AssetImage('assets/Rectangle_6.png')),
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
      return emptyDelegate();
    }
  }
}

class emptyDelegate extends StatelessWidget{
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
            Text("${getLang(context, "There_are_no_delegates")}",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}