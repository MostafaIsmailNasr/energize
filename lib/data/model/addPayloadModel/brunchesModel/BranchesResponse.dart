class BranchesResponse {
  bool? success;
  Null? message;
  List<brunch>? data;

  BranchesResponse({this.success, this.message, this.data});

  BranchesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <brunch>[];
      json['data'].forEach((v) {
        data!.add(new brunch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class brunch {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? usersCount;

  brunch({this.id, this.name, this.createdAt, this.updatedAt,this.usersCount});

  brunch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    usersCount = json['users_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['users_count'] = this.usersCount;
    return data;
  }
}