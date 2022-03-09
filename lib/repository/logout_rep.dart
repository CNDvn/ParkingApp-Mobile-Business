import 'package:parking_app_mobile_business/model/response/log_out_res.dart';

abstract class LogOutRep{
  Future<LogOutRes> postLogout(String url, String token);
}