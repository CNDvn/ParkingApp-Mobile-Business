import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/model/response/parking_slot_detail.res.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_slot_detail_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';

class DetailSlotProvider with ChangeNotifier {
  ParkingSlotDetailRes data = ParkingSlotDetailRes(result: ParkingSlotDetail());

  Future<void> getDetailSlot(String id) async {
    var dataDetail = ParkingSlotDetailRes(result: ParkingSlotDetail());
    try {
      dataDetail = await ParkingSlotDetailImp()
          .getParkingDetailSlot(UrlApi.getParkingSlotDetail + id);
      data = dataDetail;
      notifyListeners();
    } catch (e) {}
  }
}
