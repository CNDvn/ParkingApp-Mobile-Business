// To parse this JSON data, do
//
//     final newParkingRes = newParkingResFromJson(jsonString);

import 'dart:convert';

NewParkingRes newParkingResFromJson(String str) => NewParkingRes.fromJson(json.decode(str));

String newParkingResToJson(NewParkingRes data) => json.encode(data.toJson());

class NewParkingRes {
    NewParkingRes({
        this.result,
        this.statusCode,
    });

    String? result;
    int? statusCode;

    factory NewParkingRes.fromJson(Map<String, dynamic> json) => NewParkingRes(
        result: json["result"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
    };
}
