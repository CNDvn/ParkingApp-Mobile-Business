// To parse this JSON data, do
//
//     final typeCarRes = typeCarResFromJson(jsonString);

import 'dart:convert';

TypeCarRes typeCarResFromJson(String str) =>
    TypeCarRes.fromJson(json.decode(str));

String typeCarResToJson(TypeCarRes data) => json.encode(data.toJson());

class TypeCarRes {
  TypeCarRes({
    this.result,
    this.statusCode,
  });

  List<Result>? result;
  int? statusCode;

  factory TypeCarRes.fromJson(Map<String, dynamic> json) => TypeCarRes(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };

  static TypeCarRes typeCarResFromJson(String str) =>
      TypeCarRes.fromJson(json.decode(str));
  static String typeCarResToJson(TypeCarRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
