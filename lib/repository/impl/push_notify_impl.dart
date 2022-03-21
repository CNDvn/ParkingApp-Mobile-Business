import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/model/request/push_notify_req.dart';
import 'package:parking_app_mobile_business/model/response/push_notify_res.dart';
import 'package:parking_app_mobile_business/repository/push_notify_rep.dart';

class PushNotifyImp implements PushNotifyRepo {
  @override
  Future<PushNotifyRes> pushNotify(
      String url, String accessToken, PushNotifyReq req) async {
    var result = PushNotifyRes();
    try {
      Response response = await Dio().put(url,
          data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
