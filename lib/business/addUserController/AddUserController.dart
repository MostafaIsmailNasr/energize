import 'package:energize_flutter/data/model/addUserModel/AddUserResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class AddUserController extends GetxController {
  Repo repo = Repo(WebService());
  var addUserResponse = AddUserResponse().obs;
  var isLoading=false.obs;
  var errorMessage="";
  var lang="";
  TextEditingController clientNameController=TextEditingController();
  TextEditingController managerNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  Rx<bool> obscureText = true.obs;
  Rx<bool> obscureText2 = true.obs;
  Rx<bool> isVisabl = false.obs;

  getLang()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
  }

  AddUser(BuildContext context)async{
    addUserResponse.value = await repo.CreateUser(
        clientNameController.text,
        phoneController.text,
        managerNameController.text,
        passwordController.text,
        confirmPasswordController.text);
    if (addUserResponse.value.message ==null) {
      isVisabl.value = false; //'/delegate_screen'
      Navigator.pushNamed(context,'/clients_screen');
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      managerNameController.clear();
      clientNameController.clear();

    } else {
      errorMessage = addUserResponse.value.message!;
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