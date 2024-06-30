import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/updateStatesModel/UpdateStatesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/shipment_categories_details/shipment_category_details_screen.dart';
import '../../ui/screens/shipment_details/shipment_details_screen.dart';
import '../shipmentCategoryDetailsController/ShipmentCategoryDetailsController.dart';

class UpdateStatusController extends GetxController {
  Repo repo = Repo(WebService());
  var updateStatusResponse = UpdateStatesResponse().obs;
  var isLoading = false.obs;
  var token = "";
  var status="";
  Rx<bool> isVisable = false.obs;
  final shipmentCategoryController=Get.put(ShipmentCategoryDetailsController());

  UpdateStatus(BuildContext context,int id,String state)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    updateStatusResponse.value = await repo.updateStatus(token,state,id);
    if(updateStatusResponse.value.success==true){
      isVisable.value=false;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return ShipmentDetailsScreen();
          }));
    }
    isLoading.value=false;
    return updateStatusResponse.value;
  }

  UpdateStatus2(BuildContext context,int id,String state)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    var Homestate= prefs.getString("HomeStatus")!;
    isLoading.value=true;
    updateStatusResponse.value = await repo.updateStatus(token,state,id);
    if(updateStatusResponse.value.success==true){
      isVisable.value=false;
      Get.back();
      shipmentCategoryController.filterAfterUpdateStatus(
          //status,
          Homestate,
          shipmentCategoryController.filterKey,
          shipmentCategoryController.filterStartDate,
          shipmentCategoryController.filterEndDate);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) {
      //       return ShipmentCategoryDetailsScreen(appbarTitle: state, state:Homestate);
      //     }));
    }
    isLoading.value=false;
    return updateStatusResponse.value;
  }
}