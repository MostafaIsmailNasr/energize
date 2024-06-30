import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../conustant/ToastClass.dart';
import '../../data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import '../../data/model/addPayloadModel/cities/CitiesResponse.dart';
import '../../data/model/createCityModel/CreateCityResponse.dart';
import '../../data/model/deletModel/deletResponse.dart';
import '../../data/model/deleteCityModel/DeleteCityResponse.dart';
import '../../data/model/updateCityModel/UpdateCityResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/menu/clients/clients_screen.dart';

class CityController extends GetxController {
  Repo repo = Repo(WebService());
  var citiesResponse = CitiesResponse().obs;
  var createCityResponse = CreateCityResponse().obs;
  var updateCityResponse = UpdateCityResponse().obs;
  var deletResponse = DeleteCityResponse().obs;
  var isLoading=false.obs;
  var token="";
  var lang="";
  var role;
  var cityName;
  Rx<bool> isVisable = false.obs;
  RxList<dynamic> cities=[].obs;
  TextEditingController searchController=TextEditingController();
  TextEditingController cityNameController=TextEditingController();

  getLang() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
    cityName=prefs.getString("cityName")!;
    cityNameController.text=cityName;
  }

  getCities()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    role=prefs.getString('role')!;
    isLoading.value=true;
    citiesResponse.value = await repo.getCities(token);
    cities.value=citiesResponse.value.data! as List;
    isLoading.value=false;
    return citiesResponse.value;
  }

  createCity(String name,BuildContext context)async{
    isLoading.value=true;
    createCityResponse.value = await repo.createCity(name);
    if(createCityResponse.value.success==true){
      Navigator.pop(context);
      getCities();
      //Navigator.pushNamed(context, "/cities_screen");
      isLoading.value=false;
      return createCityResponse.value;
    }
  }

  updateCity(BuildContext context,int id)async{
    isLoading.value=true;
    updateCityResponse.value = await repo.updateCity(cityNameController.text,id);
    if(updateCityResponse.value.success==true){
      isVisable.value=false;
      Navigator.pop(context);
      getCities();
    }
    isLoading.value=false;
    return updateCityResponse.value;
  }



 deleteCity(int id,BuildContext context)async{
    isLoading.value=true;
    deletResponse.value=await repo.deleteCity(id);
    if(deletResponse.value.success==true){
      isLoading.value=false;
      Get.back();
      getCities();
      return deletResponse.value;
    }else {
      isLoading.value=false;
      Get.back();
      ToastClass.showCustomToast(context, deletResponse.value.message!, 'error');

    }
  }
}