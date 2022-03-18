// To parse this JSON data, do
//
//     final priceListReq = priceListReqFromJson(jsonString);

import 'dart:convert';

PriceListReq priceListReqFromJson(String str) =>
    PriceListReq.fromJson(json.decode(str));

String priceListReqToJson(PriceListReq data) => json.encode(data.toJson());

class PriceListReq {
  PriceListReq({
    this.name,
    this.priceListDetails,
  });

  String? name;
  List<PriceListDetail>? priceListDetails;

  factory PriceListReq.fromJson(Map<String, dynamic> json) => PriceListReq(
        name: json["name"],
        priceListDetails: List<PriceListDetail>.from(
            json["priceListDetails"].map((x) => PriceListDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "priceListDetails":
            List<dynamic>.from(priceListDetails!.map((x) => x.toJson())),
      };
}

class PriceListDetail {
  PriceListDetail({
    required this.typeCarId,
    required this.price,
  });

  String typeCarId;
  double price;

  factory PriceListDetail.fromJson(Map<String, dynamic> json) =>
      PriceListDetail(
        typeCarId: json["typeCarId"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "typeCarId": typeCarId,
        "price": price,
      };
}
