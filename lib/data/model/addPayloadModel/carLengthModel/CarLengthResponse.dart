class CarLengthResponse {
  bool? success;
  Null? message;
  List<CarLength>? data;

  CarLengthResponse({this.success, this.message, this.data});

  CarLengthResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CarLength>[];
      json['data'].forEach((v) {
        data!.add(new CarLength.fromJson(v));
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

class CarLength {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CarLength({this.id, this.name, this.createdAt, this.updatedAt});

  CarLength.fromJson(Map<String, dynamic> json) {
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