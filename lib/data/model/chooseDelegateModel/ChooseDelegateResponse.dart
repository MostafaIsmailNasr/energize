class ChooseDelegateResponse {
  bool? success;
  Null message;
  List<ChooseDelegate>? data;
  int? currentPage;
  int? lastPage;

  ChooseDelegateResponse({this.success, this.message, this.data, this.currentPage,this.lastPage});

  ChooseDelegateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChooseDelegate>[];
      json['data'].forEach((v) {
        data!.add(new ChooseDelegate.fromJson(v));
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

class ChooseDelegate {
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

  ChooseDelegate(
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
        this.token});

  ChooseDelegate.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}