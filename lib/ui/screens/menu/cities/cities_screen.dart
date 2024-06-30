import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/cityController/CityController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/ToastClass.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget_Items_list/DelegateItem.dart';
import '../../shimer_pages/shimmer.dart';
import '../../update/update_city/update_city_screen.dart';
import 'addCity/add_city_screen.dart';
import 'delete/DeleteScreen.dart';

class CitiesScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CitiesScreen();
  }
}

class _CitiesScreen extends State<CitiesScreen>with TickerProviderStateMixin{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final cityController=Get.put(CityController());

  @override
  void initState() {
    cityController.getCities();
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
              return   Obx(() =>!cityController.isLoading.value? SafeArea(
                  child: Directionality(
                    textDirection: cityController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                    child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize:20,
                            onPressed: (){
                              cityController.searchController.clear();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                        ),
                        title: Text(
                          "${getLang(context, "city")}",
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
                            Expanded(
                                child: CitiesListView()
                            ),
                          ],
                        ),
                      ),
                      bottomNavigationBar:(cityController.role=="delegate"||cityController.role=="admin")?
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
                                showModalBottomSheet<void>(
                                    transitionAnimationController: AnimationController(vsync: this,duration: Duration(milliseconds: 200)),
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor:MyColors.DarkWHITE,
                                    builder: (BuildContext context)=> Padding(
                                        padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: AddCityScreen()
                                    )
                                );
                              },
                              child: Text("${getLang(context, "add_city")}",
                                style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                            ),
                          ),
                        ),
                      )
                          :Container(
                        color: Colors.white,
                        alignment: Alignment.bottomCenter,
                        width: MediaQuery.of(context).size.width,
                        height: 10,),
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
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: MyColors.Dark6,
          border: Border.all(width: 1,color: MyColors.Dark5)
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/search_normal.svg'),
          Container(
            width: 267,
            child: TextFormField(
              controller: cityController.searchController,
              onChanged: (query) => _filterItems(query),
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
                hintText: "${getLang(context, "Search_by_name")}",
                hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
              ),
              style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),

            ),
          ),
        ],
      ),
    );
  }

  void _filterItems(String query) {
    //log(query);
    final filter = cityController.citiesResponse.value.data!
        .where((element){
      final name= element.name!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() {
      cityController.cities.value=filter;
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

  Widget CitiesListView(){
    if( cityController.cities.isNotEmpty) {
      return ListView.builder(
          itemCount:  cityController.cities.length,
          itemBuilder: (context,int index){
            /*return DelegateItem(
                'city',
                "${getLang(context, 'Do_you_want_to_confirm_the_deletion_city')}",
                null,
                null,
                null,
                cityController.cities[index]
            );*/
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 10),
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
                          image: DecorationImage(image: AssetImage('assets/logo2.png',),fit: BoxFit.fill),
                          border: Border.all(
                              width: 1,
                              color: MyColors.Dark3
                          )
                      )
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(cityController.cities[index].name!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'din_next_arabic_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: ()async{
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('cityName', cityController.cities[index].name!);
                                showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor:MyColors.DarkWHITE,
                                    builder: (BuildContext context)=> Padding(
                                        padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: UpdateCityScreen(id: cityController.cities[index].id!,)
                                    )
                                );
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset('assets/edit.svg',)
                              )
                          ),
                        ),
                        (cityController.role=="admin")?
                        Expanded(
                          child: GestureDetector(
                              onTap: (){
                                //_onAlertButtonsPressed(context,des,"city");
                                showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor:MyColors.DarkWHITE,
                                    builder: (BuildContext context)=> Padding(
                                        padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: DeleteScreen(id: cityController.cities[index].id!,)
                                    )
                                );
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset('assets/trash.svg',)
                              )
                          ),
                        ):Container(width: 5,)
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
              Text("${getLang(context, "There_are_no_cities")}",
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