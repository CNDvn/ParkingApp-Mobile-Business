import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_rep_impl.dart';

class ValidationItem {
  String value;
  String? error;
  ValidationItem(this.value, this.error);
}

class NewParkingProvider with ChangeNotifier {
  ValidationItem parkingName = ValidationItem("", null);
  ValidationItem address = ValidationItem("", null);
  ValidationItem hotline = ValidationItem("", null);
  ValidationItem openTime = ValidationItem("", null);
  ValidationItem closeTime = ValidationItem("", null);

  FocusNode nodeParkingName = FocusNode();
  FocusNode nodeAddress = FocusNode();
  FocusNode nodeHotline = FocusNode();
  FocusNode nodeOpenTime = FocusNode();
  FocusNode nodeCloseTime = FocusNode();

  bool clickButtonFlag = false;

  bool checkParkingName(String value) {
    parkingName.value = value;
    bool flag = true;
    if (value.length < 5 && value.length > 200) {
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
    if (value.length < 5 && value.length > 200) {
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
      print("qua lai");
    }
    notifyListeners();
  }
}
