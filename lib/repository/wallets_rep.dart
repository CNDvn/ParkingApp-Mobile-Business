import 'package:parking_app_mobile_business/model/response/wallet_res.dart';

abstract class WalletRepo {
  Future<WalletsRes> getMyWallet(String url, String token);
}