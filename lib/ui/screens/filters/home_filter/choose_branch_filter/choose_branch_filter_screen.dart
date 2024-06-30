import 'package:energize_flutter/business/chooseDelegateController/ChooseDelegateController.dart';
import 'package:energize_flutter/ui/screens/shipment_categories_details/shipment_category_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../business/branchController/BranchController.dart';
import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';
import '../../../../widget_Items_list/ClientAndDriverItem.dart';
import '../../../shipment_categories_details/shipment_category_details_screen.dart';
import '../../../shipment_categories_details/shipment_category_details_screen.dart';

class ChooseBranchFilterScreen extends StatefulWidget{
  String FromWhere;
  ChooseBranchFilterScreen({required this.FromWhere});

  @override
  State<StatefulWidget> createState() {
    return _ChooseBranchFilterScreen(FromWhere: FromWhere);
  }
}

class _ChooseBranchFilterScreen extends State<ChooseBranchFilterScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  String FromWhere;
  _ChooseBranchFilterScreen({required this.FromWhere});
  int? selectedFlage;
  var lang="";
  final branchController=Get.put(BranchController());


  @override
  void initState() {
    branchController.isLoading.value=true;
    branchController.getBranch();
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

  filterInCategorisStatus()async{
    if(branchController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("branchIdCat", branchController.filterId);
      LandScapFunc();

    }else{
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_select_only_one_driver')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Validation()async{
    if(branchController.filterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setInt("branchId", branchController.filterId);
      prefs.setInt("branchIdFilter", branchController.filterId);
      // prefs.setInt("delegateId2", chooseDelegateController.filterId);
      LandScapFunc();
    }else{
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'please_select_only_one_driver')}"),
          duration: Duration(seconds: 1),
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
        padding: EdgeInsets.only(right: 15,left: 15,top: 10),
        child: Directionality(
          textDirection: lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomBar(),
                  search(),
                  Obx(() =>!branchController.isLoading.value? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      child: ClientListView()
                  ):Center(
                      child: CircularProgressIndicator(color: MyColors.MAINCOLORS))),
                  Container(
                    color: Colors.white,
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 93,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 8,right: 8),
                        width: 327,
                        height: 53,
                        child: TextButton(
                          style: flatButtonStyle ,
                          onPressed: (){
                            if(FromWhere=="fromCategoriesStatus"){
                              filterInCategorisStatus();
                            }
                            else{
                              Validation();
                            }
                          },
                          child: Text("${getLang(context, "save")}",
                            style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
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
        SizedBox(height: 10,),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: MyColors.Dark3,
                    onPressed:(){
                      // LandScapFunc();
                      branchController.searchController.clear();
                      Navigator.pop(context);
                    }
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Center(
                  child: Text("${getLang(context, "choose_branch")}",
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
              controller: branchController.searchController,
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


  void _filterItems(String query) {
    //log(query);
    final filter = branchController.branchResponse.value.data!
        .where((element){
      final name= element.name!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() {
      branchController.branches.value=filter;
      selectedFlage=-1;
    });
  }

  LandScapFunc(){
    // if(FromWhere=="ComprehensiveReportsScreen"){
    //   if (MediaQuery.of(context).orientation == Orientation.portrait) {
    //     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    //   }
    //   Navigator.pop(context);
    // }
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      //branchController.ChooseDelegateFilter(branchController.filterId);
      Navigator.pop(context);
      branchController.searchController.clear();

  }

  Widget ClientListView(){
    if(branchController.branches.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: branchController.branches.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              setState(() {
                selectedFlage=index;
                branchController.filterId= branchController.branches[index].id;
                print("branchId"+branchController.filterId.toString());
              });
            },
            child: Container(
              width:MediaQuery.of(context).size.width,
              padding: EdgeInsetsDirectional.all(10),
              margin: EdgeInsetsDirectional.only(start: 8,end: 8,top: 8),
              decoration: BoxDecoration(
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
                    child: Text(branchController.branches[index]!.name!,
                      style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    child: selectedFlage==index?
                    Center(
                      child: SvgPicture.asset('assets/checked.svg'),
                    ):
                    Center(
                      child: Image(image: AssetImage('assets/Rectangle_6.png')),
                    ),
                  ),
                ],
              ),

            ),
          );
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
            Text("${getLang(context, "There_are_no_branches")}",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}