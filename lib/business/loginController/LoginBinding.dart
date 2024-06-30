import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'LoginController.dart';



class LoginBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}