import 'dart:ffi';

import 'package:energize_flutter/data/model/homeModel/HomeResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/updateTokenModel/UpdateTokenResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class HomeController extends GetxController {
  Repo repo = Repo(WebService());
  var homeResponse = HomeResponse().obs;
  var isLoading=false.obs;
  var lang="";
  var token="";
  var userName="";
  var userPhone="";
  var pic;
  var role;
  var updateTokenResponse = UpdateTokenResponse().obs;
  TextEditingController GraduationController=TextEditingController();
  TextEditingController CarNumController=TextEditingController();

  getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName=prefs.getString("full_name")!;
    userPhone=prefs.getString("phone_number")!;
    role=prefs.getString("role")!;
    pic=prefs.getString("picture")!;
  }

  getHomeData(int user_id,int driver_id,int delegate_id,int branch_id,BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    isLoading.value=true;
    homeResponse.value = await repo.getHomeData(token,user_id,driver_id,delegate_id,branch_id,GraduationController.text
    ,CarNumController.text,context);
    isLoading.value=false;
    return homeResponse.value;
  }

  getHomeFilter(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    // var user_id=prefs.getInt("userId")!;
    // var driver_id=prefs.getInt("driverId")!;
    // var delegate_id=prefs.getInt("delegateId")!;
    // var branch_id=prefs.getInt("branchId")!;
    var user_id=prefs.getInt("userIdFilter")!;
    var driver_id=prefs.getInt("driverIdFilter")!;
    var delegate_id=prefs.getInt("delegateIdFilter")!;
    var branch_id=prefs.getInt("branchIdFilter")!;
    isLoading.value=true;
    homeResponse.value = await repo.getHomeData(token,user_id,driver_id,delegate_id,branch_id,GraduationController.text,
        CarNumController.text,context);
    if(homeResponse.value.success=true){
      isLoading.value=false;
      Get.back();
    }
    isLoading.value=false;
    return homeResponse.value;
  }

  updateToken(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    updateTokenResponse.value = (await repo.UpdateToken(token,""))!;
    if(updateTokenResponse.value.success==true){
      Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);

    }
  }
}