
import 'package:parking_app_mobile_business/model/request/sign_up_req.dart';
import 'package:parking_app_mobile_business/model/response/sugn_up_res.dart';

abstract class SignUpRepo {
  Future<SignUpRes> postSignUp(String url, SignUpReq payload);
}
