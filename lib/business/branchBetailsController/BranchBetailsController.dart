import 'package:energize_flutter/data/model/addPayloadModel/chooseDriverModel/ChooseDriverResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/delegateModel/DelegateResponse.dart';
import '../../data/model/deletModel/deletResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class BranchDetailsController extends GetxController {
  Repo repo = Repo(WebService());
  var delegateResponse = DelegateResponse().obs;
  var deletResponse = DeletResponse().obs;
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var lang="";
  var role;
  var tittle;
  var BId;
  int page=1;
  var branchIds;
  var isLoadingMore=false;
  final scroll=ScrollController();
  RxList<dynamic> DelegateList=[].obs;
  TextEditingController searchController=TextEditingController();

  Future<void> scrollListener()async{
    if(isLoadingMore)return;
    if(scroll.position.pixels == scroll.position.maxScrollExtent){
      isLoadingMore=true;
      page=page+1;
      await getDelegateList(branchIds,page,"");
      isLoadingMore=false;
    }
  }



  getDelegateList(int branchId,int page,String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
    role= prefs.getString('role')!;
    tittle= prefs.getString('titel')!;
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

    var response = await repo.getDelegatesOfBranch(branchId,"all", word, page);

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    BId=prefs.getInt("BId");
    deletResponse.value=await repo.delete(token);
    isLoading.value=false;
    Get.back();
    getDelegateList(BId,1,"");
    return deletResponse.value;
  }
}