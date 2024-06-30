class DelegateResponse {
  bool? success;
  Null? message;
  List<Delegate>? data;
  int? currentPage;
  int? lastPage;

  DelegateResponse({this.success, this.message, this.data,this.currentPage,this.lastPage});

  DelegateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Delegate>[];
      json['data'].forEach((v) {
        data!.add(new Delegate.fromJson(v));
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

class Delegate {
  int? id;
  String? name;
  String? mobile;
  dynamic? email;
  int? branchId;
  dynamic? managerName;
  String? role;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  String? token;
  dynamic? status;

  Delegate(
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
      this.status});

  Delegate.fromJson(Map<String, dynamic> json) {
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
    status= json['status'];
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
    data['status'] = this.status;
    return data;
  }
}