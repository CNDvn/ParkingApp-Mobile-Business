// To parse this JSON data, do
//
//     final PriceListManagementRes = PriceListManagementResFromJson(jsonString);

import 'dart:convert';

import 'package:parking_app_mobile_business/model/response/parking_res.dart';

PriceListManagementRes PriceListManagementResFromJson(String str) =>
    PriceListManagementRes.fromJson(json.decode(str));

String PriceListManagementResToJson(PriceListManagementRes data) =>
    json.encode(data.toJson());

class PriceListManagementRes {
  PriceListManagementRes({
    this.result,
    this.statusCode,
  });

  List<Result>? result;
  int? statusCode;

  factory PriceListManagementRes.fromJson(Map<String, dynamic> json) =>
      PriceListManagementRes(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };

  static PriceListManagementRes PriceListManagementResFromJson(String str) =>
      PriceListManagementRes.fromJson(json.decode(str));
  String parkingResToJson(ParkingRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.id,
    this.name,
    this.status,
    this.nameParking,
    this.priceListDetails,
  });

  String? id;
  String? name;
  String? status;
  String? nameParking;
  List<PriceListDetail>? priceListDetails;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        nameParking: json["nameParking"],
        priceListDetails: List<PriceListDetail>.from(
            json["priceListDetails"].map((x) => PriceListDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "nameParking": nameParking,
        "priceListDetails":
            List<dynamic>.from(priceListDetails!.map((x) => x.toJson())),
      };
}

class PriceListDetail {
  PriceListDetail({
    this.id,
    this.price,
    this.typeCar,
  });

  String? id;
  String? price;
  TypeCar? typeCar;

  factory PriceListDetail.fromJson(Map<String, dynamic> json) =>
      PriceListDetail(
        id: json["id"],
        price: json["price"],
        typeCar: TypeCar.fromJson(json["typeCar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "typeCar": typeCar!.toJson(),
      };
}

class TypeCar {
  TypeCar({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory TypeCar.fromJson(Map<String, dynamic> json) => TypeCar(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
