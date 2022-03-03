import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/response/new_parking_res.dart';
import 'package:parking_app_mobile_business/model/request/new_parking_req.dart';
import 'package:parking_app_mobile_business/repository/new_parking_rep.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';

class NewParkingRepImpl implements NewParkingRep {
  @override
  Future<NewParkingRes> postCreateParking(String url, NewParkingReq req) async {
    var result = NewParkingRes();
    try {
      final SecureStorage secureStorage = SecureStorage();
      String accessToken = await secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString());
      Response response = await Dio().post(url,
          data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = NewParkingReq.newParkingResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data['message']);
    }
    return result;
  }
}
