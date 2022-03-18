import 'dart:convert';

class PriceListCreate {
  String? idTypeCar;
  String? nameTypeCar;
  int? amount;
  PriceListCreate({
    this.idTypeCar,
    this.nameTypeCar,
    this.amount,
  });

  PriceListCreate copyWith({
    String? idTypeCar,
    String? nameTypeCar,
    int? amount,
  }) {
    return PriceListCreate(
      idTypeCar: idTypeCar ?? this.idTypeCar,
      nameTypeCar: nameTypeCar ?? this.nameTypeCar,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'idTypeCar': idTypeCar});
    result.addAll({'nameTypeCar': nameTypeCar});
    result.addAll({'amount': amount});
  
    return result;
  }

  factory PriceListCreate.fromMap(Map<String, dynamic> map) {
    return PriceListCreate(
      idTypeCar: map['idTypeCar'] ?? '',
      nameTypeCar: map['nameTypeCar'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListCreate.fromJson(String source) => PriceListCreate.fromMap(json.decode(source));

  @override
  String toString() => 'PriceListCreate(idTypeCar: $idTypeCar, nameTypeCar: $nameTypeCar, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PriceListCreate &&
      other.idTypeCar == idTypeCar &&
      other.nameTypeCar == nameTypeCar &&
      other.amount == amount;
  }

  @override
  int get hashCode => idTypeCar.hashCode ^ nameTypeCar.hashCode ^ amount.hashCode;
}
