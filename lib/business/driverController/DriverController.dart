import 'package:energize_flutter/data/model/addPayloadModel/chooseDriverModel/ChooseDriverResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../conustant/ToastClass.dart';
import '../../data/model/deletModel/deletResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class DriverController extends GetxController {
  Repo repo = Repo(WebService());
  var chooseDriverResponse = ChooseDriverRespose().obs;
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var lang="";
  var role;
  var deletResponse = DeletResponse().obs;
  var token="";
  int page=1;
  var isLoadingMore=false;
  final scroll=ScrollController();
  RxList<dynamic> DriverList=[].obs;
  TextEditingController searchController=TextEditingController();

  Future<void> scrollListener()async{
    if(isLoadingMore)return;
    if(scroll.position.pixels == scroll.position.maxScrollExtent){
      isLoadingMore=true;
      page=page+1;
      await getDriverList(page,"");
      isLoadingMore=false;
    }
  }


  getDriverList(int page,String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    role=prefs.getString('role')!;
    if(page==1){
      isLoading.value = true;
    }else{
      isLoading2.value = true;
    }


    ChooseDriver? loadingItem;

    if (chooseDriverResponse.value.currentPage != chooseDriverResponse.value.lastPage) {
      loadingItem = ChooseDriver(name: "loading");
      DriverList.add(loadingItem!);
    }

    var response = await repo.chooseDriverToAddpayload(token, word, "all",page);

    if (response != null) {
      chooseDriverResponse.value = response;
      List<ChooseDriver> newData = response.data ?? [];

      if (loadingItem != null) {
        DriverList.remove(loadingItem);
      }

      if (page == 1) {
        DriverList.assignAll(newData);
      } else {
        DriverList.addAll(newData);
      }

      isLoading.value = false;
      isLoading2.value = false;
      return response;
    } else {
      isLoading.value = false;
      isLoading2.value = false;
      return response;
    }
  }

  delete(BuildContext context,String token)async{
    isLoading.value=true;
    deletResponse.value=await repo.delete(token);
    if(deletResponse.value.success==true){
      isLoading.value=false;
      Get.back();
      getDriverList(page,"");
      return deletResponse.value;
    }else {
      isLoading.value=false;
      Get.back();
      ToastClass.showCustomToast(context, deletResponse.value.message!, 'error');

    }
  }
}