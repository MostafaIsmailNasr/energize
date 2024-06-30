import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/notificationModel/NotificationResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class NotificationController extends GetxController {
  Repo repo = Repo(WebService());
  var notificationResponse = NotificationResponse().obs;
  var isLoading = false.obs;
  var token = "";
  var lang = "";
  List<Notifications> allNotifications=[];

  getNotification()async{
    isLoading.value=true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    notificationResponse.value=(await repo.getNotification(token))!;
    if(notificationResponse.value.success==true){
      isLoading.value=false;
      allNotifications=notificationResponse.value.data!;
      return notificationResponse.value;
    }
  }
}