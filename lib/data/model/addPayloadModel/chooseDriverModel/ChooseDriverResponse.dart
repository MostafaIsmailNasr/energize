class ChooseDriverRespose {
  bool? success;
  Null? message;
  List<ChooseDriver>? data;
  int? currentPage;
  int? lastPage;

  ChooseDriverRespose({this.success, this.message, this.data,this.currentPage,this.lastPage});

  ChooseDriverRespose.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChooseDriver>[];
      json['data'].forEach((v) {
        data!.add(new ChooseDriver.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class ChooseDriver {
  int? id;
  String? name;
  String? mobile;
  Null? email;
  Null? branchId;
  Null? managerName;
  String? role;
  String? avatar;
  String? residenceImg;
  String? licenseImg;
  String? carFormImg;
  String? createdAt;
  String? updatedAt;
  String? token;
  dynamic? status;

  ChooseDriver(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.branchId,
        this.managerName,
        this.role,
        this.avatar,
        this.residenceImg,
        this.licenseImg,
        this.carFormImg,
        this.createdAt,
        this.updatedAt,
        this.token,
      this.status});

  ChooseDriver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    branchId = json['branch_id'];
    managerName = json['manager_name'];
    role = json['role'];
    avatar = json['avatar'];
    residenceImg = json['residence_img'];
    licenseImg = json['license_img'];
    carFormImg = json['car_form_img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['branch_id'] = this.branchId;
    data['manager_name'] = this.managerName;
    data['role'] = this.role;
    data['avatar'] = this.avatar;
    data['residence_img'] = this.residenceImg;
    data['license_img'] = this.licenseImg;
    data['car_form_img'] = this.carFormImg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    data['status'] = this.status;
    return data;
  }
}