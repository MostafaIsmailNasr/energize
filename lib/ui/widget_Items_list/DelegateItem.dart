import 'dart:developer';

import 'package:energize_flutter/data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import 'package:energize_flutter/ui/screens/update/update_client/update_client_screen.dart';
import 'package:energize_flutter/ui/screens/update/update_delegate/update_delegate_screen.dart';
import 'package:energize_flutter/ui/screens/update/update_driver/update_driver_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business/branchBetailsController/BranchBetailsController.dart';
import '../../business/cityController/CityController.dart';
import '../../business/clientController/ClientController.dart';
import '../../business/delegateController/DelegateController.dart';
import '../../business/driverController/DriverController.dart';
import '../../conustant/AppLocale.dart';
import '../../conustant/ToastClass.dart';
import '../../conustant/my_colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../data/model/addPayloadModel/chooseDriverModel/ChooseDriverResponse.dart';
import '../../data/model/addPayloadModel/cities/CitiesResponse.dart';
import '../../data/model/delegateModel/DelegateResponse.dart';
import '../screens/menu/cities/delete/DeleteScreen.dart';
import '../screens/update/update_city/update_city_screen.dart';
import '../screens/update/update_delegate/update_delegate_for_branch/UpdateDelegateForBranch.dart';

class  DelegateItem extends StatefulWidget{
  String des;
  String fromWhere;
  final Delegate? delegate;
  final ChooseDriver? drive;
  final ChooseUser? user;
  final City? city;

  DelegateItem(this.fromWhere,this.des,this.delegate,this.drive,this.user,this.city);

  @override
  State<StatefulWidget> createState() {
    return _DelegateItem(fromWhere,des,delegate,drive,user,city);
  }

}

class _DelegateItem extends State<DelegateItem>{
   String des;
  String fromWhere;
  final Delegate? delegate;
  final ChooseDriver? drive;
   final ChooseUser? user;
   final City? city;
   final ClientController=Get.put(UserController());
   final delegateController=Get.put(DelegateController());
   final driverController=Get.put(DriverController());
   final branchBetailsController=Get.put(BranchDetailsController());
   final cityController=Get.put(CityController());

   _DelegateItem(this.fromWhere,this.des,this.delegate,this.drive,this.user,this.city);

