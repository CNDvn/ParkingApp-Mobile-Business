

import 'package:parking_app_mobile_business/model/request/push_notify_req.dart';
import 'package:parking_app_mobile_business/model/response/push_notify_res.dart';

abstract class PushNotifyRepo {
  Future<PushNotifyRes> pushNotify(
      String url, String accessToken, PushNotifyReq req);
}
