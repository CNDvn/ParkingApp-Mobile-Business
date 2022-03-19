import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/create_price_list_req.dart';
import 'package:parking_app_mobile_business/model/response/create_price_list_res.dart';
import 'package:parking_app_mobile_business/repository/create_price_list_rep.dart';

class PriceListRepImpl implements PriceListRepo {
  @override
  Future<PriceListRes> postPriceList(
      String url, String accessToken, PriceListReq payload) async {
    var result = PriceListRes();
    try {
      Response response = await Dio().post(url,
          data: payload,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = PriceListRes.priceListResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }

  @override
  Future<PriceListRes> putPriceList(String url, String accessToken, PriceListReq data) async {
    var result = PriceListRes();
    try {
      Response response = await Dio().put(url,
          data: data,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));
      result = PriceListRes.priceListResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
