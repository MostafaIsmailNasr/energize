import 'package:energize_flutter/data/model/shipmentCategoryDetailsModel/ShipmentCategoryDetailsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/reposrtsModel/ReposrtsResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../reportsController/ComprehensiveController.dart';

class ShipmentCategoryDetailsController extends GetxController {
  Repo repo = Repo(WebService());
  var shipmentCategoryDetailsResponse = ShipmentCategoryDetailsResponse().obs;
  var reportsResponse = ReportsResponse().obs;
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var token = "";
  var statuse="";
  var lang="";
  var role;
  var filterKey="";
  var filterStartDate="";
  var filterEndDate="";
  var driverId=0;
  var userId=0;
  var delegateId=0;
  var branchId=0;
  var Graduation="";
  var carNum;
  int page=1;
  var userNameId;
  var isLoadingMore=false;
  final scroll=ScrollController();
  RxList<dynamic> shipmentCategoryList=[].obs;
  TextEditingController GraduationController=TextEditingController();
  TextEditingController CarNumController=TextEditingController();

  Future<void> scrollListener()async{
    if(isLoadingMore)return;
    if(scroll.position.pixels == scroll.position.maxScrollExtent){
      isLoadingMore=true;
      page=page+1;
      await GetShipmentCategory(statuse,
          filterKey,
          filterStartDate,
          filterEndDate,
          GraduationController.text,
          CarNumController.text,page);
      isLoadingMore=false;
    }
  }



  GetShipmentCategory(String status,
      String filterType,
      String fromDate,
      String toDate,
      String graduationController,
      String CarNumController,
      int page)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    role=prefs.getString('role')!;

    userNameId=prefs.getInt("UserAdminId");
    print("eeer"+userNameId.toString());
    if(page==1){
      isLoading.value = true;
    }else{
      isLoading2.value = true;
    }
    if(prefs.getInt("driverId")!=null&&prefs.getInt("driverIdFilter")!=null){
      driverId=0;
    }
    if(prefs.getInt("driverIdFilter")!=null){
      driverId=prefs.getInt("driverIdFilter")!;
    }else{
      driverId=prefs.getInt("driverId")??0;
    }
    if(prefs.getInt("userIdFilter")!=null){
      userId=prefs.getInt("userIdFilter")!;
    }else{
      userId=prefs.getInt("userId")??0;
    }
    if(prefs.getInt("delegateIdFilter")!=null){
      delegateId=prefs.getInt("delegateIdFilter")!;
    }else{
      delegateId=prefs.getInt("delegateId")??0;
    }
    branchId=prefs.getInt("branchIdFilter")??0;

    Orders2? loadingItem;

    if (shipmentCategoryDetailsResponse.value.data?.currentPage != shipmentCategoryDetailsResponse.value.data?.lastPage) {
      loadingItem = Orders2(userName: "loading");
      shipmentCategoryList.add(loadingItem!);
    }


    var response= await repo.getShipmentCategory2(
        status,filterType,fromDate,toDate,token,userId,driverId,delegateId,
        graduationController,branchId,CarNumController,page);

