
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../conustant/ToastClass.dart';
import '../../data/model/CarOwnerListModel/CarOwnerListResponse.dart';
import '../../data/model/DeleteCarOwnerModel/DeleteCarOwnerResponse.dart';
import '../../data/model/addCarOwnerModel/AddCarOwnerResponse.dart';
import '../../data/model/updateCarOwnerModel/UpdateCarOwnerResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/menu/carOwner/car_owner_screen.dart';

class CarOwnerController extends GetxController {
  Repo repo = Repo(WebService());
  var carOwnerListResponse = CarOwnerListResponse().obs;
  var addCarOwnerResponse = AddCarOwnerResponse().obs;
  var deleteCarOwnerResponse = DeleteCarOwnerResponse().obs;
  var updateCarOwnerResponse = UpdateCarOwnerResponse().obs;
  var isLoading=false.obs;
  var lang="";
  var token="";
  TextEditingController searchController=TextEditingController();
  TextEditingController ownerNameController=TextEditingController();
  TextEditingController ownerPhoneController=TextEditingController();
  TextEditingController ownerNameUpController=TextEditingController();
  TextEditingController ownerPhoneUpController=TextEditingController();
  RxList<dynamic> carOwnerList=[].obs;
  Rx<bool> isVisabl = false.obs;
  var errorMessage="";
  var carOwnerId;

  getLang() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
  }

  getCarOwnerList(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    // role=prefs.getString('role')!;
    isLoading.value=true;
    carOwnerListResponse.value = await repo.getCarOwner(token,value);
    carOwnerList.value=carOwnerListResponse.value.data! as List;
    isLoading.value=false;
    return carOwnerListResponse.value;
  }

  AddCarOwner(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    addCarOwnerResponse.value = await repo.addCarOwner(
        ownerNameController.text,
        ownerPhoneController.text,
        token);
    if (addCarOwnerResponse.value.success ==true) {
      isVisabl.value = false; //'/delegate_screen'
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return CarOwnerScreen();
          }));
      ownerNameController.clear();
      ownerPhoneController.clear();
    }
    else {
      errorMessage = addCarOwnerResponse.value.message;
      isVisabl.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  deleteCarOwner(BuildContext context,int id)async{
    isLoading.value=true;
    deleteCarOwnerResponse.value=await repo.deleteCarOwner(token,id);
    if(deleteCarOwnerResponse.value.success==true){
      isLoading.value=false;
      Get.back();
      getCarOwnerList("");
      return deleteCarOwnerResponse.value;
    }else {
      isLoading.value=false;
      Get.back();
      // ignore: use_build_context_synchronously
      ToastClass.showCustomToast(context, deleteCarOwnerResponse.value.message!, 'error');
    }
  }

  updateCarOwner(BuildContext context,int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("tokenUser")!;
    updateCarOwnerResponse.value = await repo.updateCarOwner(
        token,id,ownerNameUpController.text,ownerPhoneUpController.text);
    if (updateCarOwnerResponse.value.message == null) {
      isVisabl.value = false; //'/delegate_screen'
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return CarOwnerScreen();
          }));
      ownerNameUpController.clear();
      ownerPhoneUpController.clear();
    } else {
      errorMessage = updateCarOwnerResponse.value.message!;
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