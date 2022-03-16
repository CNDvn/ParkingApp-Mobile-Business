import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/entity/wallet.dart';
import 'package:parking_app_mobile_business/model/response/wallet_res.dart';
import 'package:parking_app_mobile_business/repository/wallets_rep.dart';

class WalletRepImpl implements WalletRepo {
  @override
  Future<WalletsRes> getMyWallet(String url, String accessToken) async {
    Wallets a = Wallets(
        id: "",
        currentBalance: "",
        frozenMoney: "",
        expiredTime: DateTime.now(),
        createdTime: DateTime.now());
    var result = WalletsRes(result: a);
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = WalletsRes.walletsResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
