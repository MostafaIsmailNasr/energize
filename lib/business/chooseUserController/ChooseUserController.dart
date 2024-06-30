import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class ChooseUserController extends GetxController {
  Repo repo = Repo(WebService());
  var chooseUserResponse = ChooseUserRespose().obs;
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var lang="";
  var token="";
  var id;
  var name;
  var FilterId;
  int page=1;
  var isLoadingMore=false;
  final scroll=ScrollController();
  RxList<dynamic> UserList=[].obs;
  TextEditingController searchController=TextEditingController();

  Future<void> scrollListener()async{
    if(isLoadingMore)return;
    if(scroll.position.pixels == scroll.position.maxScrollExtent){
      isLoadingMore=true;
      page=page+1;
      await ChooseUserList(page,"");
      isLoadingMore=false;
    }
  }

  // ChooseUserList()async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token=prefs.getString("tokenUser")!;
  //   lang= await prefs.getString('lang')!;
  //   isLoading.value=true;
  //   ///paganation
  //   chooseUserResponse.value = await repo.chooseUserToAddpayload(token,searchController.text,1,);
  //   UserList.value=chooseUserResponse.value.data as List;
  //   //car=carTypeResponse.value.data![0];
  //   isLoading.value=false;
  //   return chooseUserResponse.value;
  // }

  ChooseUserList(int page,String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token= prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    if(page==1){
      isLoading.value = true;
    }else{
      isLoading2.value = true;
    }


    ChooseUser? loadingItem;

    if (chooseUserResponse.value.currentPage != chooseUserResponse.value.lastPage) {
      loadingItem = ChooseUser(name: "loading");
      UserList.add(loadingItem!);
    }

    var response = await repo.chooseUserToAddpayload(token, word,page);

    if (response != null) {
      chooseUserResponse.value = response;
      List<ChooseUser> newData = response.data ?? [];

      if (loadingItem != null) {
        UserList.remove(loadingItem);
      }

      if (page == 1) {
        UserList.assignAll(newData);
      } else {
        UserList.addAll(newData);
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
}