import 'package:energize_flutter/data/model/CategoryDetailsModel/CategoryDetailsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../conustant/ToastClass.dart';
import '../../data/model/uploadShipmentImageModel/UploadShipmentImageResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class CategoryDetailsController extends GetxController {
  Repo repo = Repo(WebService());
  var categoryDetailsResponse = CategoryDetailsResponse().obs;
  var uploadShipmentImageResponse = UploadShipmentImageResponse().obs;
  var isLoading=false.obs;
  var token="";
  var lang="";
  var role;
  var id;
  var boundImg;

  getCategoryDetails()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    id=prefs.getInt("id");
    lang= prefs.getString('lang')!;
    role=prefs.getString('role')!;
    isLoading.value=true;
    categoryDetailsResponse.value = await repo.getCategoryDetails(token,id);
    isLoading.value=false;
    print("ccxv$id");
    return categoryDetailsResponse.value;
  }

  uploadShipmentImg(int orderId,BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    uploadShipmentImageResponse.value = await repo.uploadShipmentImage(boundImg,token,orderId);
    if(uploadShipmentImageResponse.value.success==true){
      isLoading.value=false;
      Fluttertoast.showToast(
        msg: uploadShipmentImageResponse.value.message.toString(),
        toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
      );
    }else{
      Fluttertoast.showToast(
        msg: uploadShipmentImageResponse.value.message.toString(),
        toastLength: Toast.LENGTH_SHORT,backgroundColor:Colors.red,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
      );
    }
    return uploadShipmentImageResponse.value;
  }
}