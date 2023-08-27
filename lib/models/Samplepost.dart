// To parse this JSON data, do
//
//     final samplePosts = samplePostsFromJson(jsonString);

import 'dart:convert';

SamplePosts samplePostsFromJson(String str) => SamplePosts.fromJson(json.decode(str));

String samplePostsToJson(SamplePosts data) => json.encode(data.toJson());

class SamplePosts {
  String operation;
  String message;
  List<Datum> data;

  SamplePosts({
    required this.operation,
    required this.message,
    required this.data,
  });

  factory SamplePosts.fromJson(Map<String, dynamic> json) => SamplePosts(
    operation: json["Operation"],
    message: json["Message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Operation": operation,
    "Message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? updatedAt;
  bool? meterStatus;
  dynamic userId;
  String? createdAt;
  String? meterAddress;
  String? startDate;
  String? unitType;
  int? unitId;
  int? deviceId;
  int id;
  String? meterName;
  String? installationDate;
  String? postcode;
  bool? status;
  String? gatewayId;
  String? address;
  String? country;
  String? craetedAt;
  String? city;
  String? meterType;
  String? longnitude;
  String? latitude;
  String? deviceName;

  Datum({
    this.updatedAt,
    this.meterStatus,
    this.userId,
    this.createdAt,
    this.meterAddress,
    this.startDate,
    this.unitType,
    this.unitId,
    this.deviceId,
    required this.id,
    this.meterName,
    this.installationDate,
    this.postcode,
    this.status,
    this.gatewayId,
    this.address,
    this.country,
    this.craetedAt,
    this.city,
    this.meterType,
    this.longnitude,
    this.latitude,
    this.deviceName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    updatedAt: json["updated_at"],
    meterStatus: json["meter_status"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    meterAddress: json["meter_address"],
    startDate: json["start_date"],
    unitType: json["unit_type"],
    unitId: json["unit_id"],
    deviceId: json["device_id"],
    id: json["id"],
    meterName: json["meter_name"],
    installationDate: json["installation_date"],
    postcode: json["postcode"],
    status: json["status"],
    gatewayId: json["gateway_id"],
    address: json["address"],
    country: json["country"],
    craetedAt: json["craeted_at"],
    city: json["city"],
    meterType: json["meter_type"],
    longnitude: json["longnitude"],
    latitude: json["latitude"],
    deviceName: json["device_name"],
  );

  Map<String, dynamic> toJson() => {
    "updated_at": updatedAt,
    "meter_status": meterStatus,
    "user_id": userId,
    "created_at": createdAt,
    "meter_address": meterAddress,
    "start_date": startDate,
    "unit_type": unitType,
    "unit_id": unitId,
    "device_id": deviceId,
    "id": id,
    "meter_name": meterName,
    "installation_date": installationDate,
    "postcode": postcode,
    "status": status,
    "gateway_id": gatewayId,
    "address": address,
    "country": country,
    "craeted_at": craetedAt,
    "city": city,
    "meter_type": meterType,
    "longnitude": longnitude,
    "latitude": latitude,
    "device_name": deviceName,
  };
}
