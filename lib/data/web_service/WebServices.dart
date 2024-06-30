import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:energize_flutter/conustant/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio1;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business/addPayloadController/AddPayloadController.dart';
import '../../business/carOwnerController/CarOwnerController.dart';
import '../../conustant/CompressionUtil.dart';
import '../../ui/screens/auth/login/login_screen.dart';
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
class WebService {
  late dio1.Dio dio;
  late dio1.BaseOptions options;
   //var baseUrl="https://energize.mtjrsahl-ksa.com/api";
  var baseUrl="https://dashboard.energizelogistic.com/api";

  WebService(){
    options=dio1.BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError:true,
      connectTimeout: Duration(milliseconds: 90*1000),
      receiveTimeout:  Duration(milliseconds: 90*1000),
    );
    dio=dio1.Dio(options);
  }

  void handleError(DioException e) {
    String message = '';

    if (e.error is SocketException) {
      message = 'No internet connection';
    }  else if (e.response != null) {
      if (e.response?.statusCode == 422) {
        dynamic responseData = e.response!.data['message'];

        if (responseData is List) {
          if (responseData.isNotEmpty) {
            message = responseData[0];
          }
        } else
          if (responseData is String) {
          message = responseData;
        } else {
          message = 'An error occurred';
        }
      } else {
        message = '${e.response}';
      }
    } else if (e.type == DioExceptionType.cancel) {
      message = 'Request was canceled';
    } else {
      message = 'An error occurred';
    }
    print(message);
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,backgroundColor: MyColors.SideRed
    );
  }

  void handleErrorGallery(DioException e) {
    String message = '';

    if (e.error is SocketException) {
      message = 'No internet connection';
    }  else if (e.response != null) {
      if (e.response?.statusCode == 422) {
        dynamic responseData = e.response!.data['message'];

        if (responseData is List) {
          if (responseData.isNotEmpty) {
            message = responseData[0];
          }
        } else
        if (responseData is String) {
          message = responseData;
        } else {
          message = 'An error occurred';
        }
      } else {
        message = '${e.response}';
      }
    } else if (e.type == DioExceptionType.cancel) {
      message = 'Request was canceled';
    } else {
      message = 'please press again to add driver';
    }
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,backgroundColor: MyColors.SideRed
    );
  }

  Future<LoginResponse> loginUser(String phone,String pass)async{
    try {
      //Response response = await dio.post("character",data: );
      var LoginUrl="/login";
      print(LoginUrl);
      var params={
        'mobile': phone,
        'password': pass,
      };
      print(options.baseUrl+LoginUrl+params.toString());
      dio1.Response response = await dio.post(LoginUrl, data: params);
        // options: dio1.Options(
        //   headers: {
        //     "authorization": "Bearer ${token}",
        //   },
        // )
      print(response);
      if(response.statusCode==200){
        print("klkl"+LoginResponse.fromJson(response.data).toString());
        return LoginResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        return LoginResponse();
      }
    }catch(e){
      print(e.toString());
      return LoginResponse();
    }
  }

  Future<HomeResponse> getHomeData(String token,int user_id,int driver_id,
      int delegate_id,int branch_id,String Graduation,String CarNum,BuildContext context)async{
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var Url="/reports/home";
      var params;
      print(Url);
      if(user_id==0&&driver_id==0&&delegate_id==0&&branch_id==0){

        params={
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200) {
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==500){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id!=0&&user_id==0&&delegate_id==0&&branch_id==0){
        params={
          'driver_id': driver_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }

      }
      else if(driver_id==0&&user_id!=0&&delegate_id==0&&branch_id==0){
        params={
          'user_id': user_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id==0&&user_id==0&&delegate_id!=0&&branch_id==0){
        params={
          'delegate_id': delegate_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id==0&&user_id==0&&delegate_id==0&&branch_id!=0){
        params={
          'branch_id': branch_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id!=0&&user_id!=0&&delegate_id==0&&branch_id==0){
        params={
          'user_id': user_id,
          'driver_id': driver_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id!=0&&user_id==0&&delegate_id!=0&&branch_id==0){
        params={
          'delegate_id': delegate_id,
          'driver_id': driver_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id!=0&&user_id==0&&delegate_id==0&&branch_id!=0){
        params={
          'branch_id': branch_id,
          'driver_id': driver_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id==0&&user_id!=0&&delegate_id!=0&&branch_id==0){
        params={
          'delegate_id': delegate_id,
          'user_id': user_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id==0&&user_id!=0&&delegate_id==0&&branch_id!=0){
        params={
          'branch_id': branch_id,
          'user_id': user_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else if(driver_id==0&&user_id==0&&delegate_id!=0&&branch_id!=0){
        params={
          'branch_id': branch_id,
          'delegate_id': delegate_id,
          'graduation_statement' : Graduation,
          'car_number' : CarNum
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url, queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          print(HomeResponse.fromJson(response.data));
          return HomeResponse.fromJson(response.data);
        }else if(response.statusCode==401){
          Navigator.pushNamedAndRemoveUntil(
              context, "/login_screen", ModalRoute.withName('/login_screen'));
          prefs.clear();
        }
        else{
          print(response.statusMessage);
          return HomeResponse();
        }
      }
      else{
         params={
          'user_id': user_id,
          'driver_id': driver_id,
          'delegate_id': delegate_id,
           'branch_id': branch_id,
           'graduation_statement' : Graduation,
           'car_number' : CarNum
        };
         print(options.baseUrl+Url+params.toString());
         dio1.Response response = await dio.get(Url, queryParameters: params,
             options: dio1.Options(
               headers: {
                 "authorization": "Bearer ${token}",
               },
             )
         );
         if(response.statusCode==200){
           print(HomeResponse.fromJson(response.data));
           return HomeResponse.fromJson(response.data);
         }else if(response.statusCode==401){
           Navigator.pushNamedAndRemoveUntil(
               context, "/login_screen", ModalRoute.withName('/login_screen'));
           prefs.clear();
         }
         else{
           print(response.statusMessage);
           return HomeResponse();
         }
      }
      return  HomeResponse();
    }
    catch(e){
      print(e.toString());
      if(e.toString()=="DioException [bad response]: The request returned an invalid status code of 500."){
        Get.offAll(()=> LoginScreen());
      }
        return HomeResponse();
    }
  }
///
  Future<CarTypeResponse> getCarType(String token)async{
    try {
      var Url="/common/car_types";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url, //data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return CarTypeResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return CarTypeResponse();
    }
  }

  Future<CarLengthResponse> getCarLength(String token)async{
    try {
      var Url="/common/car_lengths";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url, //data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return CarLengthResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return CarLengthResponse();
    }
  }

  Future<CitiesResponse> getCities(String token,)async{
    try {
      var Url="/common/cities_list";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url, //data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return CitiesResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return CitiesResponse();
    }
  }

  Future<BranchesResponse> getBrunchesForAddPayload(String token)async{
    try {
      var Url="/common/branches_list";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url, //data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return BranchesResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return BranchesResponse();
    }
  }

  Future<ChooseDriverRespose> chooseDriverToAddpayload(String token,String keyword,String statusFilter,int page)async{
    try {
      var Url="/common/drivers_list";
      print(Url);
      var params={
        'keyword': keyword,
        'status_filter':statusFilter,
        'page': page
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url, queryParameters: params,
          // options: dio1.Options(
          //   headers: {
          //     "authorization": "Bearer ${token}",
          //   },
          // )
      );
      print(response);
      return ChooseDriverRespose.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return ChooseDriverRespose();
    }
  }

  Future<ChooseUserRespose> chooseUserToAddpayload(String token,String keyword,int page,)async{
    try {
      var Url="/common/users_list";
      print(Url);
      var params={
        'keyword': keyword,
        'page':page,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url, queryParameters: params,
          // options: dio1.Options(
          //   headers: {
          //     "authorization": "Bearer ${token}",
          //   },
          // )
      );
      print(response);
      return ChooseUserRespose.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return ChooseUserRespose();
    }
  }

  Future<dynamic> Addpayload(String token,
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
     try {

      dio1.Response response;
      var Url="/order/create";
      print(Url);
      if(DriverId!=0){
        var params={
          'user_id': UserId,
          'driver_id': DriverId,
          'car_type_id': carTypeId,
          'car_length_id': carLengthId,
          'branch_id': branchId,
          'start_area_id': startAreaId,
          'reach_area_id':reachAreaId,
          'load_time': loadTime,
          'start_time': startTime,
          'end_time': endTime,
          'sale_price': salePrice,
          'purchase_price': purchasePrice,
          'graduation_statement': graduationStatement,
          'loan': loan,
          'payment_method': paymentMethod,
          'car_number': carNumber,
          'notes': notes,
          'created_by':DelegateId,
          'shipping_location' : from,
          'arrival_location' : to,
          'carOwner_id': CarOwnerId,
        };
        print(options.baseUrl+Url+params.toString());
        response = await dio.post(Url, data: params,
            options: dio1.Options(
              headers: {
                "Accept": "application/json",
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        return AddPayloadResponse.fromJson(response.data);
      }
      else{
        var params={
          'user_id': UserId,
          'car_type_id': carTypeId,
          'car_length_id': carLengthId,
          'branch_id': branchId,
          'start_area_id': startAreaId,
          'reach_area_id':reachAreaId,
          'load_time': loadTime,
          'start_time': startTime,
          'end_time': endTime,
          'sale_price': salePrice,
          'purchase_price': purchasePrice,
          'graduation_statement': graduationStatement,
          'loan': loan,
          'payment_method': paymentMethod,
          'car_number': carNumber,
          'notes': notes,
          'created_by':DelegateId,
          'shipping_location' : from,
          'arrival_location' : to,
          'carOwner_id': CarOwnerId,
        };
        print(options.baseUrl+Url+params.toString());
        response = await dio.post(Url, data: params,
            options: dio1.Options(
              headers: {
                "Accept": "application/json",
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        return AddPayloadResponse.fromJson(response.data);
      }

    }
     on DioException catch(e){
       final addPayloadController=Get.put(AddPayloadController());
       addPayloadController.isVisable.value=false;
       handleError(e);
      print('Something really unknown: $e');
    }
  }

  Future<DelegateResponse> getDelegates(String statusFilter,String word,int page)async{
    try {
      var Url="/common/delegate_list";
      print(Url);
      var params={
        'status_filter': statusFilter,
        'keyword' : word,
        'page' : page,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params
        // options: dio1.Options(
        //   headers: {
        //     "authorization": "Bearer ${token}",
        //   },
        // )
      );
      print(response);
      return DelegateResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DelegateResponse();
    }
  }

  Future<DelegateResponse> getDelegatesOfBranch(int id,String statusFilter,String word,int page)async{
    try {
      var Url="/common/delegate_list";
      print(Url);
      var params={
        'branch_id': id,
        'status_filter':statusFilter,
        'keyword' : word,
        'page' : page
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
        // options: dio1.Options(
        //   headers: {
        //     "authorization": "Bearer ${token}",
        //   },
        // )
      );
      print(response);
      return DelegateResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DelegateResponse();
    }
  }

  Future<CreateBranchResponse> CreateBranch(String name,String token)async{
    try {
      var Url="/branch/create";
      print(Url);
      var params={
        'name': name,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,queryParameters: params,
        options: dio1.Options(
          headers: {
            "authorization": "Bearer ${token}",
          },
        )
      );
      print(response);
      return CreateBranchResponse.fromJson(response.data);
    }on DioException catch(e){
      print(e.toString());
      handleError(e);
      return CreateBranchResponse();
    }
  }

  Future<AddDelegateResponse> CreateDelegate(String name,String phone,int branchId,String pass,String confirmePass,int isActive)async{
    // try {
      var Url="/add_delegate";
      print(Url);
      var params={
        'name': name,
        'mobile': phone,
        'password':pass,
        'password_confirmation':confirmePass,
        'branch_id':branchId,
        'status':isActive
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          // options: dio1.Options(
          //   headers: {
          //     "authorization": "Bearer ${token}",
          //   },
          // )
      );
      if(response.statusCode==200){
        print(AddDelegateResponse.fromJson(response.data));
        return AddDelegateResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return AddDelegateResponse();
      }

    /*}catch(e){
      print(e.toString());
      return AddDelegateResponse();
    }*/
  }

  Future<AddUserResponse> CreateUser(String name,String phone,String manager,String pass,String confirmePass)async{
    try {
      var Url="/add_user";
      print(Url);
      var params={
        'name': name,
        'mobile': phone,
        'password':pass,
        'password_confirmation':confirmePass,
        'manager_name':manager
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
        // options: dio1.Options(
        //   headers: {
        //     "authorization": "Bearer ${token}",
        //   },
        // )
      );
      if(response.statusCode==200){
        print(AddUserResponse.fromJson(response.data));
        return AddUserResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return AddUserResponse();
      }

    }catch(e){
      print(e.toString());
      return AddUserResponse();
    }
  }

  Future<AddDriverResponse> CreateDriver(String name,
      String phone,
      String pass,
      String confirmePass,
      File? licenseImg,
      File? carFormImg,
      File? residenceImg,
      int isActive)async{
    try {
      var Url="/add_driver";
      var formData =
      dio1.FormData.fromMap({
        'name': name,
        'mobile': phone,
        'password':pass,
        'password_confirmation':confirmePass,
        'status':isActive
      });

      if(licenseImg!=null) {
        // //[4] ADD IMAGE TO UPLOAD
        File compressedImage1 = await CompressionUtil.compressImage(licenseImg.path);
        var file = await dio1.MultipartFile.fromFile(compressedImage1.path,
            filename: basename(compressedImage1.path),
            contentType: MediaType("license_img", "title.png"));


         formData.files.add(MapEntry('license_img', file));
      }
       if(carFormImg!=null){
         File compressedImage2 = await CompressionUtil.compressImage(carFormImg.path);
        var file = await dio1.MultipartFile.fromFile(compressedImage2.path,
            filename: basename(compressedImage2.path),
            contentType: MediaType("car_form_img", "title.png"));


        formData.files.add(MapEntry('car_form_img', file));
      }
       if(residenceImg!=null){
         File compressedImage3 = await CompressionUtil.compressImage(residenceImg.path);
        var file = await dio1.MultipartFile.fromFile(compressedImage3.path,
            filename: basename(compressedImage3.path),
            contentType: MediaType("residence_img", "title.png"));


        formData.files.add(MapEntry('residence_img', file));
      }

      print(options.baseUrl+Url+formData.fields.toString());
      print(options.baseUrl+Url+formData.files.toString());
      dio1.Response response = await dio.post(Url,data: formData,
        options: dio1.Options(
          headers: {
            "Accept": "application/json",
            "Connection":"keep-alive",
          },
        )
      );
      if(response.statusCode==200){
        print(AddDriverResponse.fromJson(response.data));
        return AddDriverResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return AddDriverResponse();
      }

    }on DioException catch(e){
      print(e.toString());
      handleErrorGallery(e);
       return AddDriverResponse();
    }
  }

  Future<UpdateDelegateResponse> UpdateDelegate(String name,
      String phone,
      int branchId,
      String pass,
      String confirmePass,
      String token,
      int isActive)async{
    try {
      var Url="/update_delegate";
      print(Url);
      var params={
        'name': name,
        'mobile': phone,
        'password':pass,
        'password_confirmation':confirmePass,
        'branch_id':branchId,
        'status':isActive
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
        options: dio1.Options(
          headers: {
            "authorization": "Bearer ${token}",
          },
        )
      );
      if(response.statusCode==200){
        print(UpdateDelegateResponse.fromJson(response.data));
        return UpdateDelegateResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return UpdateDelegateResponse();
      }

    }catch(e){
      print(e.toString());
      return UpdateDelegateResponse();
    }
  }


  Future<UpdateUserResponse> UpdateUser(String name,String phone,String manager,String pass,String confirmePass,String token)async{
    try {
      var Url="/update_user";
      print(Url);
      var params={
        'name': name,
        'mobile': phone,
        'password':pass,
        'password_confirmation':confirmePass,
        'manager_name':manager
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      if(response.statusCode==200){
        print(UpdateUserResponse.fromJson(response.data));
        return UpdateUserResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return UpdateUserResponse();
      }

    }catch(e){
      print(e.toString());
      return UpdateUserResponse();
    }
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
    try {
      var Url="/update_driver";
      print(Url);
      var formData =
      dio1.FormData.fromMap({
        'name': name,
        'mobile': phone,
        'password':pass,
        'password_confirmation':confirmePass,
        'status':isActive
      });

      if(licenseImg!=null) {
        // //[4] ADD IMAGE TO UPLOAD
        File compressedImage1 = await CompressionUtil.compressImage(licenseImg.path);
        var file = await dio1.MultipartFile.fromFile(compressedImage1.path,
            filename: basename(compressedImage1.path),
            contentType: MediaType("license_img", "title.png"));


        formData.files.add(MapEntry('license_img', file));
      }
      if(carFormImg!=null){
        File compressedImage2 = await CompressionUtil.compressImage(carFormImg.path);
        var file = await dio1.MultipartFile.fromFile(compressedImage2.path,
            filename: basename(compressedImage2.path),
            contentType: MediaType("car_form_img", "title.png"));


        formData.files.add(MapEntry('car_form_img', file));
      }
      if(residenceImg!=null){
        File compressedImage3 = await CompressionUtil.compressImage(residenceImg.path);
        var file = await dio1.MultipartFile.fromFile(compressedImage3.path,
            filename: basename(compressedImage3.path),
            contentType: MediaType("residence_img", "title.png"));


        formData.files.add(MapEntry('residence_img', file));
      }

      print(options.baseUrl+Url+formData.toString());
      dio1.Response response = await dio.post(Url,data: formData,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      if(response.statusCode==200){
        print(UpdateDriverResponse.fromJson(response.data));
        return UpdateDriverResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return UpdateDriverResponse();
      }

    }catch(e){
      print(e.toString());
      return UpdateDriverResponse();
    }
  }


  Future<ShipmentCategoryDetailsResponse> getShipmentCategory(
      String status,String date,String start_date,
      String end_date,String token)async{
    try {
      var Url="/order/list";
      print(Url);
      var params={
        'status': status,
        'date':date,
        'start_date':start_date,
        'end_date':end_date,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
        options: dio1.Options(
          headers: {
            "authorization": "Bearer ${token}",
          },
        )
      );
      if(response.statusCode==200){
        print(ShipmentCategoryDetailsResponse.fromJson(response.data));
        return ShipmentCategoryDetailsResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return ShipmentCategoryDetailsResponse();
      }

    }catch(e){
      print(e.toString());
      return ShipmentCategoryDetailsResponse();
    }
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
      String CarNum,
      int page)async{
    try {
      var Url="/reports/orders";
      print(Url);
      if (userId == 0 && driverId == 0 && delegateId == 0 && branchId==0) {
        var params = {
          'status': status,
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page,
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId!=0&&userId==0&&delegateId==0&& branchId==0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId==0&&userId!=0&&delegateId==0&& branchId==0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId==0&&userId==0&&delegateId!=0&& branchId==0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId==0&&userId==0&&delegateId==0&& branchId!=0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'branch_id':branchId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId!=0&&userId!=0&&delegateId==0&& branchId==0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id': userId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId!=0&&userId==0&&delegateId!=0&& branchId==0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId!=0&&userId==0&&delegateId!=0&& branchId!=0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'branch_id':branchId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId==0&&userId!=0&&delegateId!=0&& branchId==0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id': userId,
          'delegate_id':delegateId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId==0&&userId!=0&&delegateId==0&& branchId!=0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id': userId,
          'branch_id':branchId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else if(driverId==0&&userId==0&&delegateId!=0&& branchId!=0){
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id': delegateId,
          'branch_id':branchId,
          'graduation_statement' : Graduation,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
      else{
        var params={
          'status':status,
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id': userId,
          'delegate_id':delegateId,
          'graduation_statement' : Graduation,
          'branch_id':branchId,
          'car_number' : CarNum,
          'page' : page
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ShipmentCategoryDetailsResponse.fromJson(response.data));
          return ShipmentCategoryDetailsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ShipmentCategoryDetailsResponse();
        }
      }
    }catch(e){
      print(e.toString());
      return ShipmentCategoryDetailsResponse();
    }
  }

  Future<ChooseDelegateResponse> chooseDelegate(String token,String keyword,int page)async{
    try {
      var Url="/common/delegate_list";
      print(Url);
      var params={
        'keyword': keyword,
        'page' : page
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url, queryParameters: params,
        // options: dio1.Options(
        //   headers: {
        //     "authorization": "Bearer ${token}",
        //   },
        // )
      );
      print(response);
      return ChooseDelegateResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return ChooseDelegateResponse();
    }
  }

  Future<CategoryDetailsResponse> getCategoryDetails(String token,int id)async{
    try {
      var Url="/order/details/$id";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
        options: dio1.Options(
          headers: {
            "authorization": "Bearer ${token}",
          },
        )
      );
      print(response);
      return CategoryDetailsResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return CategoryDetailsResponse();
    }
  }

  Future<NotesResponse> getNotes(String token,int orderId)async{
    try {
      var Url="/note/list";
      print(Url);
      var params={
        'order_id': orderId,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return NotesResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return NotesResponse();
    }
  }

  Future<CreateNotesResponse> createNotes(String token,String title,String note,int orderId)async{
    try {
      var Url="/note/create";
      print(Url);
      var params={
        'title': title,
        'note': note,
        'order_id': orderId,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url, queryParameters: params,
        options: dio1.Options(
          headers: {
            "authorization": "Bearer ${token}",
          },
        )
      );
      print(response);
      return CreateNotesResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return CreateNotesResponse();
    }
  }

  Future<UpdateNotesResponse> updateNotes(String token,String title,String note,int id)async{
    try {
      var Url="/note/update/$id";
      print(Url);
      var params={
        'title': title,
        'note': note,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url, data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return UpdateNotesResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return UpdateNotesResponse();
    }
  }

  Future<UpdateStatesResponse> updateStatus(String token,String status,int id)async{
    try {
      var Url="/order/update_status";
      print(Url);
      var params={
        'order_id': id,
        'status': status,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url, data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return UpdateStatesResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return UpdateStatesResponse();
    }
  }

  Future<DeletResponse> delete(String token)async{
    try {
      var Url="/delete_user";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.delete(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return DeletResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DeletResponse();
    }
  }

  Future<DeleteNoteResponse> deleteNote(String token,int id)async{
    try {
      var Url="/note/delete/$id";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.delete(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return DeleteNoteResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DeleteNoteResponse();
    }
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
    try {
      var Url="/reports/orders";
      print(Url);
      if (userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id': userId,
          'delegate_id':delegateId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

    else if(driverId!=0
          &&userId==0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0){
      var params={
        'date':date,
        'start_date':start_date,
        'end_date':end_date,
        'driver_id':driverId,
        'start_area_id':startAreaId,
        // 'reach_area_id':reachAreaId,
        // 'car_type_id':carTypeId
    };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      if(response.statusCode==200){
        print(ReportsResponse.fromJson(response.data));
        return ReportsResponse.fromJson(response.data);
      }else{
        print(response.statusMessage);
        return ReportsResponse();
      }
    }

      else if(driverId!=0
          &&userId==0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          //'start_area_id':startAreaId,
           'reach_area_id':reachAreaId,
          // 'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          //'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
           'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'start_area_id':startAreaId,
          // 'reach_area_id':reachAreaId,
          // 'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          //'start_area_id':startAreaId,
           'reach_area_id':reachAreaId,
          // 'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          //'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
           'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id':userId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id':userId,
          'start_area_id':startAreaId,
          // 'reach_area_id':reachAreaId,
          // 'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id':userId,
          //'start_area_id':startAreaId,
           'reach_area_id':reachAreaId,
          // 'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id':userId,
          //'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
           'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id':userId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id':userId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId!=0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id':userId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId!=0
          &&userId==0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'delegate_id':delegateId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId!=0
          &&delegateId!=0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'user_id':userId,
          'delegate_id':delegateId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          // 'driver_id':driverId,
          // 'user_id': userId,
          // 'delegate_id':delegateId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          // 'driver_id':driverId,
          // 'user_id': userId,
          // 'delegate_id':delegateId,
          //'car_type_id':carTypeId
          'start_area_id':startAreaId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          // 'driver_id':driverId,
          // 'user_id': userId,
          // 'delegate_id':delegateId,
          //'car_type_id':carTypeId
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          // 'driver_id':driverId,
          // 'user_id': userId,
          // 'delegate_id':delegateId,
          //'car_type_id':carTypeId
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId==0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          // 'driver_id':driverId,
          // 'user_id': userId,
          // 'delegate_id':delegateId,
          'car_type_id':carTypeId,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(driverId==0
          &&userId==0
          &&delegateId==0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0){
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          // 'driver_id':driverId,
          // 'user_id': userId,
          // 'delegate_id':delegateId,
          'car_type_id':carTypeId,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else{
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id': userId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }
    }catch(e){
      print(e.toString());
      return ReportsResponse();
    }
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
    try {
      var Url="/reports/orders";
      print(Url);
      /// state that i send some var and other not
      if (userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId==0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId!=0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId==0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId==0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId==0
          &&reachAreaId==0
          &&carTypeId!=0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          //'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId!=0
          &&reachAreaId!=0
          &&carTypeId==0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          //'car_type_id':carTypeId
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId!=0
          &&reachAreaId==0
          &&carTypeId!=0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          'start_area_id':startAreaId,
          //'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else if(userId == 0
          && driverId == 0
          && delegateId == 0
          &&startAreaId==0
          &&reachAreaId!=0
          &&carTypeId!=0) {
        var params = {
          'date': date,
          'start_date': start_date,
          'end_date': end_date,
          //'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl + Url + params.toString());
        dio1.Response response = await dio.get(Url,
            queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            ));
        if (response.statusCode == 200) {
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        } else {
          print(response.statusMessage);
          return ReportsResponse();
        }
      }

      else{
        var params={
          'date':date,
          'start_date':start_date,
          'end_date':end_date,
          'driver_id':driverId,
          'user_id': userId,
          'delegate_id':delegateId,
          'start_area_id':startAreaId,
          'reach_area_id':reachAreaId,
          'car_type_id':carTypeId
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.get(Url,queryParameters: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        if(response.statusCode==200){
          print(ReportsResponse.fromJson(response.data));
          return ReportsResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ReportsResponse();
        }
      }
    }catch(e){
      print(e.toString());
      return ReportsResponse();
    }
  }

  Future<ChangeDelegateFilterResponse> changeDelegateFilter(String token,int orderId,int delegateId)async{
    try {
      var Url="/order/update_delegate";
      print(Url);
      var params={
        'order_id': orderId,
        'delegate_id': delegateId,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url, data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return ChangeDelegateFilterResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return ChangeDelegateFilterResponse();
    }
  }

  Future<ChangeDelegateFilterResponse> changeDriverFilter(String token,int orderId,int driverId)async{
    try {
      var Url="/order/update_driver";
      print(Url);
      var params={
        'order_id': orderId,
        'driver_id': driverId,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url, data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return ChangeDelegateFilterResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return ChangeDelegateFilterResponse();
    }
  }

  Future<ProfileResponse> UpdateProfile(String name,File? pic,String phone,String pass,String token)async{
    try {
      if(pass==""){
        var formData =
        dio1.FormData.fromMap({
          'name': name,
          'mobile': phone,
        });
        if(pic!=null) {
          // //[4] ADD IMAGE TO UPLOAD
          var file = await dio1.MultipartFile.fromFile(pic.path,
              filename: basename(pic.path),
              contentType: MediaType("picture", "title.png"));


          formData.files.add(MapEntry('picture', file));
        }
        var LoginUrl="/update_user";
        print(LoginUrl);
        print(LoginUrl);

        print(options.baseUrl+LoginUrl+formData.toString());
        dio1.Response response = await dio.post(
            LoginUrl,
            data: formData,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
                "Accept": "application/json",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          return ProfileResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ProfileResponse();
        }
      }
      else{
        var formData =
        dio1.FormData.fromMap({
          'name': name,
          'mobile': phone,
          'password': pass,
        });

        if(pic!=null) {
          // //[4] ADD IMAGE TO UPLOAD
          var file = await dio1.MultipartFile.fromFile(pic.path,
              filename: basename(pic.path),
              contentType: MediaType("picture", "title.png"));


          formData.files.add(MapEntry('picture', file));
        }
        var LoginUrl="/update_user";
        print(LoginUrl);

        print(options.baseUrl+LoginUrl+formData.toString());
        dio1.Response response = await dio.post(
            LoginUrl,
            data: formData,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
                "Accept": "application/json",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          return ProfileResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return ProfileResponse();
        }
      }

    }on  DioException catch(e){
      print(e.toString());
      handleError(e);
      return ProfileResponse();
    }
  }

  Future<NotificationResponse?> getNotification(String token)async{
    try {
      var HomeUrl="/notifications/list";
      print(options.baseUrl+HomeUrl);
      dio1.Response response = await dio.get(
          HomeUrl,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return NotificationResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<UpdateTokenResponse?> UpdateToken(String userToken,String token)async{
    var params;
    try {
      var HomeUrl="/update_token";
      if(Platform.isIOS){
        params={
          'ios_token': token,
        };
      }else{
        params={
          'android_token': token,
        };
      }
      print(options.baseUrl+HomeUrl+params.toString());
      dio1.Response response = await dio.post(
          HomeUrl,
          data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${userToken}",
            },
          )
      );
      print("tokenre"+response.toString());
      return UpdateTokenResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> UpdateOrder(
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
      int order,
      String from,
      String to,
      int chooseCarOwner)async{
     try {
    dio1.Response response;
    var Url="/order/update/$order";
    print(Url);
      var params={
        'user_id': UserId,
        'car_type_id': carTypeId,
        'car_length_id': carLengthId,
        'branch_id': branchId,
        'start_area_id': startAreaId,
        'reach_area_id':reachAreaId,
        'load_time': loadTime,
        'start_time': startTime,
        'end_time': endTime,
        'sale_price': salePrice,
        'purchase_price': purchasePrice,
        'graduation_statement': graduationStatement,
        'loan': loan,
        'payment_method': paymentMethod,
        'car_number': carNumber,
        'notes': notes,
        'created_by':DelegateId,
        'driver_id':DriverId,
        'shipping_location' : from,
        'arrival_location' : to,
        'carOwner_id':chooseCarOwner
      };
      print(options.baseUrl+Url+params.toString());
      response = await dio.post(Url, data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
              "Accept": "application/json",
            },
          )
      );
      print(response);
      return UpdateResponse.fromJson(response.data);


    }
    on DioException catch(e){
      final addPayloadController=Get.put(AddPayloadController());
      addPayloadController.isVisable.value=false;
      handleError(e);
      print('Something really unknown: $e');
    }
  }

  Future<CreateCityResponse> createCity(String name)async{
    try {
      var Url="/city/create";
      print(Url);
      var params={
        'name': name,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,queryParameters: params,
          // options: dio1.Options(
          //   headers: {
          //     "authorization": "Bearer ${token}",
          //   },
          // )
      );
      print(response);
      return CreateCityResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return CreateCityResponse();
    }
  }

  Future<UpdateCityResponse> updateCity(String title,int id)async{
    try {
      var Url="/city/update/$id";
      print(Url);
      var params={
        'name': title,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url, data: params,
          // options: dio1.Options(
          //   headers: {
          //     "authorization": "Bearer ${token}",
          //   },
          // )
      );
      print(response);
      return UpdateCityResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return UpdateCityResponse();
    }
  }

  Future<DeleteCityResponse> deleteCity(int id)async{
    try {
      var Url="/city/delete/$id";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.delete(Url,);
      print(response);
      return DeleteCityResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DeleteCityResponse();
    }
  }

  Future<UploadShipmentImageResponse> uploadShipmentImage(File? pic,String token,int id)async{
    try {
        var formData =
        dio1.FormData.fromMap({
          'order_id': id
        });

        if(pic!=null) {
          // //[4] ADD IMAGE TO UPLOAD
          var file = await dio1.MultipartFile.fromFile(pic.path,
              filename: basename(pic.path),
              contentType: MediaType("image", "title.png"));


          formData.files.add(MapEntry('image', file));
        }
        var LoginUrl="/order/upload_shipment_image";
        print(LoginUrl);

        print(options.baseUrl+LoginUrl+formData.files.toString()+formData.fields.toString());
        dio1.Response response = await dio.post(
            LoginUrl,
            data: formData,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        if(response.statusCode==200){
          return UploadShipmentImageResponse.fromJson(response.data);
        }else{
          print(response.statusMessage);
          return UploadShipmentImageResponse();
        }
    }catch(e){
      print(e.toString());
      return UploadShipmentImageResponse();
    }
  }

  Future<CarOwnerListResponse> getCarOwner(String token,String value)async{
    try {
      var Url="/carOwner/list";
      var params={
        'value':value,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url, queryParameters: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return CarOwnerListResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return CarOwnerListResponse();
    }
  }

  Future<AddCarOwnerResponse> addCarOwner(String name,String phone,String token)async{
    try {
    var Url="/carOwner/create";
    print(Url);
    var params={
      'name': name,
      'phone': phone,
    };
    print(options.baseUrl+Url+params.toString());
    dio1.Response response = await dio.post(Url,data: params,
      options: dio1.Options(
        headers: {
          "authorization": "Bearer ${token}",
          "Accept": "application/json",
        },
      )
    );
    if(response.statusCode==200){
      print(AddCarOwnerResponse.fromJson(response.data));
      return AddCarOwnerResponse.fromJson(response.data);
    }else{
      print(response.statusMessage);
      return AddCarOwnerResponse();
    }

    }on DioException catch(e){
      print(e.toString());
      final carOwnerController=Get.put(CarOwnerController());
      carOwnerController.isVisabl.value=false;
      handleError(e);
      return AddCarOwnerResponse();
    }
  }

  Future<DeleteCarOwnerResponse> deleteCarOwner(String token,int id)async{
    try {
      var Url="/carOwner/delete";
      print(Url);
      var params={
        'id': id,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return DeleteCarOwnerResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DeleteCarOwnerResponse();
    }
  }

  Future<UpdateCarOwnerResponse> updateCarOwner(String token,int id,String name,String phone)async{
    try {
      var Url="/carOwner/update";
      print(Url);
      var params={
        'name': name,
        'phone': phone,
        'id': id,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${token}",
              "Accept": "application/json",
            },
          )
      );
      print(response);
      return UpdateCarOwnerResponse.fromJson(response.data);
    }on DioException catch(e){
      final carOwnerController=Get.put(CarOwnerController());
      carOwnerController.isVisabl.value=false;
      print(e.toString());
      handleError(e);
      return UpdateCarOwnerResponse();
    }
  }

}