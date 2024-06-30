import 'package:energize_flutter/data/model/updateUserModel/UpdateUserResponse.dart';
import 'package:energize_flutter/ui/screens/menu/clients/clients_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class UpdateUserController extends GetxController {
  Repo repo = Repo(WebService());
  var updateUserResponse = UpdateUserResponse().obs;
  var isLoading = false.obs;
  var errorMessage = "";
  var isLoading2 = false.obs;
  var userToken = "";
  var token = "";
  var lang="";
  TextEditingController clientNameController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rx<bool> obscureText = true.obs;
  Rx<bool> obscureText2 = true.obs;
  Rx<bool> isVisabl = false.obs;
  var name = "";
  var phone = "";
  var manager = "";

  getData() async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("userName")!;
    phone = prefs.getString("userPhone")!;
    manager = prefs.getString("userManager")!;
    clientNameController.text = name;
    phoneController.text = phone;
    managerNameController.text = manager;
    userToken = prefs.getString("UserToken")!;
    lang= prefs.getString('lang')!;
    isLoading.value = false;
  }


  updateUser(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("tokenUser")!;
    updateUserResponse.value = await repo.UpdateUser(
        clientNameController.text,
        phoneController.text,
        managerNameController.text,
        passwordController.text,
        confirmPasswordController.text, userToken);
    if (updateUserResponse.value.message == null) {
      isVisabl.value = false; //'/delegate_screen'
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return ClientScreen();
          }));
      //Navigator.pushNamed(context,'/delegate_screen');
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      clientNameController.clear();
      managerNameController.clear();
    } else {
      errorMessage = updateUserResponse.value.message!;
      isVisabl.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
