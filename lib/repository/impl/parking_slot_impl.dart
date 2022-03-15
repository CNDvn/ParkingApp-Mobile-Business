import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/response/parking_slot_res.dart';
import 'package:parking_app_mobile_business/repository/parking_slot.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';

class ParkingSlotImp implements ParkingSlotReq {
  @override
  Future<ParkingSlotRes> getParkingSlots(String url) async {
    var result = ParkingSlotRes();
    final SecureStorage secureStorage = SecureStorage();
    try {
      var token = await secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString());
      Dio dio = Dio();
      Response response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
      result = ParkingSlotRes.parkingSlotResFromJson(jsonEncode(response.data));
    } catch (e) {
      showToastFail(e.toString());
    }
    return result;
  }
}
