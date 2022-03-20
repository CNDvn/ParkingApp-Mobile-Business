import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/repository/check_in_rep.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';

class CheckInRepImpl extends CheckinRep {
  @override
  Future<void> postCheckin(String url) async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      String accessToken = await secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString());
      Response response = await Dio().post(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      if (response.data != null) {
        showToastSuccess("Check-out Successful");
        return;
      }
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
  }

}