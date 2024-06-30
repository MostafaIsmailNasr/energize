import 'dart:io';

import 'package:energize_flutter/data/model/updateDriverModel/UpdateDriverResponse.dart';
import 'package:energize_flutter/ui/screens/menu/drivers/drivers_screen.dart';
import 'package:energize_flutter/ui/screens/update/update_driver/update_driver_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class UpdateDriverController extends GetxController {
  Repo repo = Repo(WebService());
  var updateDriverResponse = UpdateDriverResponse().obs;
  var isLoading = false.obs;
  var errorMessage = "";
  var isLoading2 = false.obs;
  var userToken = "";
  var token = "";
  var lang="";
  TextEditingController driverNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rx<bool> obscureText = true.obs;
  Rx<bool> obscureText2 = true.obs;
  Rx<bool> isVisabl = false.obs;
  var name = "";
  var phone = "";
  var licence="";
  var car="";
  var rese="";
  File? imageLicense;
  File? imageCar;
  File? ImageResidence;
  Rx<int> isActive = 1.obs;

  getData() async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("driverName")!;
    phone = prefs.getString("driverPhone")!;
    licence = prefs.getString("driverLicense")!;
    car = prefs.getString("drivercarForm")!;
    rese = prefs.getString("driverresidence")!;
    driverNameController.text = name;
    phoneController.text = phone;
    userToken = prefs.getString("driverToken")!;
    lang= prefs.getString('lang')!;
    isActive.value=prefs.getInt("statusFilterDriver")!;
    // imageLicense= File(licence);
    // imageCar=File(car);
    // ImageResidence=File(rese);
    isLoading.value = false;
  }

  updateDriver(BuildContext context)async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("driverToken")!;
    updateDriverResponse.value = await repo.UpdateDriver(
        driverNameController.text,
        phoneController.text,
        passwordController.text,
        confirmPasswordController.text,
        imageLicense,
        imageCar,
        ImageResidence,token,isActive.value);
    if (updateDriverResponse.value.success == true) {
      isVisabl.value = false;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return DriverScreen();
          }));
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      driverNameController.clear();
      imageLicense=null;
      imageCar=null;
      ImageResidence=null;
    } else {
      isVisabl.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(updateDriverResponse.value.message!),
          backgroundColor: Colors.red,
        ),
      );


    }
  }
}