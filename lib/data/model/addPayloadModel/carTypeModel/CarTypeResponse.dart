class CarTypeResponse {
  bool? success;
  Null? message;
  List<TypeCar>? data;

  CarTypeResponse({this.success, this.message, this.data});

  CarTypeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TypeCar>[];
      json['data'].forEach((v) {
        data!.add(new TypeCar.fromJson(v));
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

class TypeCar {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  TypeCar({this.id, this.name, this.createdAt, this.updatedAt});

  TypeCar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}