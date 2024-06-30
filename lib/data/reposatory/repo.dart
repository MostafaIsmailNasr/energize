import 'package:flutter/cupertino.dart';

import '../model/CarOwnerListModel/CarOwnerListResponse.dart';
import '../model/CategoryDetailsModel/CategoryDetailsResponse.dart';
import '../model/DeleteCarOwnerModel/DeleteCarOwnerResponse.dart';
import '../model/addCarOwnerModel/AddCarOwnerResponse.dart';
import '../model/addDelegateModel/AddDelegateResponse.dart';
import '../model/addDriverModel/AddDriverResponse.dart';
import '../model/addPayloadModel/AddPayloadResponse.dart';
import '../model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../model/addPayloadModel/carLengthModel/CarLengthResponse.dart';
import '../model/addPayloadModel/carTypeModel/CarTypeResponse.dart';
import '../model/addPayloadModel/chooseDriverModel/ChooseDriverResponse.dart';
import '../model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import '../model/addPayloadModel/cities/CitiesResponse.dart';
import '../model/addUserModel/AddUserResponse.dart';
import '../model/changeDelegateModel/ChangeDelegateResponse.dart';
import '../model/chooseDelegateModel/ChooseDelegateResponse.dart';
import '../model/createBranchModel/CreateBranchResponse.dart';
import '../model/createCityModel/CreateCityResponse.dart';
import '../model/createNotesModel/CreateNotesResponse.dart';
import '../model/delegateModel/DelegateResponse.dart';
import '../model/deletModel/deletResponse.dart';
import '../model/deleteCityModel/DeleteCityResponse.dart';
import '../model/deleteNoteModel/DeleteNoteResponse.dart';
import '../model/homeModel/HomeResponse.dart';
import '../model/loginModel/LoginResponse.dart';
import '../model/notesModel/NotesResponse.dart';
import '../model/notificationModel/NotificationResponse.dart';
import '../model/profileModel/ProfileResponse.dart';
import '../model/reposrtsModel/ReposrtsResponse.dart';
import '../model/shipmentCategoryDetailsModel/ShipmentCategoryDetailsResponse.dart';
import '../model/updateCarOwnerModel/UpdateCarOwnerResponse.dart';
import '../model/updateCityModel/UpdateCityResponse.dart';
import '../model/updateDelegateModel/UpdateDelegateResponse.dart';
import '../model/updateDriverModel/UpdateDriverResponse.dart';
import '../model/updateNoteModel/UpdateNotesResponse.dart';
import '../model/updateOrderModel/UpdateResponse.dart';
import '../model/updateStatesModel/UpdateStatesResponse.dart';
import '../model/updateTokenModel/UpdateTokenResponse.dart';
import '../model/updateUserModel/UpdateUserResponse.dart';
import '../model/uploadShipmentImageModel/UploadShipmentImageResponse.dart';
import '../web_service/WebServices.dart';
import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Repo {
  WebService webService;

  Repo(this.webService);

  Future<LoginResponse> loginUse(String phone,String pass)async{
    final login=await webService.loginUser(phone,pass);
    return login;
  }

  Future<HomeResponse> getHomeData(String token,int user_id,int driver_id,int delegate_id,int branch_id
      ,String GraduationController,String CarNumController,BuildContext context)async{
    final home=await webService.getHomeData(token,user_id,driver_id,delegate_id,branch_id,GraduationController,
        CarNumController,context);
    return home;
  }

  Future<CarLengthResponse> getCarLength(String token)async{
    final CarLength=await webService.getCarLength(token);
    return CarLength;
  }

  Future<CarTypeResponse> getCarType(String token)async{
    final CarType=await webService.getCarType(token);
    return CarType;
  }

  Future<CitiesResponse> getCities(String token)async{
    final Cities=await webService.getCities(token);
    return Cities;
  }

  Future<BranchesResponse> getBrunchesForAddPayload(String token)async{
    final Branches=await webService.getBrunchesForAddPayload(token);
    return Branches;
  }

  Future<ChooseDriverRespose> chooseDriverToAddpayload(String token,String keyword,String statusFilter,int page)async{
    final ChooseDriver=await webService.chooseDriverToAddpayload(token,keyword,statusFilter,page);
    return ChooseDriver;
  }
  Future<ChooseUserRespose> chooseUserToAddpayload(String token,String keyword,int page,)async{
    final ChooseUser=await webService.chooseUserToAddpayload(token,keyword,page);
    return ChooseUser;
  }

  Future<AddPayloadResponse> Addpayload(String token,
      int UserId,
      int DriverId,
      int carTypeId,
      int startAreaId,
      int carLengthId,
      int branchId,
      int reachAreaId,
      String loadTime,
      String startTime,
      String endTime,
      String salePrice,
      String purchasePrice,
      String graduationStatement,
      String loan,
      String paymentMethod,
      String carNumber,
      String notes,
      String DelegateId,
      String from,
      String to,
      int CarOwnerId)async{
    final AddPayload=await webService.Addpayload(token,UserId,DriverId,carTypeId,startAreaId,
        carLengthId,branchId,reachAreaId,loadTime,startTime,endTime,salePrice,purchasePrice,
        graduationStatement,loan,paymentMethod,carNumber,notes,DelegateId,from,to,CarOwnerId);
    return AddPayload;
  }
  Future<UpdateResponse> UpdateOrder(int orderId,
      String token,
      int UserId,
      int DriverId,
      int carTypeId,
      int startAreaId,
      int carLengthId,
      int branchId,
      int reachAreaId,
      String loadTime,
      String startTime,
      String endTime,
      String salePrice,
      String purchasePrice,
      String graduationStatement,
      String loan,
      String paymentMethod,
      String carNumber,
      String notes,
      String DelegateId,
      String from,
      String to,
      int chooseCarOwner)async{
    final updateorder=await webService.UpdateOrder(token,UserId,DriverId,carTypeId,startAreaId,
        carLengthId,branchId,reachAreaId,loadTime,startTime,endTime,salePrice,purchasePrice,
        graduationStatement,loan,paymentMethod,carNumber,notes,DelegateId,orderId,from,to,chooseCarOwner);
    return updateorder;
  }

  Future<DelegateResponse> getDelegates(String statusFilter,String word,int page)async{
    final delegate=await webService.getDelegates(statusFilter,word,page);
    return delegate;
  }

  Future<DelegateResponse> getDelegatesOfBranch(int id,String statusFilter,String word,int page)async{
    final DelegatesOfBranch=await webService.getDelegatesOfBranch(id,statusFilter,word,page);
    return DelegatesOfBranch;
  }
  Future<CreateBranchResponse> CreateBranch(String name,String token)async{
    final createBranch=await webService.CreateBranch(name,token);
    return createBranch;
  }

  Future<AddDelegateResponse> CreateDelegate(String name,String phone,int branchId,String pass,String confirmePass,int isActive)async{
    final addDelegate=await webService.CreateDelegate(name,phone,branchId,pass,confirmePass,isActive);
    return addDelegate;
  }
  Future<AddUserResponse> CreateUser(String name,String phone,String manager,String pass,String confirmePass)async{
    final addUser=await webService.CreateUser(name,phone,manager,pass,confirmePass);
    return addUser;
  }

  Future<AddDriverResponse> CreateDriver(String name,
      String phone,
      String pass,
      String confirmePass,
      File? licenseImg,
      File? carFormImg,
      File? residenceImg,
      int isActive)async{
    final addDriver=await webService.CreateDriver(name,phone,pass,confirmePass,licenseImg,carFormImg,residenceImg,isActive);
    return addDriver;
  }

  Future<UpdateDelegateResponse> UpdateDelegate(String name,
      String phone,
      int branchId,
      String pass,
      String confirmePass,
      String token,
      int isActive)async{
    final updateDelegate=await webService.UpdateDelegate(name,phone,branchId,pass,confirmePass,token,isActive);
    return updateDelegate;
  }

  Future<UpdateUserResponse> UpdateUser(String name,String phone,String manager,String pass,String confirmePass,String token)async{
    final updateUser=await webService.UpdateUser(name,phone,manager,pass,confirmePass,token);
    return updateUser;
  }

  Future<UpdateDriverResponse> UpdateDriver(String name,
      String phone,
      String pass,
      String confirmePass,
      File? licenseImg,
      File? carFormImg,
      File? residenceImg,
      String token,
      int isActive)async{
    final updateDriver=await webService.UpdateDriver(name,phone,pass,confirmePass,licenseImg,carFormImg,residenceImg,token,isActive);
    return updateDriver;
  }

  Future<ShipmentCategoryDetailsResponse> getShipmentCategory(
      String status,String date,String start_date,
      String end_date,String token)async{
    final ShipmentCategory=await webService.getShipmentCategory(status,date,
        start_date,end_date,token);
    return ShipmentCategory;
  }

  Future<ShipmentCategoryDetailsResponse> getShipmentCategory2(
      String status,
      String date,
      String start_date,
      String end_date,
      String token,
      int userId,
      int driverId,
      int delegateId,
      String Graduation,
      int branchId,
      String CarNumController,
      int page)async{
    final ShipmentCategory=await webService.getShipmentCategory2(
        status,date,
        start_date,
        end_date,
        token,
        userId,
        driverId,
        delegateId,
        Graduation,
        branchId,
        CarNumController,page);
    return ShipmentCategory;
  }

  Future<ChooseDelegateResponse> chooseDelegate(String token,String keyword,int page)async{
    final chooseDelegat=await webService.chooseDelegate(token,keyword,page);
    return chooseDelegat;
  }

  Future<CategoryDetailsResponse> getCategoryDetails(String token,int id)async{
    final CategoryDetails=await webService.getCategoryDetails(token,id);
    return CategoryDetails;
  }

  Future<NotesResponse> getNotes(String token,int orderId)async{
    final notes=await webService.getNotes(token,orderId);
    return notes;
  }

  Future<CreateNotesResponse> createNotes(String token,String title,String note,int orderId)async{
    final createnotes=await webService.createNotes(token,title,note,orderId);
    return createnotes;
  }
  Future<UpdateNotesResponse> updateNotes(String token,String title,String note,int id)async{
    final updatenotes=await webService.updateNotes(token,title,note,id);
    return updatenotes;
  }

  Future<UpdateStatesResponse> updateStatus(String token,String status,int id)async{
    final updateStatus=await webService.updateStatus(token,status,id);
    return updateStatus;
  }

  Future<DeletResponse> delete(String token)async{
    final delete=await webService.delete(token);
    return delete;
  }

  Future<DeleteNoteResponse> deleteNote(String token,int id)async{
    final deleteNote=await webService.deleteNote(token,id);
    return deleteNote;
  }

  Future<ReportsResponse> ComprehensiveReports(
      String date,String start_date,
      String end_date,
      String token,
      int userId,
      int driverId,
      int delegateId,
      int startAreaId,
      int reachAreaId,
      int carTypeId)async{
    final Reports=await webService.ComprehensiveReports(
        date,
        start_date,
        end_date,
        token,
        userId,
        driverId,
        delegateId,
        startAreaId,
        reachAreaId,
        carTypeId);
    return Reports;
  }

  Future<ReportsResponse> customerReports(
      String date,
      String start_date,
      String end_date,
      String token,
      int userId,
      int driverId,
      int delegateId,
      int startAreaId,
      int reachAreaId,
      int carTypeId)async{
    final reports=await webService.customerReports(
        date,
        start_date,
        end_date,
        token,
        userId,
        driverId,
        delegateId,
        startAreaId,
        reachAreaId,
        carTypeId);
    return reports;
  }

  Future<ChangeDelegateFilterResponse> changeDelegateFilter(String token,int orderId,int delegateId)async{
    final changeDelegate=await webService.changeDelegateFilter(token,orderId,delegateId);
    return changeDelegate;
  }

  Future<ChangeDelegateFilterResponse> changeDriverFilter(String token,int orderId,int driverId)async{
    final changeDelegate=await webService.changeDriverFilter(token,orderId,driverId);
    return changeDelegate;
  }

  Future<ProfileResponse> UpdateProfile(String name,File? pic,String phone,String pass,String token)async{
    final profile=await webService.UpdateProfile(name,pic,phone,pass,token);
    return profile;
  }
  Future<NotificationResponse?> getNotification(String token)async{
    final notification=await webService.getNotification(token);
    return notification;
  }

  Future<UpdateTokenResponse?> UpdateToken(String userToken,String token)async{
    final updateToken=await webService.UpdateToken(userToken,token);
    return updateToken;
  }

  Future<CreateCityResponse> createCity(String name)async{
    final createCity= await webService.createCity(name);
    return createCity;
  }

  Future<UpdateCityResponse> updateCity(String title,int id)async{
    final updateCity= await webService.updateCity(title,id);
    return updateCity;
  }

  Future<DeleteCityResponse> deleteCity(int id)async{
    final deletCity= await webService.deleteCity(id);
    return deletCity;
  }

  Future<UploadShipmentImageResponse> uploadShipmentImage(File? pic,String token,int id)async{
    final shipmentImage= await webService.uploadShipmentImage(pic,token,id);
    return shipmentImage;
  }

  Future<CarOwnerListResponse> getCarOwner(String token,String value)async{
    final CarOwner= await webService.getCarOwner(token,value);
    return CarOwner;
  }

  Future<AddCarOwnerResponse> addCarOwner(String name,String phone,String token)async{
    final AddCarOwner= await webService.addCarOwner(name,phone,token);
    return AddCarOwner;
  }

  Future<DeleteCarOwnerResponse> deleteCarOwner(String token,int id)async{
    final deleteCarOwner= await webService.deleteCarOwner(token,id);
    return deleteCarOwner;
  }

  Future<UpdateCarOwnerResponse> updateCarOwner(String token,int id,String name,String phone)async{
    final updateCarOwner= await webService.updateCarOwner(token,id,name,phone);
    return updateCarOwner;
  }

  }