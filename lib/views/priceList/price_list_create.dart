import 'dart:convert';

import 'package:flutter/material.dart';

class PriceListCreate {
  String? idTypeCar;
  String? nameTypeCar;
  String? amount;
  TextEditingController? controller;
  PriceListCreate(
      {this.idTypeCar, this.nameTypeCar, this.amount, this.controller});

  PriceListCreate copyWith({
    String? idTypeCar,
    String? nameTypeCar,
    String? amount,
    TextEditingController? controller,
  }) {
    return PriceListCreate(
      idTypeCar: idTypeCar ?? this.idTypeCar,
      nameTypeCar: nameTypeCar ?? this.nameTypeCar,
      amount: amount ?? this.amount,
      controller: controller ?? this.controller,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (idTypeCar != null) {
      result.addAll({'idTypeCar': idTypeCar});
    }
    if (nameTypeCar != null) {
      result.addAll({'nameTypeCar': nameTypeCar});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }

    return result;
  }

  factory PriceListCreate.fromMap(Map<String, dynamic> map) {
    return PriceListCreate(
      idTypeCar: map['idTypeCar'],
      nameTypeCar: map['nameTypeCar'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListCreate.fromJson(String source) =>
      PriceListCreate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PriceListCreate(idTypeCar: $idTypeCar, nameTypeCar: $nameTypeCar, amount: $amount, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceListCreate &&
        other.idTypeCar == idTypeCar &&
        other.nameTypeCar == nameTypeCar &&
        other.amount == amount &&
        other.controller == controller;
  }

  @override
  int get hashCode {
    return idTypeCar.hashCode ^
        nameTypeCar.hashCode ^
        amount.hashCode ^
        controller.hashCode;
  }
}
