import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../business/chooseUserController/ChooseUserController.dart';
import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';
import '../../../../../data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import '../../../../widget_Items_list/ClientAndDriverItem.dart';

class ChooseClientFilterScreen extends StatefulWidget{
  String FromWhere;

  ChooseClientFilterScreen({required this.FromWhere});

  @override
  State<StatefulWidget> createState() {
    return _ChooseClientFilterScreen(FromWhere: FromWhere);
  }
}

class _ChooseClientFilterScreen extends State<ChooseClientFilterScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  String FromWhere;
  int? selectedFlage;
  var lang="";
  final chooseUserController=Get.put(ChooseUserController());

  _ChooseClientFilterScreen({required this.FromWhere});

  @override
  void initState() {
    chooseUserController.isLoading.value=true;
    chooseUserController.page=1;
    chooseUserController.ChooseUserList(chooseUserController.page,"");
    chooseUserController.scroll.addListener(chooseUserController.scrollListener);
    // chooseUserController.ChooseUserList();
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
    if(chooseUserController.FilterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setInt("userId", chooseUserController.FilterId);
      prefs.setInt("userIdFilter", chooseUserController.FilterId);
      prefs.setInt("userId2", chooseUserController.FilterId);
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
        padding: EdgeInsets.only(right: 15, left: 15, top: 10),
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
                  Obx(() => !chooseUserController.isLoading.value
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          child: //ClientListView(),
                          Obx(() => !chooseUserController.isLoading2.value
                              ? ClientListView(): chooseUserController.page==1?
                          const Center(
                              child: CircularProgressIndicator(
                                color: MyColors.MAINCOLORS,
                              )):ClientListView())
                        )
                      : const Center(
                          child:
                              CircularProgressIndicator(color: MyColors.MAINCOLORS),
                        )),
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
                            }else if(FromWhere=="ComprehensiveReportsScreen"){
                              filterInReports();
                            }
                            else{
                              Validation();
                            }
                            //Navigator.pushNamed(context, '/add_client_screen');
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
                    icon: Icon(Icons.arrow_back_ios),
                    color: MyColors.Dark3,
                    onPressed:(){
                      chooseUserController.searchController.clear();
                      LandScapFunc();
                    }
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Center(
                  child: Text("${getLang(context, "choose_client")}",
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
              controller: chooseUserController.searchController,
              onChanged: (vale){
                 if(vale.isEmpty){
                  chooseUserController.ChooseUserList(1,"");
                  selectedFlage = -1;
                }
              },
              onEditingComplete: (){
                chooseUserController.ChooseUserList(1,chooseUserController.searchController.text);
                if(chooseUserController.searchController.text.isEmpty){
                  chooseUserController.ChooseUserList(1,"");
                }
              },
              onFieldSubmitted: (vale){
                chooseUserController.ChooseUserList(1,vale);
                if(vale.isEmpty){
                  chooseUserController.ChooseUserList(1,"");
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
    final filter = chooseUserController.chooseUserResponse.value.data!
        .where((element){
      final name= element.name!.toLowerCase();
      final name2= element.mobile!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input)||name2.contains(input);

    }).toList();
    setState(() {
      chooseUserController.UserList.value=filter;
      selectedFlage = -1;
    });
  }


  LandScapFunc(){
    if(FromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
      }
      Navigator.pop(context);
      chooseUserController.searchController.clear();
    }else{
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      Navigator.pop(context);
      chooseUserController.searchController.clear();
    }
  }

  filterInCategorisStatus()async{
    if(chooseUserController.FilterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("userIdCat", chooseUserController.FilterId);
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
    if(chooseUserController.FilterId!=null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("userIdReport", chooseUserController.FilterId);
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


  Widget ClientListView() {
    if(chooseUserController.UserList.isNotEmpty) {
      return ListView.builder(
          controller: chooseUserController.scroll,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: chooseUserController.UserList.length,
          itemBuilder: (context,int index){
        if(chooseUserController.UserList[index].name!="loading") {
          return InkWell(
            onTap: () {
              setState(() {
                selectedFlage = index;
                chooseUserController.FilterId =
                    chooseUserController.UserList[index].id;
                print("userId" + chooseUserController.FilterId.toString());
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
                    decoration: chooseUserController.UserList[index]!.avatar!=null ?
                    BoxDecoration(
                        image: DecorationImage(image: NetworkImage(
                            chooseUserController.UserList[index]!.avatar!),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(50)) :
                    BoxDecoration(
                        image: const DecorationImage(image: AssetImage(
                            "assets/pic.png")),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chooseUserController.UserList[index]!.name!,
                            style: const TextStyle(fontSize: 16,
                              fontFamily: 'din_next_arabic_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1,),
                          ),
                          Text(chooseUserController.UserList[index]!.mobile!,
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
          });
    }else{
      return emptyUser();
    }
  }
}

class emptyUser extends StatelessWidget{
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
            Text("${getLang(context, "There_are_no_clients")}",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text("${getLang(context, "You_havent_added_any_clients")}",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}