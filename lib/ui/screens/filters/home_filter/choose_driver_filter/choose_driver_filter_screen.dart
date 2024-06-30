import 'package:energize_flutter/business/chooseDriverController/ChooseDriverController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';
import '../../../../widget_Items_list/ClientAndDriverItem.dart';

class ChooseDriverFilterScreen extends StatefulWidget{
  String FromWhere;

  ChooseDriverFilterScreen({required this.FromWhere});

  @override
  State<StatefulWidget> createState() {
    return _ChooseDriverFilterScreen(FromWhere: FromWhere);
  }
}

class _ChooseDriverFilterScreen extends State<ChooseDriverFilterScreen>{
  String FromWhere;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  int? selectedFlage;
  var lang="";
  _ChooseDriverFilterScreen({required this.FromWhere});
  final chooseDriverController=Get.put(ChooseDriverController());

  @override
  void initState() {
    chooseDriverController.isLoading.value=true;
    chooseDriverController.page=1;
    chooseDriverController.ChooseDriverList(chooseDriverController.page,"");
    chooseDriverController.scroll.addListener(chooseDriverController.scrollListener);
    // chooseDriverController.ChooseDriverList();
    super.initState();
    getLang2();
  }

  getLang2()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lang= prefs.getString('lang')!;
      print("lang"+lang.toString());
    });
  }

  Validation()async{
    if(chooseDriverController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setInt("driverId", chooseDriverController.filterId);
      prefs.setInt("driverIdFilter", chooseDriverController.filterId);
      prefs.setInt("driverId2", chooseDriverController.filterId);
      LandScapFunc();
      //Get.back();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        LandScapFunc();
        return true;
      },
      child: Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
              child: Directionality(
                textDirection: lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomBar(),
                        search(),
                    Obx(() =>!chooseDriverController.isLoading.value?
                    SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                           child: //ClientListView()
                           Obx(() => !chooseDriverController.isLoading2.value
                               ? ClientListView(): chooseDriverController.page==1?
                           const Center(
                               child: CircularProgressIndicator(
                                 color: MyColors.MAINCOLORS,
                               )):ClientListView()
                           )
                        ):const Center(
                        child: CircularProgressIndicator(color: MyColors.MAINCOLORS))),
                        Container(
                          color: Colors.white,
                          alignment: Alignment.bottomCenter,
                          width: MediaQuery.of(context).size.width,
                          height: 93,
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8,right: 8),
                              width: 327,
                              height: 53,
                              child: TextButton(
                                style: flatButtonStyle ,
                                onPressed: (){
                                  if(FromWhere=="fromCategoriesStatus"){
                                    filterInCategorisStatus();
                                  }else if(FromWhere=="ComprehensiveReportsScreen"){
                                    filterInReports();
                                  }
                                  else{
                                    Validation();
                                  }
                                  //Validation();
                                },
                                child: Text("${getLang(context, "save")}",
                                  style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  filterInCategorisStatus()async{
    if(chooseDriverController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("driverIdCat", chooseDriverController.filterId);
      LandScapFunc();
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

  filterInReports()async{
    if(chooseDriverController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("driverIdReport", chooseDriverController.filterId);
      LandScapFunc();
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
        const SizedBox(height: 10,),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: MyColors.Dark3,
                    onPressed:(){
                      Navigator.pop(context);
                      chooseDriverController.searchController.clear();
                    }
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Center(
                  child: Text("${getLang(context, "choose_driver")}",
                    style: const TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.Dark1,),
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
            margin: const EdgeInsets.only(top: 5),),
        ),
        const SizedBox(height: 10,),
      ],
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

  LandScapFunc(){
    if(FromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
      }
      Navigator.pop(context);
      chooseDriverController.searchController.clear();
    }else if(FromWhere=="fromCategoriesStatus"){
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      //chooseDriverController.ChooseDriverFilter(chooseDriverController.filterId);
      Navigator.pop(context);
      chooseDriverController.searchController.clear();
    }
    else{
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      Navigator.pop(context);
      chooseDriverController.searchController.clear();
    }
  }

  Widget ClientListView(){
    if(chooseDriverController.DriverList.isNotEmpty) {
      return ListView.builder(
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
                chooseDriverController.filterId =
                    chooseDriverController.DriverList[index].id;
                print("driveId" + chooseDriverController.filterId.toString());
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
                            chooseDriverController.DriverList[index]!.avatar!),
                            fit: BoxFit.fill),
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
                          Text(chooseDriverController.DriverList[index]!.name!,
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
      return emptyDriver();
    }
  }

}

class emptyDriver extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/error_img.svg'),
            const SizedBox(height: 10,),
            Text("${getLang(context, "There_are_no_drivers")}",
              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10,),
            Text("${getLang(context, "You_havent_added_any_drivers")}",
              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}