import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../business/cityController/CityController.dart';
import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';

class AddCityScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddCityScreen();
  }
}

class _AddCityScreen extends State<AddCityScreen>{
  TextEditingController cityNameController=TextEditingController();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final cityController=Get.put(CityController());

  @override
  void initState() {
    cityController.getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return  SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: MyColors.DarkWHITE,
              margin: const EdgeInsets.only(left: 15,right: 15),
              child: Directionality(
                textDirection: cityController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBar(),
                    content(),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(body: NoIntrnet());
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
            width: 100,
            height: 5,
            margin: EdgeInsets.only(top: 5),
            color: MyColors.Dark5,),
        ),
        const SizedBox(height: 10,),
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
                  child: Text("${getLang(context, "add_city")}",
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
        const SizedBox(height: 10,),
      ],
    );
  }

  Widget content(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${getLang(context, "city_name")}",
            style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1,),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 53,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: MyColors.Dark5)),
            child: TextFormField(
              controller: cityNameController,
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
                hintText: "${getLang(context, "enter_city_name")}",
                hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
              ),
              style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
            ),
          ),
          const SizedBox(height: 20,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: MyColors.Dark6,
              margin: const EdgeInsets.only(top: 5),),
          ),
          const SizedBox(height: 24,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 53,
            child: TextButton(
              style: flatButtonStyle ,
              onPressed: (){
                cityController.createCity(cityNameController.text,context);
              },
              child: Text("${getLang(context, "add")}",
                style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
            ),
          ),
          const SizedBox(height: 24,),
        ],
      ),
    );
  }

}