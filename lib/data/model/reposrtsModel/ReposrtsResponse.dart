class ReportsResponse {
  bool? success;
  Null? message;
  Reposrts? data;

  ReportsResponse({this.success, this.message, this.data});

  ReportsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Reposrts.fromJson(json['data']) : null;
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

class Reposrts {
  Statues? statues;
  List<Orders>? orders;

  Reposrts({this.statues, this.orders});

  Reposrts.fromJson(Map<String, dynamic> json) {
    statues =
    json['statues'] != null ? new Statues.fromJson(json['statues']) : null;
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statues != null) {
      data['statues'] = this.statues!.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statues {
  int? requesting;
  int? pending;
  int? uploaded;
  int? onWay;
  int? bondSent;
  int? bondReceived;
  int? arrived;
  int? lateShipments;
  int? cancelled;

  Statues(
      {this.requesting,
        this.pending,
        this.uploaded,
        this.onWay,
        this.bondSent,
        this.bondReceived,
        this.arrived,
        this.lateShipments,
        this.cancelled});

  Statues.fromJson(Map<String, dynamic> json) {
    requesting = json['requesting'];
    pending = json['pending'];
    uploaded = json['uploaded'];
    onWay = json['on_way'];
    bondSent = json['bond_sent'];
    bondReceived = json['bond_received'];
    arrived = json['arrived'];
    lateShipments = json['late_shipments'];
    cancelled = json['cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requesting'] = this.requesting;
    data['pending'] = this.pending;
    data['uploaded'] = this.uploaded;
    data['on_way'] = this.onWay;
    data['bond_sent'] = this.bondSent;
    data['bond_received'] = this.bondReceived;
    data['arrived'] = this.arrived;
    data['late_shipments'] = this.lateShipments;
    data['cancelled'] = this.cancelled;
    return data;
  }
}

class Orders {
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
  String? salePrice;
  String? purchasePrice;
  String? loan;
  int? difference;
  String? graduationStatement;
  String? paymentMethod;
  String? carNumber;
  String? notes;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Orders(
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

  Orders.fromJson(Map<String, dynamic> json) {
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