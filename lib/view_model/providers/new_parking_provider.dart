import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/new_parking_req.dart';
import 'package:parking_app_mobile_business/repository/impl/New_Parking_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:http/http.dart' as http;

const String apiKey =
    '5b3ce3597851110001cf62480a3c8b8ff5eb4d889ea0af6dd8059502';

class ValidationItem {
  String value;
  String? error;
  ValidationItem(this.value, this.error);
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}

class GetLocal {
  GetLocal({required this.address});
  final String address;

  String url = 'https://api.openrouteservice.org/geocode/search';

  Future getData() async {
    http.Response response =
        await http.get(Uri.parse('$url?api_key=$apiKey&text=$address&size=1'));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      log(response.statusCode.toString());
    }
  }
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
   var point = LatLng(10.794862, 106.721784);
  MapController mapController = MapController();
  List<Address> location = [];

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

  void getJsonData() async {
    GetLocal local = GetLocal(address: address.value);

    try {
      // ignore: prefer_typing_uninitialized_variables
      var data1;
      data1 = await local.getData();
      LineString ls_1 =
          LineString(data1['features'][0]['geometry']['coordinates']);
      point = LatLng(ls_1.lineString[1], ls_1.lineString[0]);
      Future.delayed(const Duration(milliseconds: 50), () {
        mapController.move(point, 16.5);
      });
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
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

  void submit(BuildContext context) {
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
          phoneNumber: "+84" + hotline.value.substring(1),
          coordinate: Coordinate(
            latitude: point.latitude,
            longitude: point.longitude
          )
      );
      NewParkingRepImpl().postCreateParking(UrlApi.createParking, data).then((value) => {
        showToastSuccess(value.result!),
                Navigator.pushReplacementNamed(context, "/parkingManagement")
        
      });
    }
  }
}
