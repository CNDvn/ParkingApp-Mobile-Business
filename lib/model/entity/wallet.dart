import 'package:parking_app_mobile_business/model/entity/user.dart';

class Wallets {
  Wallets({
    required this.id,
    required this.currentBalance,
    required this.frozenMoney,
    required this.expiredTime,
    required this.createdTime,
    this.user,
  });

  String id;
  String currentBalance;
  String frozenMoney;
  DateTime expiredTime;
  DateTime createdTime;
  User? user;

  factory Wallets.fromJson(Map<String, dynamic> json) => Wallets(
        id: json["id"],
        currentBalance: json["currentBalance"],
        frozenMoney: json["frozenMoney"],
        expiredTime: DateTime.parse(json["expiredTime"]),
        createdTime: DateTime.parse(json["createdTime"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currentBalance": currentBalance,
        "frozenMoney": frozenMoney,
        "expiredTime": expiredTime,
        "createdTime": createdTime,
        "user": user!.toJson(),
      };
}
