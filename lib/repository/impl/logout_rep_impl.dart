import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/response/log_out_res.dart';
import 'package:parking_app_mobile_business/repository/logout_rep.dart';

class LogOutImpl implements LogOutRep {
  @override
  Future<LogOutRes> postLogout(String url, String token) async {
    var result = LogOutRes();
    try {
      Dio dio = Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";
      Response response = await dio.post(url);
      result = LogOutRes.logOutResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

}