import 'package:energize_flutter/ui/screens/shimer_pages/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../business/branchBetailsController/BranchBetailsController.dart';
import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';
import '../../../../widget_Items_list/DelegateItem.dart';
import '../../../update/update_delegate/update_delegate_for_branch/UpdateDelegateForBranch.dart';
import '../../delegate/add_delegate_for_branch/AddDelegetDorBranchScreen.dart';
import '../branches_screen.dart';

class BranchesBetailsScreen extends StatefulWidget{
  int branchId;
  BranchesBetailsScreen({required this.branchId});

  @override
  State<StatefulWidget> createState() {
    return _BranchesBetailsScreen(branchId: branchId);
  }
}

class _BranchesBetailsScreen extends State<BranchesBetailsScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final branchBetailsController=Get.put(BranchDetailsController());
  int branchId;

  _BranchesBetailsScreen({required this.branchId});

  @override
  void initState() {
    branchBetailsController.branchIds=branchId;
    branchBetailsController.page=1;
    branchBetailsController.getDelegateList(branchId,branchBetailsController.page,"");
    branchBetailsController.scroll.addListener(branchBetailsController.scrollListener);
   // branchBetailsController.getDelegateList(branchId);
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
              return   Obx(() =>!branchBetailsController.isLoading.value? SafeArea(
                  child: Directionality(
                      textDirection: branchBetailsController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                    child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize: 20,
                            onPressed: () {
                              branchBetailsController.searchController.clear();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return BranchesScreen();
                                  }));
                              //Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios, color: MyColors.Dark1)),
                        title: Text(
                          branchBetailsController.tittle??"",
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
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Column(
                          children: [
                            search(),
                            const SizedBox(height: 5,),
                            //Expanded(child: DelegateListView())
                            Obx(() => !branchBetailsController.isLoading2.value
                                ? Expanded(child: DelegateListView())
                                : branchBetailsController.page == 1
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
                      bottomNavigationBar: (branchBetailsController.role=="admin")?
                      Container(
                        color: Colors.white,
                        alignment: Alignment.bottomCenter,
                        width:MediaQuery.of(context).size.width,
                        height: 93,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 8,right: 8),
                            width:MediaQuery.of(context).size.width,
                            height: 53,
                            child: TextButton(
                              style: flatButtonStyle ,
                              onPressed: (){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                      return AddDelegetDorBranchScreen(branchId: branchId,);
                                    }));
                                //Get.to(AddDelegetDorBranchScreen(branchId: branchId));
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
                        width:MediaQuery.of(context).size.width,
                        height: 10)
                    ),
                  )
              )
                  :shimmer());
            } else {
              return Scaffold(body: NoIntrnet());
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
              controller: branchBetailsController.searchController,
              onChanged: (vale){
                 if(vale.isEmpty){
                  branchBetailsController.getDelegateList(branchId,1,"");
                }
              },
              onEditingComplete: (){
                branchBetailsController.getDelegateList(branchId,1,branchBetailsController.searchController.text);
                if(branchBetailsController.searchController.text.isEmpty){
                  branchBetailsController.getDelegateList(branchId,1,"");
                }
              },
              onFieldSubmitted: (vale){
                branchBetailsController.getDelegateList(branchId,1,vale);
                if(vale.isEmpty){
                  branchBetailsController.getDelegateList(branchId,1,"");
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
    final filter = branchBetailsController.delegateResponse.value.data!
        .where((element){
      final name= element.name!.toLowerCase();
      final mobile= element.mobile!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input)||mobile.contains(input);
    }).toList();
    setState(() {
      branchBetailsController.DelegateList.value=filter;
    });
  }

  Widget DelegateListView(){
    if(branchBetailsController.DelegateList.isNotEmpty) {
      return ListView.builder(
        controller: branchBetailsController.scroll,
        itemCount: branchBetailsController.DelegateList.length,
        itemBuilder: (context, int index) {
          if(branchBetailsController.DelegateList[index].name!="loading") {
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
                    decoration: branchBetailsController.DelegateList[index].avatar!=null?
                    BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(branchBetailsController
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
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 47,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(branchBetailsController.DelegateList[index]
                              .name!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'din_next_arabic_medium',
                                fontWeight: FontWeight.w500,
                                color: MyColors.Dark1),
                            textAlign: TextAlign.start,
                          ),
                          Text(branchBetailsController.DelegateList[index]
                              .mobile!,
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
                  Container(
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
                                    branchBetailsController.DelegateList[index]
                                        .id!);
                                prefs.setString('delegateName',
                                    branchBetailsController.DelegateList[index]
                                        .name!);
                                prefs.setString('delegatePhone',
                                    branchBetailsController.DelegateList[index]
                                        .mobile!);
                                prefs.setInt('delegateBranchId',
                                    branchBetailsController.DelegateList[index]
                                        .branchId!);
                                prefs.setString('delegateToken',
                                    branchBetailsController.DelegateList[index]
                                        .token!);
                                prefs.setInt('filterStatusBranch',
                                    branchBetailsController.DelegateList[index]
                                        .status!);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                      return UpdateDelegateForBranch();
                                    }));
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset('assets/edit.svg',)
                              )
                          ),
                        ),
                        (branchBetailsController.role == "admin") ?
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                _onAlertButtonsPressed(context, "${getLang(
                                    context,
                                    'Do_you_want_to_confirm_the_deletion')}",
                                    branchBetailsController.DelegateList[index]
                                        .token);
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset('assets/trash.svg',)
                              )
                          ),
                        ) : Container(width: 5,)
                      ],
                    ),
                  )
                ],
              ),
            );
          }else{
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
  _onAlertButtonsPressed(BuildContext context,String des,String token) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/delete_dialog_img.svg',),
      title: "${getLang(context, 'confirm_deletion')}",
      style: const AlertStyle(
        titleStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: MyColors.Dark1,fontFamily: 'din_next_arabic_bold'),
        descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.Dark2,fontFamily: 'din_next_arabic_regulare'),
      ),
      desc: des,
      buttons: [
        DialogButton(
          height: 53,
          onPressed: () => {
            branchBetailsController.delete(context, token)
          },
          color: MyColors.SideRed,
          child: Text(
            "${getLang(context, 'delete')}",
            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),
        ),
        DialogButton(
          height: 53,
          onPressed: () => Navigator.pop(context),
          color: MyColors.Secondry_Color,
          child: Text(
            "${getLang(context, 'cancel')}",
            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),

        )
      ],
    ).show();
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
      ),
    );
  }

}