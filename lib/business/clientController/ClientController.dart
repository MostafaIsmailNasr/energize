import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import '../../data/model/deletModel/deletResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/menu/clients/clients_screen.dart';

class UserController extends GetxController {
  Repo repo = Repo(WebService());
  var chooseUserResponse = ChooseUserRespose().obs;
  var deletResponse = DeletResponse().obs;
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var token="";
  var lang="";
  var role;
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
      await getUserList(page,"");
      isLoadingMore=false;
    }
  }
  getUserList(int page,String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("tokenUser")!;
    lang = prefs.getString('lang')!;
    role = prefs.getString('role')!;
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

    var response = await repo.chooseUserToAddpayload(token, word, page);

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
  /*getUserList(int page)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    role=prefs.getString('role')!;
    isLoading.value=true;

    ChooseUser? loadingItem;
    if(chooseUserResponse.value.currentPage!=chooseUserResponse.value.lastPage){
      loadingItem=ChooseUser(name:"loading");
      UserList.add(loadingItem!);
    }
    chooseUserResponse.value = await repo.chooseUserToAddpayload(token,"",page,10);
      UserList.value=chooseUserResponse.value.data! as List;
      UserList.value.addAll(chooseUserResponse.value.data!);
    if(loadingItem!=null){
      UserList.remove(loadingItem);
    }
    //UserList.value=chooseUserResponse.value.data! as List;
    //car=carTypeResponse.value.data![0];
    isLoading.value=false;
    return chooseUserResponse.value;
  }*/

  delete(BuildContext context,String token)async{
    isLoading.value=true;
    deletResponse.value=await repo.delete(token);
    isLoading.value=false;
    Get.back();
    getUserList(page,"");
    return deletResponse.value;
  }
}