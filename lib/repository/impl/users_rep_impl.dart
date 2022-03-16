import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/profile_req.dart';
import 'package:parking_app_mobile_business/model/response/profile_res.dart';
import 'package:parking_app_mobile_business/model/response/users_me_res.dart';
import 'package:parking_app_mobile_business/repository/users_rep.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';

class UsersRepImpl implements UsersRepo {
  @override
  Future<UsersMeRes> getUsersMe(String url, String accessToken) async {
    var dataUsersMe = UsersMeRes();
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      dataUsersMe = UsersMeRes.usersMeResFromJson(jsonEncode(response.data));
      final SecureStorage secureStorage = SecureStorage();
      await secureStorage.writeSecureData("avatar", dataUsersMe.result!.avatar);
      await secureStorage.writeSecureData(
          "fullname", dataUsersMe.result!.fullName);
      await secureStorage.writeSecureData(
          "firstName", dataUsersMe.result!.firstName);
      await secureStorage.writeSecureData(
          "lastName", dataUsersMe.result!.lastName);
      await secureStorage.writeSecureData(
          "emailAddress", dataUsersMe.result!.email);
      await secureStorage.writeSecureData(
          "phoneNumber", dataUsersMe.result!.phoneNumber.substring(3));
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      String dob = dateFormat.format(dataUsersMe.result!.dob);
      await secureStorage.writeSecureData("DOB", dob);
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return dataUsersMe;
  }

  @override
  Future<ProfileRes> putProfile(
      String url, ProfileReq req, String accessToken) async {
    var result = ProfileRes();
    try {
      Response response = await Dio().put(url,
          data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = ProfileRes.profileResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
