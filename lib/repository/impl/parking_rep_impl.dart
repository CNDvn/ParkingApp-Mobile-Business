import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/new_parking_req.dart';
import 'package:parking_app_mobile_business/model/response/parking_detail_res.dart';
import 'package:parking_app_mobile_business/model/response/parking_res.dart';
import 'package:parking_app_mobile_business/repository/parking_rep.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';

class ParkingImpl implements ParkingRepo {
  @override
  Future<ParkingRes> getParking(String url) async {
    var result = ParkingRes();
    try {
      final SecureStorage secureStorage = SecureStorage();
      String accessToken = await secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString());

      Response response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = ParkingRes.parkingResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<ParkingDetailRes> getDetailParking(String url) async {
    var result = ParkingDetailRes();
    try {
      Response response = await Dio().get(url);
      result = ParkingDetailRes.parkingFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<void> putUpdateParking(String url, NewParkingReq req) async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      String accessToken = await secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString());
      Response response = await Dio().put(url,
          data: req.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      if (response.data != null) {
        showToastSuccess("Update Successful");
        return;
      }
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
  }

  @override
  Future<void> deleteParking(String url) async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      String accessToken = await secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString());
      Response response = await Dio().delete(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      if (response.data != null) {
        showToastSuccess("Delete Successful");
        return;
      }
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
  }
}
