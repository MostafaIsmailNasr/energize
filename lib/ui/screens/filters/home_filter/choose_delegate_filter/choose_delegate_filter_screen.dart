import 'package:energize_flutter/business/chooseDelegateController/ChooseDelegateController.dart';
import 'package:energize_flutter/ui/screens/shipment_categories_details/shipment_category_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';
import '../../../../widget_Items_list/ClientAndDriverItem.dart';
import '../../../shipment_categories_details/shipment_category_details_screen.dart';
import '../../../shipment_categories_details/shipment_category_details_screen.dart';

class ChooseDelegateFilterScreen extends StatefulWidget{
  String FromWhere;
  ChooseDelegateFilterScreen({required this.FromWhere});

  @override
  State<StatefulWidget> createState() {
    return _ChooseDelegateFilterScreen(FromWhere: FromWhere);
  }
}

class _ChooseDelegateFilterScreen extends State<ChooseDelegateFilterScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  String FromWhere;
  _ChooseDelegateFilterScreen({required this.FromWhere});
  int? selectedFlage;
  var lang="";
  final chooseDelegateController=Get.put(ChooseDelegateController());


  @override
  void initState() {
    chooseDelegateController.isLoading.value=true;
    chooseDelegateController.page=1;
    chooseDelegateController.ChooseDelegateList(chooseDelegateController.page,"");
    chooseDelegateController.scroll.addListener(chooseDelegateController.scrollListener);
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
    if(chooseDelegateController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setInt("delegateId", chooseDelegateController.filterId);
      prefs.setInt("delegateIdFilter", chooseDelegateController.filterId);
      prefs.setInt("delegateId2", chooseDelegateController.filterId);
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

  filterInCategorisStatus()async{
    if(chooseDelegateController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("delegateIdCat", chooseDelegateController.filterId);
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
    if(chooseDelegateController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("delegateIdReport", chooseDelegateController.filterId);
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
              Obx(() =>!chooseDelegateController.isLoading.value?
              SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                     child: Obx(() => !chooseDelegateController.isLoading2.value
                         ? ClientListView(): chooseDelegateController.page==1?
                     const Center(
                         child: CircularProgressIndicator(
                           color: MyColors.MAINCOLORS,
                         )):ClientListView())
                     //ClientListView()
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
                     // LandScapFunc();
                      chooseDelegateController.searchController.clear();
                      Navigator.pop(context);
                    }
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Center(
                  child: Text("${getLang(context, "Choose_delegate")}",
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
      selectedFlage=-1;
    });
  }

  LandScapFunc(){
    if(FromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
      }
      Navigator.pop(context);
      chooseDelegateController.searchController.clear();
    }else if(FromWhere=="fromCategoriesStatus"){
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        //chooseDelegateController.ChooseDelegateFilter(chooseDelegateController.filterId);
        Navigator.pop(context);
      chooseDelegateController.searchController.clear();
    }
    else{
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      Navigator.pop(context);
      chooseDelegateController.searchController.clear();
    }
  }

  Widget ClientListView(){
    if(chooseDelegateController.DelegateList.isNotEmpty) {
      return ListView.builder(
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
                chooseDelegateController.filterId =
                    chooseDelegateController.DelegateList[index].id;
                print("driveId" + chooseDelegateController.filterId.toString());
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
            Text("${getLang(context, "There_are_no_delegates")}",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text("${getLang(context, "You_have_not_added_any_delegates")}",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}