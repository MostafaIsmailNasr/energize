import 'dart:io';

import 'package:energize_flutter/ui/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/profileModel/ProfileResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class ProfileController extends GetxController {
  Repo repo = Repo(WebService());
  var profileResponse = ProfileResponse().obs;
  var isLoading = false.obs;
  var errorMessage = "";
  var token = "";
  var lang="";
  var name;
  var pic;
  var phone;
  File? image;
  Rx<bool> isVisabl = false.obs;
  TextEditingController NameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();




  profile(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("tokenUser")!;
    profileResponse.value = await repo.UpdateProfile(
        NameController.text,
        image,
        phoneController.text,
        passwordController.text,
        token);

    if (profileResponse.value.success == true) {
      isVisabl.value = false;

      await prefs.setString('full_name', profileResponse.value.data!.name??"");
      await prefs.setString('picture', profileResponse.value.data!.avatar??"");
      await prefs.setString('phone_number', profileResponse.value.data!.mobile??"");
      //ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
    } else {
      isVisabl.value = false;
      // ScaffoldMessenger.of(context!).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.red,
      //     content: Text(profileResponse.value.message.toString()),
       // ),
      //);
    }
  }

}