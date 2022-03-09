// To parse this JSON data, do
//
//     final logOutRes = logOutResFromJson(jsonString);

import 'dart:convert';

class LogOutRes {
    LogOutRes({
        this.result,
        this.statusCode,
    });

    String? result;
    int? statusCode;

    factory LogOutRes.fromJson(Map<String, dynamic> json) => LogOutRes(
        result: json["result"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
    };

    static LogOutRes logOutResFromJson(String str) => LogOutRes.fromJson(json.decode(str));

    String logOutResToJson(LogOutRes data) => json.encode(data.toJson());
}