import 'package:energize_flutter/business/delegateController/DelegateController.dart';
import 'package:energize_flutter/conustant/AppLocale.dart';
import 'package:energize_flutter/ui/screens/menu/delegate/add_delegate/add_delegate_screen.dart';
import 'package:energize_flutter/ui/screens/shimer_pages/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../conustant/my_colors.dart';
import '../../../widget_Items_list/DelegateItem.dart';
import '../../update/update_delegate/update_delegate_screen.dart';
import 'delete/DeleteDelegateScreen.dart';

class DelegateScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DelegateScreen();
  }
}

class _DelegateScreen extends State<DelegateScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final delegateController=Get.put(DelegateController());

  @override
  void initState() {
    delegateController.page=1;
    delegateController.getDelegateList(delegateController.page,"");
    delegateController.scroll.addListener(delegateController.scrollListener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
            final bool connected =connectivity != ConnectivityResult.none;
            if (connected) {
              return   Obx(() =>!delegateController.isLoading.value? SafeArea(
                child: Directionality(
                    textDirection: delegateController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            delegateController.searchController.clear();
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios, color: MyColors.Dark1)),
                      title: Text(
                        "${getLang(context, 'delegates')}",
                        style: const TextStyle(
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
                      margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Column(
                        children: [
                          search(),
                          const SizedBox(height: 5,),
                         // Expanded(child:DelegateListView(),),
                          Obx(() => !delegateController.isLoading2.value
                                    ? Expanded(child: DelegateListView())
                                    : delegateController.page == 1
                                        ? const Expanded(
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                            color: MyColors.MAINCOLORS,
                                          )))
                                        : Expanded(child: DelegateListView()))
                              ],
                      ),
                    ),
                    bottomNavigationBar:(delegateController.role=="admin")?
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
                                    return AddDelegateScreen();
                                  }));
                              //Navigator.pushNamed(context, '/add_delegate_screen');
                            },
                            child: Text("${getLang(context, "add_delegate")}",
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
              controller: delegateController.searchController,
              onChanged: (vale){
                if(vale.isEmpty){
                  delegateController.getDelegateList(1,"");
                }
              },
              onEditingComplete: (){
                delegateController.getDelegateList(1,delegateController.searchController.text);
                if(delegateController.searchController.text.isEmpty){
                  delegateController.getDelegateList(1,"");
                }
              },
              onFieldSubmitted: (vale){
                delegateController.getDelegateList(1,vale);
                if(vale.isEmpty){
                  delegateController.getDelegateList(1,"");
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
    final filter = delegateController.delegateResponse.value.data!
        .where((element){
      final name= element.name!.toLowerCase();
      final name2= element.mobile!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input)||name2.contains(input);
    }).toList();
    setState(() {
      delegateController.DelegateList.value=filter;
    });
  }

  Widget DelegateListView(){
    if(delegateController.DelegateList.isNotEmpty) {
      return ListView.builder(
          controller: delegateController.scroll,
          itemCount: delegateController.DelegateList.length,
          itemBuilder: (context,int index){
            if(delegateController.DelegateList[index].name!="loading") {
              return Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 71,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: MyColors.Dark5)
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: delegateController.DelegateList[index]
                          .avatar != null ?
                      BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(delegateController
                                  .DelegateList[index].avatar!),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(50)) :
                      BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("assets/pic.png")),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 47,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(delegateController.DelegateList[index].name!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'din_next_arabic_medium',
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.Dark1),
                              textAlign: TextAlign.start,
                            ),
                            Text(delegateController.DelegateList[index].mobile!,
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
                                  final SharedPreferences prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.setInt('delegateId',
                                      delegateController.DelegateList[index]
                                          .id!);
                                  prefs.setString('delegateName',
                                      delegateController.DelegateList[index]
                                          .name!);
                                  prefs.setString('delegatePhone',
                                      delegateController.DelegateList[index]
                                          .mobile!);
                                  prefs.setInt('delegateBranchId',
                                      delegateController.DelegateList[index]
                                          .branchId!);
                                  prefs.setString('delegateToken',
                                      delegateController.DelegateList[index]
                                          .token!);
                                  prefs.setInt('filterStatus',
                                      delegateController.DelegateList[index]
                                          .status!);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return UpdateDelegateScreen();
                                      }));
                                },
                                child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: SvgPicture.asset('assets/edit.svg',)
                                )
                            ),
                          ),
                          (delegateController.role == "admin") ?
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: MyColors.DarkWHITE,
                                      builder: (BuildContext context) =>
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: DeleteDelegateScreen(
                                                  id: delegateController
                                                      .DelegateList[index].id!,
                                                  token: delegateController
                                                      .DelegateList![index]
                                                      .token!.toString())
                                          )
                                  );
                                  //_onAlertButtonsPressed(context,"${getLang(context, 'Do_you_want_to_confirm_the_deletion')}",delegateController.DelegateList[index].token);
                                },
                                child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: SvgPicture.asset('assets/trash.svg',)
                                )
                            ),
                          ) :
                          Container(width: 5,)
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else {
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

}

class emptyDriver extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(top: 60),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/error_img.svg'),
              const SizedBox(height: 10,),
              Text("${getLang(context, "There_are_no_delegates")}",
                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10,),
              Text("${getLang(context, "You_have_not_added_any_delegates")}",
                style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}