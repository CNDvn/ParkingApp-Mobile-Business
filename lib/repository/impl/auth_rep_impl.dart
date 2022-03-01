import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/model/request/sign_in_req.dart';
import 'package:parking_app_mobile_business/model/response/sign_in_res.dart';
import 'package:parking_app_mobile_business/repository/auth_rep.dart';

class AuthRepImpl implements AuthRepo {
  @override
  Future<SignInRes> postSignIn(String url, SignInReq req) async {
    var result = SignInRes();
    url = "http://192.168.1.11:5000/api/v1/auths/login";
    try {
      Response response = await Dio().post(url, data: req.toJson());
      result = SignInRes.signInResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      // showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
