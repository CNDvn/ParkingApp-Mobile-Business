import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/response/list_type_car_res.dart';
import 'package:parking_app_mobile_business/repository/type_car_rep.dart';

class TypeCarImpl implements TypeCarRepo {
  @override
  Future<TypeCarRes> getAllTypeCars(String url) async {
    var result = TypeCarRes();
    try {
      Response response = await Dio().get(url);
      result = TypeCarRes.typeCarResFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      showToastFail(e.response?.data['message']);
    }
    return result;
  }
}
