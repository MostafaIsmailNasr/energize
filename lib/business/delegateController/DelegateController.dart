import 'package:energize_flutter/data/model/delegateModel/DelegateResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../conustant/ToastClass.dart';
import '../../data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import '../../data/model/deletModel/deletResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class DelegateController extends GetxController {
  Repo repo = Repo(WebService());
  var delegateResponse = DelegateResponse().obs;
  var deletResponse = DeletResponse().obs;
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var lang="";
  var role;
  int page=1;
  var isLoadingMore=false;
  final scroll=ScrollController();
  RxList<dynamic> DelegateList=[].obs;
  TextEditingController searchController=TextEditingController();

  Future<void> scrollListener()async{
    if(isLoadingMore)return;
    if(scroll.position.pixels == scroll.position.maxScrollExtent){
      isLoadingMore=true;
      page=page+1;
      await getDelegateList(page,"");
      isLoadingMore=false;
    }
  }

  // getDelegateList()async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   lang= prefs.getString('lang')!;
  //   role= prefs.getString('role')!;
  //   isLoading.value=true;
  //   delegateResponse.value = await repo.getDelegates("all");
  //   DelegateList.value=delegateResponse.value.data! as List;
  //   //car=carTypeResponse.value.data![0];
  //   isLoading.value=false;
  //   return delegateResponse.value;
  // }

  getDelegateList(int page,String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      lang= prefs.getString('lang')!;
      role= prefs.getString('role')!;
    if(page==1){
      isLoading.value = true;
    }else{
      isLoading2.value = true;
    }

    Delegate? loadingItem;

    if (delegateResponse.value.currentPage != delegateResponse.value.lastPage) {
      loadingItem = Delegate(name: "loading");
      DelegateList.add(loadingItem!);
    }

    var response = await repo.getDelegates("all", word, page);

    if (response != null) {
      delegateResponse.value = response;
      List<Delegate> newData = response.data ?? [];

      if (loadingItem != null) {
        DelegateList.remove(loadingItem);
      }

      if (page == 1) {
        DelegateList.assignAll(newData);
      } else {
        DelegateList.addAll(newData);
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
      getDelegateList(1,"");
      return deletResponse.value;
    }else {
      isLoading.value=false;
      Get.back();
      // ignore: use_build_context_synchronously
      ToastClass.showCustomToast(context, deletResponse.value.message!, 'error');

    }
  }
}