    if (response != null) {
      shipmentCategoryDetailsResponse.value = response;
      List<Orders2> newData = response.data!.orders??[];

      if (loadingItem != null) {
        shipmentCategoryList.remove(loadingItem);
      }

      if (page == 1) {
        shipmentCategoryList.assignAll(newData);
      } else {
        shipmentCategoryList.addAll(newData);
      }

      isLoading.value = false;
      isLoading2.value = false;
      return response;
    }else {
      isLoading.value = false;
      isLoading2.value = false;
      return response;
    }
    // shipmentCategoryList.value=shipmentCategoryDetailsResponse.value.data?.orders! as List;
    // isLoading.value=false;
    // return shipmentCategoryDetailsResponse.value;
  }


  GetShipmentCategoryWithStatus(
      String status,
      String filterType,
      String fromDate,
      String toDate,)async{
    shipmentCategoryList.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    prefs.setInt("driverId2", 0);
    prefs.setInt("userId2", 0);
    prefs.setInt("delegateId2", 0);
    prefs.setInt("branchId", 0);
    shipmentCategoryDetailsResponse.value = await repo.getShipmentCategory2(
        status,
        filterType,
        fromDate,
        toDate,
        token,
        userId,
        driverId,
        delegateId,
        "",branchId,"",1);
    shipmentCategoryList.value=shipmentCategoryDetailsResponse.value.data!.orders! as List;
    isLoading.value=false;
    return shipmentCategoryDetailsResponse.value;
  }


  filter(String status,
      String filterType,
      String fromDate,
      String toDate,)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    prefs.setString("Graduation",GraduationController.text);
    prefs.setString("carNum",CarNumController.text);
    if(prefs.getInt("driverIdCat")!=null){
      driverId=prefs.getInt("driverIdCat")!;
    }else{
      driverId=0;
    }
    if(prefs.getInt("userIdCat")!=null){
      userId=prefs.getInt("userIdCat")!;
      print("ooo"+userId.toString());
    }else{
      userId=0;
    }
    if(prefs.getInt("delegateIdCat")!=null){
      delegateId=prefs.getInt("delegateIdCat")!;
    }else{
      delegateId=0;
    }
    if(prefs.getInt("branchIdCat")!=null){
      branchId=prefs.getInt("branchIdCat")!;
    }else{
      branchId=0;
    }
    // if(prefs.getInt("branchId")!=null){
    //   branchId=prefs.getInt("branchId")!;
    // }else{
    //   branchId=0;
    // }

    // userId=prefs.getInt("userId")!;
    // delegateId=prefs.getInt("delegateId")!;
    isLoading.value=true;
    shipmentCategoryDetailsResponse.value = await repo.getShipmentCategory2(
        status,filterType,fromDate,
        toDate,token,userId,driverId,delegateId,
        GraduationController.text,branchId,CarNumController.text,1);
    shipmentCategoryList.value=shipmentCategoryDetailsResponse.value.data!.orders! as List;
    if(shipmentCategoryDetailsResponse.value.success=true){
      isLoading.value=false;
      // prefs.setInt("driverIdCat", 0);
      // prefs.setInt("userIdCat", 0);
      // prefs.setInt("delegateIdCat", 0);
      // prefs.setInt("branchId", 0);
      GraduationController.clear();
      CarNumController.clear();
      Get.back();
    }
    return shipmentCategoryDetailsResponse.value;
  }

  filterAfterUpdateStatus(String status,
      String filterType,
      String fromDate,
      String toDate)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    Graduation=prefs.getString("Graduation")??"";
    if(prefs.getString("carNum")!=null) {
      carNum = prefs.getString("carNum");
    }else{
      carNum="";
    }
    if(prefs.getInt("driverId2")!=null){
      driverId=prefs.getInt("driverId2")!;
    }else{
      driverId=0;
    }
    if(prefs.getInt("userId2")!=null){
      userId=prefs.getInt("userId2")!;
      print("ooo"+userId.toString());
    }else{
      userId=0;
    }
    if(prefs.getInt("delegateId2")!=null){
      delegateId=prefs.getInt("delegateId2")!;
    }else{
      delegateId=0;
    }

    if(prefs.getInt("branchId")!=null){
      branchId=prefs.getInt("branchId")!;
    }else{
      branchId=0;
    }

    isLoading.value=true;
    shipmentCategoryDetailsResponse.value = await repo.getShipmentCategory2(
        status,filterType,fromDate,toDate,token,userId,
        driverId,delegateId,Graduation,branchId,carNum,1);
    shipmentCategoryList.value=shipmentCategoryDetailsResponse.value.data!.orders! as List;
    if(shipmentCategoryDetailsResponse.value.success=true){
      isLoading.value=false;
      prefs.setString("Graduation", "");
      prefs.setString("carNum", "");
      // prefs.setInt("userId2", 0);
      // prefs.setInt("delegateId2", 0);
      Get.back();
    }
    return shipmentCategoryDetailsResponse.value;
  }


}