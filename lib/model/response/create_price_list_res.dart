// To parse this JSON data, do
//
//     final priceListRes = priceListResFromJson(jsonString);

import 'dart:convert';

class PriceListRes {
    PriceListRes({
        this.result,
        this.statusCode,
    });

    String? result;
    int? statusCode;

    factory PriceListRes.fromJson(Map<String, dynamic> json) => PriceListRes(
        result: json["result"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
    };

    static PriceListRes priceListResFromJson(String str) => PriceListRes.fromJson(json.decode(str));

    String priceListResToJson(PriceListRes data) => json.encode(data.toJson());
}
