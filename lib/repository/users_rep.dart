import 'package:parking_app_mobile_business/model/request/profile_req.dart';
import 'package:parking_app_mobile_business/model/response/profile_res.dart';
import 'package:parking_app_mobile_business/model/response/users_me_res.dart';

abstract class UsersRepo {
  Future<UsersMeRes> getUsersMe(String url, String accessToken);
  Future<ProfileRes> putProfile(String url, ProfileReq req, String accessToken);
}