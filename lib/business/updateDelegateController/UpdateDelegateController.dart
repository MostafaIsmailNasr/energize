import 'package:energize_flutter/data/model/updateDelegateModel/UpdateDelegateResponse.dart';
import 'package:energize_flutter/ui/screens/menu/delegate/delegate_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/menu/branches/branches_details/branches_details_screen.dart';
import '../addDelegateController/AddDelegateController.dart';
import '../delegateController/DelegateController.dart';

class UpdateDelegateController extends GetxController {
  Repo repo = Repo(WebService());
  var updateDelegateResponse = UpdateDelegateResponse().obs;
  var isLoading=false.obs;
  var errorMessage="";
  var isLoading2=false.obs;
  var token="";
  var lang="";
  var delegateToken="";
  var branchResponse = BranchesResponse().obs;
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
  var name="";
  var phone="";
  Rx<int> isActive = 1.obs;
  final delegateController=Get.put(AddDelegateController());


  getBranch()async{
    isLoading.value=true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    name=prefs.getString("delegateName")!;
    phone=prefs.getString("delegatePhone")!;
    choose_branches=prefs.getInt("delegateBranchId")!;
    lang= prefs.getString('lang')!;
    delegate_nameController.text=name;
    phoneController.text=phone;
    delegateToken=prefs.getString("delegateToken")!;
    isActive.value=prefs.getInt("filterStatus")!;
    branchResponse.value = await repo.getBrunchesForAddPayload(token);
    branches.value=branchResponse.value.data! as List;
    defultBranch=branchResponse.value.data![0];
    isLoading.value=false;
    return branchResponse.value;
  }

  getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    name=prefs.getString("delegateName")!;
    phone=prefs.getString("delegatePhone")!;
    choose_branches=prefs.getInt("delegateBranchId")!;
    delegate_nameController.text=name;
    phoneController.text=phone;
    delegateToken=prefs.getString("delegateToken")!;
    isActive.value=prefs.getInt("filterStatusBranch")!;
  }


  updateDelegate(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    updateDelegateResponse.value = await repo.UpdateDelegate(
        delegate_nameController.text,
        phoneController.text,
        choose_branches!,
        passwordController.text,
        confirmPasswordController.text,delegateToken,isActive.value);
    if (updateDelegateResponse.value.message ==null) {
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

    } else {
      errorMessage = updateDelegateResponse.value.message!;
      isVisabl.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  updateDelegateForBranch(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    updateDelegateResponse.value = await repo.UpdateDelegate(
        delegate_nameController.text,
        phoneController.text,
        choose_branches!,
        passwordController.text,
        confirmPasswordController.text,delegateToken,isActive.value);
    if (updateDelegateResponse.value.message ==null) {
      isVisabl.value = false; //'/delegate_screen'
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return BranchesBetailsScreen(branchId: choose_branches!,);
          }));
      //Navigator.pushNamed(context,'/delegate_screen');
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      delegate_nameController.clear();

    } else {
      errorMessage = updateDelegateResponse.value.message!;
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