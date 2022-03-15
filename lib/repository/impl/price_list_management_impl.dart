import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/response/price_list_management_res.dart';
import 'package:parking_app_mobile_business/repository/price_list_management_rep.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';

class PriceListManagementImpl implements PriceListManagementRepo {
  @override
  Future<PriceListManagementRes> getAllPriceListByParking(String url, String idParking) async {
     var result = PriceListManagementRes();
    try {
      final SecureStorage secureStorage = SecureStorage();
      String accessToken = await secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString());
      Response response = await Dio().get(url+"/$idParking",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = PriceListManagementRes.PriceListManagementResFromJson(
          jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data['message']);
    }

    return result;
  }
}
