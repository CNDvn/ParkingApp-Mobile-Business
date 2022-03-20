// To parse this JSON data, do
//
//     final parkingRes = parkingResFromJson(jsonString);

import 'dart:convert';

import 'package:parking_app_mobile_business/model/entity/business.dart';
import 'package:parking_app_mobile_business/model/entity/image.dart';

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
    static ParkingRes parkingResFromJson(String str) => ParkingRes.fromJson(json.decode(str));

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
    dynamic prevPage;
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
    List<Images>? images;
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
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
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

class Business {
    Business({
        this.id,
        this.user,
    });

    String? id;
    User? user;

    factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.dob,
        this.status,
        this.username,
        this.phoneNumber,
        this.email,
        this.address,
        this.avatar,
        this.role,
        this.fullName,
    });

    String? id;
    String? firstName;
    String? lastName;
    DateTime? dob;
    String? status;
    String? username;
    String? phoneNumber;
    String? email;
    String? address;
    String? avatar;
    Role? role;
    String? fullName;

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        role: Role.fromJson(json["role"]),
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "DOB": dob?.toIso8601String(),
        "status": status,
        "username": username,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "avatar": avatar,
        "role": role?.toJson(),
        "fullName": fullName,
    };
}

class Role {
    Role({
        this.id,
        this.name,
    });

    String? id;
    String? name;

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Coordinates {
    Coordinates({
        this.latitude,
        this.longitude,
    });

    double? latitude;
    double? longitude;

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
