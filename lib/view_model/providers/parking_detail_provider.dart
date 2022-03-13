import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/new_parking_req.dart';
import 'package:parking_app_mobile_business/repository/impl/New_Parking_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';

class ValidationItem {
  String value;
  String? error;
  ValidationItem(this.value, this.error);
}

class ParkingDetailProvider with ChangeNotifier {
  ValidationItem parkingName = ValidationItem("", null);
  ValidationItem address = ValidationItem("", null);
  ValidationItem hotline = ValidationItem("", null);
  ValidationItem openTime = ValidationItem("", null);
  ValidationItem closeTime = ValidationItem("", null);
  ValidationItem price = ValidationItem("", null);

  FocusNode nodeParkingName = FocusNode();
  FocusNode nodeAddress = FocusNode();
  FocusNode nodeHotline = FocusNode();
  FocusNode nodeOpenTime = FocusNode();
  FocusNode nodeCloseTime = FocusNode();
  FocusNode nodePrice = FocusNode();

  var parkingNameTextEditingController = TextEditingController(text: "Landmark 81");
  TextEditingController get parkingNameController => parkingNameTextEditingController;

  var addressTextEditingController = TextEditingController(text: "208 Đ. Nguyễn Hữu Cảnh, Phường 22, Bình Thạnh, Thành phố Hồ Chí Minh 700000, Vietnam");
  TextEditingController get addressController => addressTextEditingController;

  var hotlineTextEditingController = TextEditingController(text: "0974359136");
  TextEditingController get hotlineController => hotlineTextEditingController;

  var openTimeTextEditingController = TextEditingController(text: "00:00");
  TextEditingController get openTimeController => openTimeTextEditingController;

  var closeTimeTextEditingController = TextEditingController(text: "23:59");
  TextEditingController get closeTimeController => closeTimeTextEditingController;

  var priceTextEditingController = TextEditingController(text: "50.000");
  TextEditingController get priceController => priceTextEditingController;

  bool clickButtonFlag = false;

  bool checkParkingName(String value) {
    parkingName.value = value;
    bool flag = true;
    if (value.length < 5 || value.length > 200) {
      parkingName.error =
          "Parking name must greater 5 and smaller 200 character";
      flag = false;
    } else {
      parkingName.error = null;
    }
    notifyListeners();
    return flag;
  }

  bool checkAddress(String value) {
    address.value = value;
    bool flag = true;
    if (value.length < 5 || value.length > 200) {
      address.error = "Address invalid";
      flag = false;
    } else {
      address.error = null;
    }
    notifyListeners();
    return flag;
  }

  bool checkHotline(String value) {
    hotline.value = value;
    bool flag = true;
    if (value.length != 10) {
      hotline.error = "Hotline invalid";
      flag = false;
    } else {
      hotline.error = null;
    }
    notifyListeners();
    return flag;
  }

  String errorOpenTime = "";
  bool checkOpenTime(String value) {
    openTime.value = value;
    bool flag = true;
    if (value.isEmpty) {
      openTime.error = " ";
      errorOpenTime = "Please enter open time";
      flag = false;
    } else {
      if (openTime.value.isNotEmpty && closeTime.value.isNotEmpty) {
        List<String> open = openTime.value.split(":");
        List<String> close = closeTime.value.split(":");
        if (int.parse(close[0]) <= int.parse(open[0]) &&
            int.parse(close[1]) < int.parse(open[1])) {
          openTime.error = " ";
          errorOpenTime = "Open time must be smaller close time";
          return false;
        }
      } else {
        openTime.error = null;
        errorOpenTime = "";
      }
    }
    notifyListeners();
    return flag;
  }

  String errorCloseTime = "";
  bool checkCloseTime(String value) {
    closeTime.value = value;
    bool flag = true;
    if (value.isEmpty) {
      closeTime.error = " ";
      errorCloseTime = "please enter close time";
      flag = false;
    } else {
      if (openTime.value.isNotEmpty && closeTime.value.isNotEmpty) {
        List<String> open = openTime.value.split(":");
        List<String> close = closeTime.value.split(":");
        if (int.parse(close[0]) <= int.parse(open[0]) &&
            int.parse(close[1]) < int.parse(open[1])) {
          closeTime.error = " ";
          errorCloseTime = "close time must be greater open time";
          return false;
        }
      }
      closeTime.error = null;
      errorCloseTime = "";
    }
    notifyListeners();
    return flag;
  }

  void submit() {
    clickButtonFlag = true;
    bool isParkingName = checkParkingName(parkingName.value);
    bool isAddress = checkAddress(address.value);
    bool isHotline = checkHotline(hotline.value);
    bool isOpenTime = checkOpenTime(openTime.value);
    bool isCloseTime = checkCloseTime(closeTime.value);
    if (isParkingName && isAddress && isHotline && isOpenTime && isCloseTime) {
      final data = NewParkingReq(
        name: parkingName.value,
        address: address.value,
        closeTime: closeTime.value,
        openTime: openTime.value,
        phoneNumber: hotline.value,
      );
      NewParkingRepImpl().postCreateParking(UrlApi.createParking, data).then((value) => {
        showToastSuccess(value.result!),
        
      });
    }
  }
}
