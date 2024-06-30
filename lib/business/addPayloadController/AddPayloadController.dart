import 'package:energize_flutter/ui/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/CarOwnerListModel/CarOwnerListResponse.dart';
import '../../data/model/addPayloadModel/AddPayloadResponse.dart';
import '../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../../data/model/addPayloadModel/carLengthModel/CarLengthResponse.dart';
import '../../data/model/addPayloadModel/carTypeModel/CarTypeResponse.dart';
import '../../data/model/addPayloadModel/cities/CitiesResponse.dart';
import '../../data/model/updateOrderModel/UpdateResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/shipment_categories_details/shipment_category_details_screen.dart';
import '../shipmentCategoryDetailsController/ShipmentCategoryDetailsController.dart';

class AddPayloadController extends GetxController {
  Repo repo = Repo(WebService());
  var carTypeResponse = CarTypeResponse().obs;
  var carLengthResponse = CarLengthResponse().obs;
  var citiesResponse = CitiesResponse().obs;
  var branchResponse = BranchesResponse().obs;
  var addPayloadResponse = AddPayloadResponse().obs;
  var updateResponse = UpdateResponse().obs;
  var carOwnerListResponse = CarOwnerListResponse().obs;
  var isLoading=false.obs;
  var lang="";
  RxList<dynamic> carType2=[].obs;
  RxList<dynamic> carLength=[].obs;
  RxList<dynamic> cities=[].obs;
  RxList<dynamic> branches=[].obs;
  RxList<dynamic> carOwnerList=[].obs;
  Rx<bool> isVisable = false.obs;

  var token="";
  TextEditingController buyPriceController=TextEditingController();
  TextEditingController purchasingPriceController=TextEditingController();
  TextEditingController GraduationController=TextEditingController();
  TextEditingController advanceController=TextEditingController();
  TextEditingController carNumberController=TextEditingController();
  TextEditingController notesController=TextEditingController();
  TextEditingController fromLinkController=TextEditingController();
  TextEditingController ToLinkController=TextEditingController();
  var cash;
  var delay;
  int? dropdownValue2 ;
  int? launch_area ;
  int? access_area ;
  int? choose_branches ;
  int? chooseCarOwner ;
  int? dropdownValue ;
  int? DriverId;
  String? DriverName;
  String? ClientName;
  String? DelegateName;
  int? UserId;
  String? DelegateId;
  var upT;
  var accT;
  var strT;
  TypeCar? car;
  CarLength? carLeng;
  City? city;
  City? cityArrived;
  brunch? defultBranch;
  CarOwner? defultCarOwner;
  String formatteduploadTime="";
  String formattedStartTime="";
  String formattedarriveTime="";
  var role;
  final shipmentCategoryController=Get.put(ShipmentCategoryDetailsController());

  getCarType()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    role=prefs.getString("role")!;
    isLoading.value=true;
    carTypeResponse.value = await repo.getCarType(token);
    carType2.value=carTypeResponse.value.data! as List;
    car=carTypeResponse.value.data![0];
    isLoading.value=false;
    return carTypeResponse.value;
  }

  getCarLength()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    carLengthResponse.value = await repo.getCarLength(token);
    carLength.value=carLengthResponse.value.data! as List;
    carLeng=carLengthResponse.value.data![0];
    isLoading.value=false;
    return carTypeResponse.value;
  }

  getBranch()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    branchResponse.value = await repo.getBrunchesForAddPayload(token);
    isLoading.value=false;
    branches.value=branchResponse.value.data! as List;
    defultBranch=branchResponse.value.data![0];
    return branchResponse.value;
  }

  getCities()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    citiesResponse.value = await repo.getCities(token);
    cities.value=citiesResponse.value.data! as List;
    city=citiesResponse.value.data![0];
    cityArrived=citiesResponse.value.data![0];
    isLoading.value=false;
    return citiesResponse.value;
  }


  getCarOwnerList()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    isLoading.value=true;
    carOwnerListResponse.value = await repo.getCarOwner(token,"");
    carOwnerList.value=carOwnerListResponse.value.data! as List;
    isLoading.value=false;
    return carOwnerListResponse.value;
  }

  AddPayLoad(String payment,BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    if(prefs.getInt("driverId")!=null){
      DriverId=prefs.getInt("driverId")!;
    }else{
      DriverId=0;
    }
    if(prefs.getInt("delegateId")!=null) {
      DelegateId = prefs.getInt("delegateId")!.toString();
    }else{
      DelegateId="";
    }
    UserId=prefs.getInt("userId")!;
    addPayloadResponse.value = await repo.Addpayload(token,UserId!,DriverId!,dropdownValue!,launch_area!,dropdownValue2!,
        choose_branches!,access_area!,upT,strT,accT,
        buyPriceController.text,purchasingPriceController.text,GraduationController.text,advanceController.text,payment,
        carNumberController.text,notesController.text,DelegateId!,
        fromLinkController.text,ToLinkController.text,chooseCarOwner!);
    print("oopo"+addPayloadResponse.value.success.toString());
    if(addPayloadResponse.value.success==true){
      isVisable.value = false;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
      upT=null;
      accT=null;
      strT=null;
      buyPriceController.clear();
      purchasingPriceController.clear();
      GraduationController.clear();
      advanceController.clear();
      advanceController.clear();
      carNumberController.clear();
      notesController.clear();
      fromLinkController.clear();
      ToLinkController.clear();
      await prefs.remove("driverId");
      await prefs.remove("userId");
      await prefs.remove("driverName");
      DriverName=null;
      ClientName=null;
      DelegateName=null;
      chooseCarOwner=null;
      await prefs.remove("delegateName");
      await prefs.remove("userrName");
      await prefs.remove("delegateId");
    }else{
      isVisable.value = false;
    }

    return addPayloadResponse.value;
  }

  updateOrder(String payment,BuildContext context,int orderId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    if(prefs.getInt("driverId")!=null){
      DriverId=prefs.getInt("driverId")!;
    }
    if(prefs.getInt("delegateId")!=null) {
      DelegateId = prefs.getInt("delegateId")!.toString();
    }
    if(prefs.getInt("userId")!=null) {
      UserId = prefs.getInt("userId")!;
    }
    updateResponse.value = await repo.UpdateOrder(orderId,token,UserId!,DriverId!,dropdownValue!,launch_area!,dropdownValue2!,
        choose_branches!,access_area!,upT,strT,accT,
        buyPriceController.text,purchasingPriceController.text,GraduationController.text,advanceController.text,payment,
        carNumberController.text,notesController.text,DelegateId!,
        fromLinkController.text,ToLinkController.text,chooseCarOwner!);
    print("oopo"+updateResponse.value.success.toString());
    if(updateResponse.value.success==true){
      isVisable.value = false;
      Navigator.pop(context);
      shipmentCategoryController.filter(updateResponse.value.data!.status!,shipmentCategoryController.filterKey,
          shipmentCategoryController.filterStartDate,
          shipmentCategoryController.filterEndDate);
      upT=null;
      accT=null;
      strT=null;
      buyPriceController.clear();
      purchasingPriceController.clear();
      GraduationController.clear();
      advanceController.clear();
      advanceController.clear();
      carNumberController.clear();
      notesController.clear();
      await prefs.remove("driverId");
      await prefs.remove("driverName");
      await prefs.remove("delegateName");
      await prefs.remove("userrName");
      await prefs.remove("userId");
      await prefs.remove("delegateId");
    }
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) {
    //       return ShipmentCategoryDetailsScreen(appbarTitle: updateResponse.value.data!.status!, state: updateResponse.value.data!.status!);
    //     }));

    return updateResponse.value;
  }
}