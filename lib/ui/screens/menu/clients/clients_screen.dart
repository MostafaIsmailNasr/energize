import 'package:energize_flutter/ui/screens/home/home_screen.dart';
import 'package:energize_flutter/ui/screens/menu/clients/add_client/add_client_screen.dart';
import 'package:energize_flutter/ui/screens/shimer_pages/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/clientController/ClientController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget_Items_list/DelegateItem.dart';
import '../../update/update_client/update_client_screen.dart';

class ClientScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClientScreen();
  }
}

class _ClientScreen extends State<ClientScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final ClientController=Get.put(UserController());

  @override
  void initState() {
    ClientController.page=1;
    ClientController.getUserList(ClientController.page,"");
    ClientController.scroll.addListener(ClientController.scrollListener);
    //ClientController.getUserList();
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
              return   Obx(() =>!ClientController.isLoading.value? SafeArea(
                  child: Directionality(
                      textDirection: ClientController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                    child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize:20,
                            onPressed: (){
                              ClientController.searchController.clear();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                        ),
                        title: Text(
                          "${getLang(context, "clients")}",
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
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Column(
                          children: [
                            search(),
                            const SizedBox(height: 5,),
                            // Expanded(child: UserListView())
                            Obx(() => !ClientController.isLoading2.value
                                ? Expanded(child: UserListView()): ClientController.page==1?
                            const Expanded(
                                child: Center(
                                    child: CircularProgressIndicator(
                                      color: MyColors.MAINCOLORS,
                                    ))):Expanded(child: UserListView())
                            ),
                          ],
                        ),
                      ),
                      bottomNavigationBar:(ClientController.role=="delegate"||ClientController.role=="admin")?
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
                                      return AddClientScreen();
                                    }));
                                // Navigator.pushNamed(context, '/add_client_screen');
                              },
                              child: Text("${getLang(context, "add_client")}",
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
                  :shimmer()
              );
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
              controller: ClientController.searchController,
              onChanged: (vale){
                if(vale.isEmpty){
                  ClientController.getUserList(1,"");
                }
              },
              onEditingComplete: (){
                ClientController.getUserList(1,ClientController.searchController.text);
                if(ClientController.searchController.text.isEmpty){
                  ClientController.getUserList(1,"");
                }
              },
              onFieldSubmitted: (vale){
                ClientController.getUserList(1,vale);
                if(vale.isEmpty){
                  ClientController.getUserList(1,"");
                }
              },
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

  Widget UserListView(){
    if(ClientController.UserList.isNotEmpty) {
      return ListView.builder(
          controller: ClientController.scroll,
          itemCount: ClientController.UserList.length,
          itemBuilder: (context,int index){
            if(ClientController.UserList[index].name!="loading") {
              return Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                      decoration: ClientController.UserList[index].avatar!=null?
                      BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(ClientController
                                  .UserList[index].avatar!), fit: BoxFit.fill),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ClientController.UserList[index].name!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'din_next_arabic_medium',
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.Dark1),
                              textAlign: TextAlign.start,
                            ),
                            Text(ClientController.UserList[index].mobile!,
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
                                  prefs.setInt('userId',
                                      ClientController.UserList[index].id!);
                                  prefs.setString('userName',
                                      ClientController.UserList[index].name!);
                                  prefs.setString('userPhone',
                                      ClientController.UserList[index].mobile!);
                                  prefs.setString('userManager',
                                      ClientController.UserList[index]
                                          .managerName!);
                                  prefs.setString('UserToken',
                                      ClientController.UserList[index].token!);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return UpdateClientScreen();
                                      }));
                                  //Navigator.pushNamed(context, '/update_client_screen');
                                },
                                child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: SvgPicture.asset('assets/edit.svg',)
                                )
                            ),
                          ),
                          (ClientController.role == "admin") ?
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _onAlertButtonsPressed(context, "${getLang(
                                      context,
                                      'Do_you_want_to_confirm_the_deletion_client')}",
                                      ClientController.UserList[index].token);
                                },
                                child: SizedBox(
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
              return const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS),);
            }
          }
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
          child: Text(
            "${getLang(context, 'delete')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),
          onPressed: () => {
            ClientController.delete(context, token)
          },
          color: MyColors.SideRed,
        ),
        DialogButton(
          height: 53,
          child: Text(
            "${getLang(context, 'cancel')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),
          onPressed: () => Navigator.pop(context),
          color: MyColors.Secondry_Color,

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
              const SizedBox(height: 10,),
              Text("${getLang(context, "There_are_no_clients")}",
                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10,),
              Text("${getLang(context, "You_havent_added_any_clients")}",
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