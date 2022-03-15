
import 'package:parking_app_mobile_business/model/response/parking_slot_res.dart';

abstract class ParkingSlotReq{
  Future<ParkingSlotRes> getParkingSlots(String url);
}