// To parse this JSON data, do
//
//     final walletsRes = walletsResFromJson(jsonString);

import 'dart:convert';
import 'package:parking_app_mobile_business/model/entity/wallet.dart';

class WalletsRes {
  WalletsRes({
    required this.result,
    this.statusCode,
  });

  Wallets result;
  int? statusCode;

  factory WalletsRes.fromJson(Map<String, dynamic> json) => WalletsRes(
        result: Wallets.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "statusCode": statusCode,
      };

  static WalletsRes walletsResFromJson(String str) =>
      WalletsRes.fromJson(json.decode(str));

  String walletsResToJson(WalletsRes data) => json.encode(data.toJson());
}
