import 'package:parking_app_mobile_business/model/request/new_parking_req.dart';
import 'package:parking_app_mobile_business/model/response/parking_detail_res.dart';
import 'package:parking_app_mobile_business/model/response/parking_res.dart';

abstract class ParkingRepo {
  Future<ParkingRes> getParking(String url);
  Future<ParkingDetailRes> getDetailParking(String url);
  Future<void> putUpdateParking(String url,NewParkingReq req);
  Future<void> deleteParking(String url);
}
