// To parse this JSON data, do
//
//     final parkingSlotRes = parkingSlotResFromJson(jsonString);

import 'dart:convert';

class ParkingSlotRes {
  ParkingSlotRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory ParkingSlotRes.fromJson(Map<String, dynamic> json) => ParkingSlotRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "statusCode": statusCode,
      };

  static ParkingSlotRes parkingSlotResFromJson(String str) =>
      ParkingSlotRes.fromJson(json.decode(str));

  static String parkingSlotResToJson(ParkingSlotRes data) =>
      json.encode(data.toJson());
}

class Result {
  Result({
    required this.data,
    this.count,
    this.currentPage,
    this.nextPage,
    this.prevPage,
    this.lastPage,
  });

  List<ParkingSlot> data;
  int? count;
  int? currentPage;
  dynamic nextPage;
  dynamic prevPage;
  int? lastPage;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<ParkingSlot>.from(
            json["data"].map((x) => ParkingSlot.fromJson(x))),
        count: json["count"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        lastPage: json["lastPage"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "prevPage": prevPage,
        "lastPage": lastPage,
      };
}

class ParkingSlot {
  ParkingSlot({
    this.id,
    this.locationName,
    this.status,
  });

  String? id;
  String? locationName;
  String? status;

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
        id: json["id"],
        locationName: json["locationName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locationName": locationName,
        "status": status,
      };
}
