class CarOwnerListResponse {
  bool? success;
  dynamic? message;
  List<CarOwner>? data;

  CarOwnerListResponse({this.success, this.message, this.data});

  CarOwnerListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CarOwner>[];
      json['data'].forEach((v) {
        data!.add(new CarOwner.fromJson(v));
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

class CarOwner {
  int? id;
  String? name;
  String? phone;
  String? createdAt;
  String? updatedAt;

  CarOwner({this.id, this.name, this.phone, this.createdAt, this.updatedAt});

  CarOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}