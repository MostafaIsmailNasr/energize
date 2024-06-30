import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/loginModel/LoginResponse.dart';
import '../../data/model/updateTokenModel/UpdateTokenResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class LoginController extends GetxController {
  Repo repo = Repo(WebService());
  Rx<bool> obscureText = true.obs;
  Rx<bool> isVisable = false.obs;
  bool isLogin = false;
  var errorMessage = "";
  var loginResponse = LoginResponse().obs;
  var updateTokenResponse = UpdateTokenResponse().obs;
  TextEditingController phoneController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  var token = "";
  var lang = "";
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() async {
    getToken();
    //retrieveFCMToken();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString('lang')!;
    super.onInit();
  }

  void getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print("tokeen is " + token!);
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
      print(fcmToken);
    })
        .onError((err) {
      print("Error getting token");
    });
  }



  loginUse(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    loginResponse.value = await repo.loginUse(phoneController.text, PasswordController.text);

    if (loginResponse.value.success == true) {
      await prefs.setString("loginResponse", loginResponse.value.data!.toJson().toString());
      await prefs.setBool("status", loginResponse.value.success!);
      isLogin = true;
      await prefs.setBool("isLogin", isLogin!);
      await prefs.setString('full_name', loginResponse.value.data!.name!);
      await prefs.setInt('id', loginResponse.value.data!.id!);
      await prefs.setInt('UserAdminId', loginResponse.value.data!.id!);
      await prefs.setString('picture', loginResponse.value.data!.avatar!);
      await prefs.setString('phone_number', loginResponse.value.data!.mobile!);
      await prefs.setString('tokenUser', loginResponse.value.data!.token!);
      await prefs.setString('role', loginResponse.value.data!.role!);
      //updateToken();
      updateToken();
      Navigator.pushNamedAndRemoveUntil(context,'/home_screen',ModalRoute.withName('/home_screen'));
      //Navigator.pushNamed(context, "/home_screen");
      phoneController.clear();
      PasswordController.clear();
      isVisable.value = false;
    } else {
        isVisable.value = false;
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(loginResponse.value.message!),
          ),
        );
    }
    //print("object222" + lang);
  }


  updateToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString('tokenUser')!;
    updateTokenResponse.value = (await repo.UpdateToken(userToken, token))!;
  }
}