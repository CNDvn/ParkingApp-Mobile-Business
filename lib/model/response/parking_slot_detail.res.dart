// To parse this JSON data, do
//
//     final parkingSlotDetailRes = parkingSlotDetailResFromJson(jsonString);

import 'dart:convert';

class ParkingSlotDetailRes {
  ParkingSlotDetailRes({
    required this.result,
    this.statusCode,
  });

  ParkingSlotDetail result;
  int? statusCode;

  factory ParkingSlotDetailRes.fromJson(Map<String, dynamic> json) =>
      ParkingSlotDetailRes(
        result: ParkingSlotDetail.fromJson(json["result"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "statusCode": statusCode,
      };
  static ParkingSlotDetailRes parkingSlotDetailResFromJson(String str) =>
      ParkingSlotDetailRes.fromJson(json.decode(str));

  static String parkingSlotDetailResToJson(ParkingSlotDetailRes data) =>
      json.encode(data.toJson());
}

class ParkingSlotDetail {
  ParkingSlotDetail({
    this.id,
    this.locationName,
    this.status,
    this.bookings,
  });

  String? id;
  String? locationName;
  String? status;
  List<Booking>? bookings;

  factory ParkingSlotDetail.fromJson(Map<String, dynamic> json) => ParkingSlotDetail(
        id: json["id"],
        locationName: json["locationName"],
        status: json["status"],
        bookings: List<Booking>.from(
            json["bookings"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locationName": locationName,
        "status": status,
        "bookings": List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  Booking({
    this.id,
    this.startTime,
    this.status,
    this.price,
    this.car,
  });

  String? id;
  DateTime? startTime;
  String? status;
  String? price;
  Car? car;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        startTime: DateTime.parse(json["startTime"]),
        status: json["status"],
        price: json["price"],
        car: Car.fromJson(json["car"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime!.toIso8601String(),
        "status": status,
        "price": price,
        "car": car!.toJson(),
      };
}

class Car {
  Car({
    this.id,
    this.nPlates,
    this.brand,
    this.color,
    this.modelCode,
    this.images,
    this.typeCar,
    this.status,
    this.customer,
  });

  String? id;
  String? nPlates;
  String? brand;
  String? color;
  String? modelCode;
  List<Image>? images;
  TypeCar? typeCar;
  String? status;
  Customer? customer;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        nPlates: json["nPlates"],
        brand: json["brand"],
        color: json["color"],
        modelCode: json["modelCode"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        typeCar: TypeCar.fromJson(json["typeCar"]),
        status: json["status"],
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nPlates": nPlates,
        "brand": brand,
        "color": color,
        "modelCode": modelCode,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "typeCar": typeCar!.toJson(),
        "status": status,
        "customer": customer!.toJson(),
      };
}

class Customer {
  Customer({
    this.id,
    this.level,
    this.user,
  });

  String? id;
  int? level;
  User? user;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        level: json["level"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "user": user!.toJson(),
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
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "DOB": dob!.toIso8601String(),
        "status": status,
        "username": username,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "avatar": avatar,
        "fullName": fullName,
      };
}

class Image {
  Image({
    this.id,
    this.url,
  });

  String? id;
  String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
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
