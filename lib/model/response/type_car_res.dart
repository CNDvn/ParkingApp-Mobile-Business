// To parse this JSON data, do
//
//     final typeCarRes = typeCarResFromJson(jsonString);

import 'dart:convert';

import 'package:parking_app_mobile_business/model/response/parking_slot_detail.res.dart';

TypeCarRes typeCarResFromJson(String str) => TypeCarRes.fromJson(json.decode(str));

String typeCarResToJson(TypeCarRes data) => json.encode(data.toJson());

class TypeCarRes {
    TypeCarRes({
        this.result,
        this.statusCode,
    });

    List<TypeCar>? result;
    int? statusCode;

    factory TypeCarRes.fromJson(Map<String, dynamic> json) => TypeCarRes(
        result: List<TypeCar>.from(json["result"].map((x) => TypeCar.fromJson(x))),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
    };
}
