import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/addDelegateModel/AddDelegateResponse.dart';
import '../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/menu/branches/branches_details/branches_details_screen.dart';
import '../../ui/screens/menu/branches/branches_screen.dart';
import '../../ui/screens/menu/delegate/delegate_screen.dart';

class AddDelegateController extends GetxController {
  Repo repo = Repo(WebService());
  var addDelegateResponse = AddDelegateResponse().obs;
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var token="";
  var lang="";
  var branchResponse = BranchesResponse().obs;
  var errorMessage="";
  brunch? defultBranch;
  RxList<dynamic> branches=[].obs;
  TextEditingController delegate_nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  int? choose_branches;
  Rx<bool> obscureText = true.obs;
  Rx<bool> obscureText2 = true.obs;
  Rx<bool> isVisabl = false.obs;
  Rx<int> isActive = 1.obs;

  AddDelegate(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      addDelegateResponse.value = await repo.CreateDelegate(
          delegate_nameController.text,
          phoneController.text,
          choose_branches!,
          passwordController.text,
          confirmPasswordController.text,
      isActive.value);
    if (addDelegateResponse.value.message ==null) {
      isVisabl.value = false; //'/delegate_screen'
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return DelegateScreen();
          }));
      //Navigator.pushNamed(context,'/delegate_screen');
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      delegate_nameController.clear();
    }
    else {
        errorMessage = addDelegateResponse.value.message!;
        isVisabl.value = false;
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
    }
  }

  getBranch()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    isLoading.value=true;
    branchResponse.value = await repo.getBrunchesForAddPayload(token);
    isLoading.value=false;
    branches.value=branchResponse.value.data! as List;
    defultBranch=branchResponse.value.data![0];
    choose_branches=branchResponse.value.data![0].id;
    return branchResponse.value;
  }

  AddDelegateForBranch(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    addDelegateResponse.value = await repo.CreateDelegate(
        delegate_nameController.text,
        phoneController.text,
        choose_branches!,
        passwordController.text,
        confirmPasswordController.text,isActive.value);
    if (addDelegateResponse.value.message ==null) {
      isVisabl.value = false; //'/delegate_screen'
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return BranchesScreen();
          }));
      //Navigator.pushNamed(context,'/delegate_screen');
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      delegate_nameController.clear();

    } else {
      errorMessage = addDelegateResponse.value.message!;
      isVisabl.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}