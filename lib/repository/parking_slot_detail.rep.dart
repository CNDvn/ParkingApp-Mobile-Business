import 'package:parking_app_mobile_business/model/response/parking_slot_detail.res.dart';

abstract class ParkingSlotDetailReq {
   Future<ParkingSlotDetailRes> getParkingDetailSlot(String url);
}