  @override
  Widget build(BuildContext context) {
    // if(fromWhere=="city"&&(cityController.deletResponse.value!=null)){
    //   print("kkkkkkkkkkk");
    //   ToastClass.showCustomToast(context, "fdfd", 'error');
    // }
    if(fromWhere=="delegate"){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 71,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1,color: MyColors.Dark5)
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration:delegate!.avatar!.isNotEmpty?
              BoxDecoration(
                  image: DecorationImage(image: NetworkImage(delegate!.avatar!),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(50)):
              BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/pic.png")),
                  borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 47,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(delegate!.name!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'din_next_arabic_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                      textAlign: TextAlign.start,
                    ),
                    Text(delegate!.mobile!,
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
                        onTap: ()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('delegateId', delegate!.id!);
                          prefs.setString('delegateName', delegate!.name!);
                          prefs.setString('delegatePhone', delegate!.mobile!);
                          prefs.setInt('delegateBranchId', delegate!.branchId!);
                          prefs.setString('delegateToken', delegate!.token!);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return UpdateDelegateScreen();
                              }));
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset('assets/edit.svg',)
                        )
                    ),
                  ),
                  (delegateController.role=="admin")?
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          _onAlertButtonsPressed(context,des,"fromDelegate");
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset('assets/trash.svg',)
                        )
                    ),
                  ):
                  Container(width: 5,)
                ],
              ),
            )
          ],
        ),
      );
    }
    else if(fromWhere=="delegateForBranch"){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 71,
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
              decoration:delegate!.avatar!.isNotEmpty?
              BoxDecoration(
                  image: DecorationImage(image: NetworkImage(delegate!.avatar!),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(50)):
              BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/pic.png")),
                  borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 47,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(delegate!.name!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'din_next_arabic_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                      textAlign: TextAlign.start,
                    ),
                    Text(delegate!.mobile!,
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
                        onTap: ()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('delegateId', delegate!.id!);
                          prefs.setString('delegateName', delegate!.name!);
                          prefs.setString('delegatePhone', delegate!.mobile!);
                          prefs.setInt('delegateBranchId', delegate!.branchId!);
                          prefs.setString('delegateToken', delegate!.token!);
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
                  (branchBetailsController.role=="admin")?
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          _onAlertButtonsPressed(context,des,"delegateForBranch");
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
    else if(fromWhere=="client"){
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
              decoration:user!.avatar!.isNotEmpty?
              BoxDecoration(
                  image: DecorationImage(image: NetworkImage(user!.avatar!),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(50)):
              BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/pic.png")),
                  borderRadius: BorderRadius.circular(50)),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user!.name!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'din_next_arabic_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                      textAlign: TextAlign.start,
                    ),
                    Text(user!.mobile!,
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
                        onTap: ()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('userId', user!.id!);
                          prefs.setString('userName', user!.name!);
                          prefs.setString('userPhone', user!.mobile!);
                          prefs.setString('userManager', user!.managerName!);
                          prefs.setString('UserToken', user!.token!);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return UpdateClientScreen();
                              }));
                          //Navigator.pushNamed(context, '/update_client_screen');
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset('assets/edit.svg',)
                        )
                    ),
                  ),
                  (ClientController.role=="admin")?
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          _onAlertButtonsPressed(context,des,"client");
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
    else if(fromWhere=="driver"){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 71,
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
              decoration:drive!.avatar!.isNotEmpty?
              BoxDecoration(
                  image: DecorationImage(image: NetworkImage(drive!.avatar!),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(50)):
              BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/pic.png")),
                  borderRadius: BorderRadius.circular(50)),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 47,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(drive!.name!,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'din_next_arabic_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                      textAlign: TextAlign.start,
                    ),
                    Text(drive!.mobile!,
                      style: TextStyle(
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
                        onTap: ()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('driverId', drive!.id!);
                          prefs.setString('driverName', drive!.name!);
                          prefs.setString('driverPhone', drive!.mobile!);
                          prefs.setString('driverLicense', drive!.licenseImg!);
                          prefs.setString('drivercarForm', drive!.carFormImg!);
                          prefs.setString('driverresidence', drive!.residenceImg!);
                          prefs.setString('driverToken', drive!.token!);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return UpdateDreiverScreen();
                              }));
                          //Navigator.pushNamed(context, '/update_driver_screen');
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset('assets/edit.svg',)
                        )
                    ),
                  ),
                  (driverController.role=="admin")?
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          _onAlertButtonsPressed(context,des,"driver");
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset('assets/trash.svg',)
                        )
                    ),
                  ):
                  Container(width: 5,)
                ],
              ),
            )
          ],
        ),
      );
    }
    else if(fromWhere=="city"){
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
                child: Text(city!.name!,
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
                           prefs.setString('cityName', city!.name!);
                          showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor:MyColors.DarkWHITE,
                              builder: (BuildContext context)=> Padding(
                                  padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: UpdateCityScreen(id: city!.id!,)
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
                                  child: DeleteScreen(id: city!.id!,)
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
    else{
      return Container();
    }

  }

    _onAlertButtonsPressed(BuildContext context,String des,String fromWhere) {
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
            if(fromWhere=="client"){
              ClientController.delete(context,user!.token!)
            }else if(fromWhere=="city"){
              cityController.deleteCity(city!.id!,context)
            }
            else if(fromWhere=="fromDelegate"){
              delegateController.delete(context, delegate!.token!)
            }else if(fromWhere=="driver"){
              driverController.delete(context, drive!.token!)
            }else if(fromWhere=="delegateForBranch"){
              branchBetailsController.delete(context, delegate!.token!)
            }
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