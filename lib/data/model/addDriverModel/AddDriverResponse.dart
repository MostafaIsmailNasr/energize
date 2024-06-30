class AddDriverResponse {
  bool? success;
  dynamic? message;
  Data? data;

  AddDriverResponse({this.success, this.message, this.data});

  AddDriverResponse.fromJson(Map<String, dynamic> json) {
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

  Data(
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
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}