class ProfileResponse {
  bool? success;
  dynamic? message;
  Profile? data;

  ProfileResponse({this.success, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Profile.fromJson(json['data']) : null;
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

class Profile {
  int? id;
  String? name;
  String? mobile;
  dynamic? email;
  dynamic? branchId;
  String? managerName;
  String? role;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  String? token;
  dynamic? androidToken;
  dynamic? iosToken;

  Profile(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.branchId,
        this.managerName,
        this.role,
        this.avatar,
        this.createdAt,
        this.updatedAt,
        this.token,
        this.androidToken,
        this.iosToken});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    branchId = json['branch_id'];
    managerName = json['manager_name'];
    role = json['role'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    androidToken = json['android_token'];
    iosToken = json['ios_token'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    data['android_token'] = this.androidToken;
    data['ios_token'] = this.iosToken;
    return data;
  }
}