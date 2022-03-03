// To parse this JSON data, do
//
//     final newParkingReq = newParkingReqFromJson(jsonString);

import 'dart:convert';

import 'package:parking_app_mobile_business/model/response/new_parking_res.dart';

NewParkingReq newParkingReqFromJson(String str) =>
    NewParkingReq.fromJson(json.decode(str));

String newParkingReqToJson(NewParkingReq data) => json.encode(data.toJson());

class NewParkingReq {
  NewParkingReq({
    this.name,
    this.address,
    this.openTime,
    this.closeTime,
    this.phoneNumber,
    this.coordinate,
  });

  String? name;
  String? address;
  String? openTime;
  String? closeTime;
  String? phoneNumber;
  Coordinate? coordinate;

  factory NewParkingReq.fromJson(Map<String, dynamic> json) => NewParkingReq(
        name: json["name"],
        address: json["address"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        phoneNumber: json["phoneNumber"],
        coordinate: Coordinate.fromJson(json["coordinate"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "openTime": openTime,
        "closeTime": closeTime,
        "phoneNumber": phoneNumber,
        "coordinate": coordinate?.toJson(),
      };

  static NewParkingRes newParkingResFromJson(String str) =>
      NewParkingRes.fromJson(json.decode(str));

  String newParkingResToJson(NewParkingRes data) => json.encode(data.toJson());
}

class Coordinate {
  Coordinate({
    this.latitude,
    this.longitude,
  });

  String? latitude;
  String? longitude;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
