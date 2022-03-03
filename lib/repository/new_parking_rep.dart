import 'package:parking_app_mobile_business/model/request/new_parking_req.dart';
import 'package:parking_app_mobile_business/model/response/new_parking_res.dart';

abstract class NewParkingRep{
  Future<NewParkingRes> postCreateParking(String url, NewParkingReq req);
}