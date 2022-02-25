import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/response/parking_res.dart';
import 'package:parking_app_mobile_business/repository/parking_rep.dart';

class ParkingImpl implements ParkingRepo {
  @override
  Future<ParkingRes> getParking(String url) async {
    var result = ParkingRes();
    try {
      Dio dio = Dio();
      dio.options.headers["authorization"] =
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE5OTQwNjkwLWIyMWEtNGZlYy1hZTM5LTAzZDk1NDI1NGZmZiIsInVzZXJuYW1lIjoiY2VvIiwicm9sZXMiOlsiYnVzaW5lc3MiXSwiaWF0IjoxNjQ1NzM4NTU4LCJleHAiOjE2NDU5OTc3NTh9.WlCvzWCnnrNTXm1mhzNaL2_CbmukV_dTH0jHIqNIcjg";
      Response response = await dio.get(url);
      result = ParkingRes.parkingResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
