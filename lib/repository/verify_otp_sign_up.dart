

import 'package:parking_app_mobile_business/model/request/verify_otp_req.dart';
import 'package:parking_app_mobile_business/model/response/verify_otp_res.dart';

abstract class VerifyRepo {
  Future<VerifyOtpRes> postVerifyOTPSignUp(String url, VerifyOtpSignUpReq payload);
}
