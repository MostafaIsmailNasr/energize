class HomeResponse {
  bool? success;
  Null? message;
  Data? data;

  HomeResponse({this.success, this.message, this.data});

  HomeResponse.fromJson(Map<String, dynamic> json) {
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
  int? requesting;
  int? pending;
  int? uploaded;
  int? onWay;
  int? bondSent;
  int? bondReceived;
  int? arrived;
  int? lateShipments;
  int? cancelled;

  Data(
      {this.requesting,
        this.pending,
        this.uploaded,
        this.onWay,
        this.bondSent,
        this.bondReceived,
        this.arrived,
        this.lateShipments,
        this.cancelled});

  Data.fromJson(Map<String, dynamic> json) {
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