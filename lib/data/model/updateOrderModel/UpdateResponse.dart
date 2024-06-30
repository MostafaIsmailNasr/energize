class UpdateResponse {
  bool? success;
  String? message;
  Data? data;

  UpdateResponse({this.success, this.message, this.data});

  UpdateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? userName;
  String? userMobile;
  int? driverId;
  String? driverName;
  String? driverMobile;
  String? delegateName;
  int? branchId;
  String? branchName;
  int? carTypeId;
  String? carTypeName;
  int? carLengthId;
  String? carLengthName;
  int? startAreaId;
  String? startAreaName;
  int? reachAreaId;
  String? reachAreaName;
  String? status;
  String? loadTime;
  String? startTime;
  String? endTime;
  String? differenceDate;
  dynamic? salePrice;
  dynamic? purchasePrice;
  String? loan;
  int? difference;
  dynamic? graduationStatement;
  String? paymentMethod;
  dynamic? carNumber;
  dynamic? notes;
  dynamic? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.userName,
        this.userMobile,
        this.driverId,
        this.driverName,
        this.driverMobile,
        this.delegateName,
        this.branchId,
        this.branchName,
        this.carTypeId,
        this.carTypeName,
        this.carLengthId,
        this.carLengthName,
        this.startAreaId,
        this.startAreaName,
        this.reachAreaId,
        this.reachAreaName,
        this.status,
        this.loadTime,
        this.startTime,
        this.endTime,
        this.differenceDate,
        this.salePrice,
        this.purchasePrice,
        this.loan,
        this.difference,
        this.graduationStatement,
        this.paymentMethod,
        this.carNumber,
        this.notes,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    driverMobile = json['driver_mobile'];
    delegateName = json['delegate_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    carTypeId = json['car_type_id'];
    carTypeName = json['car_type_name'];
    carLengthId = json['car_length_id'];
    carLengthName = json['car_length_name'];
    startAreaId = json['start_area_id'];
    startAreaName = json['start_area_name'];
    reachAreaId = json['reach_area_id'];
    reachAreaName = json['reach_area_name'];
    status = json['status'];
    loadTime = json['load_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    differenceDate = json['difference_date'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    loan = json['loan'];
    difference = json['difference'];
    graduationStatement = json['graduation_statement'];
    paymentMethod = json['payment_method'];
    carNumber = json['car_number'];
    notes = json['notes'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_mobile'] = this.userMobile;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['driver_mobile'] = this.driverMobile;
    data['delegate_name'] = this.delegateName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['car_type_id'] = this.carTypeId;
    data['car_type_name'] = this.carTypeName;
    data['car_length_id'] = this.carLengthId;
    data['car_length_name'] = this.carLengthName;
    data['start_area_id'] = this.startAreaId;
    data['start_area_name'] = this.startAreaName;
    data['reach_area_id'] = this.reachAreaId;
    data['reach_area_name'] = this.reachAreaName;
    data['status'] = this.status;
    data['load_time'] = this.loadTime;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['difference_date'] = this.differenceDate;
    data['sale_price'] = this.salePrice;
    data['purchase_price'] = this.purchasePrice;
    data['loan'] = this.loan;
    data['difference'] = this.difference;
    data['graduation_statement'] = this.graduationStatement;
    data['payment_method'] = this.paymentMethod;
    data['car_number'] = this.carNumber;
    data['notes'] = this.notes;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}