import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/homeController/HomeController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../home_filter/choose_branch_filter/choose_branch_filter_screen.dart';
import '../home_filter/choose_client_filter/choose_client_filter_screen.dart';
import '../home_filter/choose_delegate_filter/choose_delegate_filter_screen.dart';
import '../home_filter/choose_driver_filter/choose_driver_filter_screen.dart';

class HomeFilterScreen2 extends StatefulWidget{
  String fromWhere;
  HomeFilterScreen2({required this.fromWhere});

  @override
  State<StatefulWidget> createState() {
    return _HomeFilterScreen2(fromWhere: fromWhere);
  }
}

class _HomeFilterScreen2 extends State<HomeFilterScreen2>{
  String fromWhere;
  _HomeFilterScreen2({required this.fromWhere});
  final homeController=Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return  Padding(
            padding: EdgeInsets.only(right: 15,left: 15,top: 10),
            child: Container(
              //height: 400,
              width: MediaQuery.of(context).size.width,
              child: Directionality(
                textDirection: homeController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomBar(),
                    FilterContainer(context),
                  ],
                ),
              ),
            ),
          );
        } else {
          return   NoIntrnet();
        }
      },
      child: Center(
        child: CircularProgressIndicator(
          color: MyColors.MAINCOLORS,
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

  Widget CustomBar(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 60,
            height: 5,
            color: MyColors.Dark6,),
        ),
        SizedBox(height: 10,),
        Container(
          height: 40,
          child: Stack(
            children: [
              Positioned(
                left: -10,
                child: IconButton(
                    icon: Icon(Icons.close),
                    color: MyColors.Dark3,
                    onPressed:(){
                      Navigator.pop(context);
                    }
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Center(
                  child: Text("${getLang(context, "filter")}",
                    style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.Dark1,),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 2,
            color: MyColors.Dark6,
            margin: EdgeInsets.only(top: 5),),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget FilterContainer(BuildContext context){
    return Column(
      children: [
        DriverClientRow(),
        const SizedBox(height: 8,),
        graduationStatement(),
        const SizedBox(height: 8,),
        CarNum(),
        ButtonSave()
      ],
    );
  }


  Widget DriverClientRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${getLang(context, "Sort_by")}",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'din_next_arabic_medium',
                    fontWeight: FontWeight.w500,
                    color: MyColors.Dark2),
                textAlign: TextAlign.start,
              ),
              SizedBox(width: 5,),
              Text(
                "${getLang(context, "select")}",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'din_next_arabic_regulare',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark3),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FilterHomeDriver();
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
                        Text(
                          "${getLang(context, "choose_driver")}",
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
              SizedBox(width: 10,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    FilterHomeClient();
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
                        Text(
                          "${getLang(context, "choose_client")}",
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
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              FilterHomeDelegate();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),

                  border: Border.all(width: 1,color: MyColors.Dark5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${getLang(context, "Choose_delegate")}",
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
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              FilterHomeBranch();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),

                  border: Border.all(width: 1,color: MyColors.Dark5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${getLang(context, "choose_branch")}",
                    style: const TextStyle(
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
        ],
      ),
    );
  }

  Widget graduationStatement(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      padding: EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: MyColors.Dark6,
          border: Border.all(width: 1, color: MyColors.Dark5)),
      child: TextFormField(
          controller: homeController.GraduationController,
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
          //keyboardType: TextInputType.number,
          //textInputAction: TextInputAction.done,
          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true)
      ),
    );
  }

  Widget CarNum(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: MyColors.Dark6,
          border: Border.all(width: 1, color: MyColors.Dark5)),
      child: TextFormField(
          controller: homeController.CarNumController,
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
          //keyboardType: TextInputType.number,
          //textInputAction: TextInputAction.done,
          //keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true)
      ),
    );
  }

  Widget ButtonSave(){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        backgroundColor: MyColors.MAINCOLORS,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ));
    return Container(
      margin: EdgeInsets.only(top: 10),
      width:MediaQuery.of(context).size.width,
      height: 60,
      child: TextButton(
        style: flatButtonStyle ,
        onPressed: ()async{
          homeController.getHomeFilter(context);
        },
        child: Text("${getLang(context, "apply")}",
          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.DarkWHITE),),
      ),
    );
  }

  FilterHomeDriver(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDriverFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDriverFilterScreen(FromWhere: "HomeScreen")));
    }
  }

  FilterHomeClient(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseClientFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseClientFilterScreen(FromWhere: "HomeScreen")));
    }
  }

  FilterHomeDelegate(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDelegateFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDelegateFilterScreen(FromWhere: "HomeScreen")));
    }
  }

  FilterHomeBranch(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseBranchFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseBranchFilterScreen(FromWhere: "HomeScreen")));
    }
  }
}