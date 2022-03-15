// To parse this JSON data, do
//
//     final parkingRes = parkingResFromJson(jsonString);

import 'dart:convert';

import 'package:parking_app_mobile_business/model/entity/business.dart';

ParkingRes parkingResFromJson(String str) =>
    ParkingRes.fromJson(json.decode(str));

String parkingResToJson(ParkingRes data) => json.encode(data.toJson());

class ParkingRes {
  ParkingRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory ParkingRes.fromJson(Map<String, dynamic> json) => ParkingRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };
  static ParkingRes parkingResFromJson(String str) =>
      ParkingRes.fromJson(json.decode(str));
  String parkingResToJson(ParkingRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.data,
    this.count,
    this.currentPage,
    this.nextPage,
    this.prevPage,
    this.lastPage,
  });

  List<Datum>? data;
  int? count;
  int? currentPage;
  int? nextPage;
  dynamic? prevPage;
  int? lastPage;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
    Datum({
        this.id,
        this.name,
        this.address,
        this.openTime,
        this.closeTime,
        this.status,
        this.phoneNumber,
        this.business,
        this.images,
        this.slotFull,
        this.slotEmpty,
        this.coordinates,
    });

    String? id;
    String? name;
    String? address;
    String? openTime;
    String? closeTime;
    String? status;
    String? phoneNumber;
    Business? business;
    List<Image>? images;
    int? slotFull;
    int? slotEmpty;
    Coordinates? coordinates;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        status: json["status"],
        phoneNumber: json["phoneNumber"],
        business: Business.fromJson(json["business"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        slotFull: json["slotFull"],
        slotEmpty: json["slotEmpty"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "openTime": openTime,
        "closeTime": closeTime,
        "status": status,
        "phoneNumber": phoneNumber,
        "business": business?.toJson(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "slotFull": slotFull,
        "slotEmpty": slotEmpty,
        "coordinates": coordinates?.toJson(),
    };
}
class Coordinates {
  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Image {
  Image({
    required this.url,
  });

  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
