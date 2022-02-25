import 'package:parking_app_mobile_business/model/response/parking_res.dart';

abstract class ParkingRepo {
  Future<ParkingRes> getParking(String url);
}
