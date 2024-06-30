import 'package:energize_flutter/ui/screens/shimer_pages/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../business/branchController/BranchController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget_Items_list/BranchesItem.dart';
import '../../dialogs/add_branch/add_branch_dialog.dart';

class BranchesScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BranchesScreen();
  }
}

class _BranchesScreen extends State<BranchesScreen>with TickerProviderStateMixin{
  final branchController=Get.put(BranchController());
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));

  @override
  void initState() {
    branchController.getBranch();
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
              return   Obx(() =>!branchController.isLoading.value? SafeArea(
                  child: Directionality(
                      textDirection: branchController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize:20,
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                        ),
                        title: Text(
                          "${getLang(context, "branches")}",
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
                            Expanded(
                                child: DelegateListView()
                            )
                          ],
                        ),
                      ),
                      bottomNavigationBar: (branchController.role=="admin")?
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
                                showModalBottomSheet<void>(
                                    transitionAnimationController: AnimationController(vsync: this,duration: Duration(milliseconds: 200)),
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor:MyColors.DarkWHITE,
                                    builder: (BuildContext context)=> Padding(
                                        padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: AddBranchDialog()
                                    )
                                );
                              },
                              child: Text("${getLang(context, "add_branch")}",
                                style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                            ),
                          ),
                        ),
                      ):
                      Container(
                        color: Colors.white,
                        alignment: Alignment.bottomCenter,
                        width:MediaQuery.of(context).size.width,
                        height: 10,)
                    ),
                  )
              )
                  :shimmer());
            } else {
              return Scaffold(body: NoIntrnet());
            }
          },
          child: Center(
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
    final filter = branchController.branchResponse.value.data!
        .where((element){
      final name= element.name!.toLowerCase();
      final input=query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() {
      branchController.branches.value=filter;
    });
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



  Widget DelegateListView(){
    if(branchController.branches.isNotEmpty) {
      return ListView.builder(
          itemCount: branchController.branches.length,
          itemBuilder: (context,int index){
            return BranchesItem(
                UserImg: 'assets/logo2.png',
                branch: branchController.branches[index],
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
              Text("${getLang(context, "There_are_no_branches")}",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Text("${getLang(context, "You_havent_added_any_branches")}",
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