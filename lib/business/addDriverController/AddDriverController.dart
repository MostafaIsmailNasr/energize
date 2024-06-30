import 'dart:io';

import 'package:energize_flutter/data/model/addDriverModel/AddDriverResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class AddDriverController extends GetxController {
  Repo repo = Repo(WebService());
  var addDriverResponse = AddDriverResponse().obs;
  var isLoading=false.obs;
  var errorMessage="";
  var lang="";
  Rx<bool> obscureText = true.obs;
  Rx<bool> obscureText2 = true.obs;
  Rx<bool> isVisabl = false.obs;
  TextEditingController driverNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  File? imageLicense;
  File? imageCar;
  File? ImageResidence;
  Rx<int> isActive = 1.obs;


  getLang()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
  }

  AddDriver(BuildContext context)async{
    addDriverResponse.value = await repo.CreateDriver(
        driverNameController.text,
        phoneController.text,
        passwordController.text,
        confirmPasswordController.text,imageLicense,imageCar,ImageResidence,isActive.value);
    if (addDriverResponse.value.success ==true) {
      isVisabl.value = false; //'/delegate_screen'
      Navigator.pushNamed(context,'/drivers_screen');
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      driverNameController.clear();
      imageLicense=null;
      imageCar=null;
      ImageResidence=null;
    } else {
      isVisabl.value = false;
      // ScaffoldMessenger.of(context!).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.red,
      //     content: Text(addDriverResponse.value.message??''),
      //   ),
      // );
    }
  }
}