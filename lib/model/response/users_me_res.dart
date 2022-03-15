// To parse this JSON data, do
//
//     final usersMeRes = usersMeResFromJson(jsonString);

import 'dart:convert';

class UsersMeRes {
  UsersMeRes({
    this.result,
    this.statusCode,
  });

  Result? result;
  int? statusCode;

  factory UsersMeRes.fromJson(Map<String, dynamic> json) => UsersMeRes(
        result: Result.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "statusCode": statusCode,
      };

  static UsersMeRes usersMeResFromJson(String str) =>
      UsersMeRes.fromJson(json.decode(str));

  String usersMeResToJson(UsersMeRes data) => json.encode(data.toJson());
}

class Result {
  Result({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.status,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.avatar,
    required this.business,
    required this.role,
    required this.fullName,
  });

  String id;
  String firstName;
  String lastName;
  DateTime dob;
  String status;
  String username;
  String phoneNumber;
  String email;
  String address;
  String avatar;
  Business business;
  Role role;
  String fullName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: DateTime.parse(json["DOB"]),
        status: json["status"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
        avatar: json["avatar"],
        business: Business.fromJson(json["business"]),
        role: Role.fromJson(json["role"]),
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "DOB": dob.toIso8601String(),
        "status": status,
        "username": username,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "avatar": avatar,
        "business": business.toJson(),
        "role": role.toJson(),
        "fullName": fullName,
      };
}

class Business {
  Business({
    required this.id,
  });

  String id;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
