import 'package:energize_flutter/data/model/chooseDelegateModel/ChooseDelegateResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/changeDelegateModel/ChangeDelegateResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class ChooseDelegateController extends GetxController{
  Repo repo = Repo(WebService());
  var chooseDelegateResponse = ChooseDelegateResponse().obs;
  var changeDelegateFilterResponse=ChangeDelegateFilterResponse().obs;
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var token="";
  var filterId;
  var id;
  var name;
  var lang="";
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
      await ChooseDelegateList(page,"");
      isLoadingMore=false;
    }
  }

  // ChooseDelegateList()async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token=prefs.getString("tokenUser")!;
  //   lang= prefs.getString('lang')!;
  //   isLoading.value=true;
  //   chooseDelegateResponse.value = await repo.chooseDelegate(token,"");
  //   DelegateList.value=chooseDelegateResponse.value.data! as List;
  //   isLoading.value=false;
  //   return chooseDelegateResponse.value;
  // }

  ChooseDelegateList(int page,String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token= prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    if(page==1){
      isLoading.value = true;
    }else{
      isLoading2.value = true;
    }


    ChooseDelegate? loadingItem;

    if (chooseDelegateResponse.value.currentPage != chooseDelegateResponse.value.lastPage) {
      loadingItem = ChooseDelegate(name: "loading");
      DelegateList.add(loadingItem!);
    }

    var response = await repo.chooseDelegate(token, word,page);

    if (response != null) {
      chooseDelegateResponse.value = response;
      List<ChooseDelegate> newData = response.data ?? [];

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

  ChooseDelegateFilter(int delegateId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    var IdOrder=prefs.getInt("IdOrder")!;
    changeDelegateFilterResponse.value=await repo.changeDelegateFilter(token, IdOrder, delegateId);
    if(changeDelegateFilterResponse.value.success==true){
      Get.back();
    }
    return chooseDelegateResponse.value;
  }
}