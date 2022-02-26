import 'package:parkingapp_mobile_business/model/request/sign_in_req.dart';
import 'package:parkingapp_mobile_business/model/response/sign_in_res.dart';

abstract class AuthRepo {
  Future<SignInRes> postSignIn(String url, SignInReq req);
}