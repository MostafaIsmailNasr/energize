import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../../data/model/createBranchModel/CreateBranchResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class BranchController extends GetxController {
  Repo repo = Repo(WebService());
  var branchResponse = BranchesResponse().obs;
  var createBranchResponse = CreateBranchResponse().obs;
  RxList<dynamic> branches=[].obs;
  var isLoading=false.obs;
  var lang="";
  var role;
  var token="";
  var filterId;
  TextEditingController searchController=TextEditingController();

  getLang()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
  }

  getBranch()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    role= prefs.getString('role')!;
    isLoading.value=true;
    branchResponse.value = await repo.getBrunchesForAddPayload(token);
    isLoading.value=false;
    branches.value=branchResponse.value.data! as List;
    return branchResponse.value;
  }
  CreateBranch(String name,BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    createBranchResponse.value = await repo.CreateBranch(name,token);
    Navigator.pushNamed(context, "/branches_screen");
    isLoading.value=false;
    return createBranchResponse.value;
  }
}