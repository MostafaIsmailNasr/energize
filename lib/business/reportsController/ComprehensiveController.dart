import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/addPayloadModel/carTypeModel/CarTypeResponse.dart';
import '../../data/model/addPayloadModel/cities/CitiesResponse.dart';
import '../../data/model/reposrtsModel/ReposrtsResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class ComprehensiveController extends GetxController {
  Repo repo = Repo(WebService());
  var reportsResponse = ReportsResponse().obs;
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var token = "";
  var filterKey = "";
  var filterStartDate = "";
  var filterEndDate = "";
  var filterKeyCus = "";
  var filterStartDateCus = "";
  var filterEndDateCus = "";
  var lang="";
  var driverId = 0;
  var userId = 0;
  var delegateId = 0;
  var isButtonEnabled;
  RxList<dynamic> comprehensiveList = [].obs;
  RxList<dynamic> customerList = [].obs;
  var citiesResponse = CitiesResponse().obs;
  RxList<dynamic> cities=[].obs;
  City? city;
  City? cityArrived;
  int? launch_area=0 ;
  int? access_area=0 ;
  var carTypeResponse = CarTypeResponse().obs;
  RxList<dynamic> carType2=[].obs;
  TypeCar? car;
  int? dropdownValue=0;

  getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
  }

  getComprehensiveReports(
      String filterType,
      String fromDate,
      String toDate,
      int startAreaId,int reachAreaId,int carTypeId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    reportsResponse.value = await repo.ComprehensiveReports(
        filterType,
        fromDate,
        toDate,
        token,
        userId,
        driverId,
        delegateId,
        startAreaId,
        reachAreaId,
        carTypeId);
    comprehensiveList.value=reportsResponse.value.data?.orders! as List;
    isLoading.value=false;
    return reportsResponse.value;
  }

  getCustomerReports(
      String filterType,
      String fromDate,
      String toDate,
      int startAreaId,int reachAreaId,int carTypeId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    isLoading.value=true;
    reportsResponse.value = await repo.customerReports(
        filterType,
        fromDate,
        toDate,
        token,
        userId,
        driverId,
        delegateId,
        startAreaId,
        reachAreaId,
        carTypeId);
    customerList.value=reportsResponse.value.data?.orders! as List;
    isLoading.value=false;
    return reportsResponse.value;
  }

  filterInReports(
      String filterType,
      String fromDate,
      String toDate,int startAreaId,int reachAreaId,int carTypeId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    if(prefs.getInt("driverIdReport")!=null){
      driverId=prefs.getInt("driverIdReport")!;
    }else{
      driverId=0;
    }
    if(prefs.getInt("userIdReport")!=null){
      userId=prefs.getInt("userIdReport")!;
    }else{
      userId=0;
    }
    if(prefs.getInt("delegateIdReport")!=null){
      delegateId=prefs.getInt("delegateIdReport")!;
    }else{
      delegateId=0;
    }
    lang= prefs.getString('lang')!;
    isLoading.value=true;

    reportsResponse.value = await repo.ComprehensiveReports(
        filterType,fromDate,toDate,
        token,
        userId,
        driverId,
        delegateId,
        startAreaId,
        reachAreaId,
        carTypeId);
    comprehensiveList.value=reportsResponse.value.data!.orders! as List;
    if(reportsResponse.value.success=true){
      isLoading.value=false;
      prefs.setInt("driverIdReport", 0);
      prefs.setInt("userIdReport", 0);
      prefs.setInt("delegateIdReport", 0);
      launch_area=0;
      access_area=0;
      dropdownValue=0;
      Get.back();
    }
    return reportsResponse.value;
  }

  filterInCustomerReports(
      String filterType,
      String fromDate,
      String toDate,
      int startAreaId,int reachAreaId,int carTypeId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    // driverId=prefs.getInt("driverId")!;
    // userId=prefs.getInt("userId")!;
    // delegateId=prefs.getInt("delegateId")!;
    lang= prefs.getString('lang')!;
    isLoading.value=true;
    reportsResponse.value = await repo.customerReports(
        filterType,
        fromDate,
        toDate,
        token,
        userId,
        driverId,
        delegateId,
        startAreaId,
        reachAreaId,
        carTypeId);
    customerList.value=reportsResponse.value.data!.orders! as List;
    if(reportsResponse.value.success=true){
      isLoading.value=false;
      // prefs.setInt("driverId", 0);
      // prefs.setInt("userId", 0);
      // prefs.setInt("delegateId", 0);
      launch_area=0;
      access_area=0;
      dropdownValue=0;
      Get.back();
    }
    return reportsResponse.value;
  }

  getCities()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    citiesResponse.value = await repo.getCities(token);
    cities.value=citiesResponse.value.data as List;
    city=citiesResponse.value.data![0];
    cityArrived=citiesResponse.value.data![0];
    isLoading.value=false;
    return citiesResponse.value;
  }

  getCarType()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    isLoading.value=true;
    carTypeResponse.value = await repo.getCarType(token);
    carType2.value=carTypeResponse.value.data! as List;
    car=carTypeResponse.value.data![0];
    isLoading.value=false;
    return carTypeResponse.value;
  }


}