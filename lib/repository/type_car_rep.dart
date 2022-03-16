import 'package:parking_app_mobile_business/model/response/list_type_car_res.dart';

abstract class TypeCarRepo {
  Future<TypeCarRes> getAllTypeCars(String url);
}
