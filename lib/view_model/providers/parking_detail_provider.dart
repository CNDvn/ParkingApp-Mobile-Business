import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/entity/image.dart';
import 'package:parking_app_mobile_business/model/response/parking_detail_res.dart';
import 'package:parking_app_mobile_business/model/request/new_parking_req.dart';
import 'package:parking_app_mobile_business/repository/impl/New_Parking_rep_impl.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_rep_impl.dart';
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

  var parkingNameTextEditingController = TextEditingController();
  TextEditingController get parkingNameController => parkingNameTextEditingController;

  var addressTextEditingController = TextEditingController();
  TextEditingController get addressController => addressTextEditingController;

  var hotlineTextEditingController = TextEditingController();
  TextEditingController get hotlineController => hotlineTextEditingController;

  var openTimeTextEditingController = TextEditingController();
  TextEditingController get openTimeController => openTimeTextEditingController;

  var closeTimeTextEditingController = TextEditingController();
  TextEditingController get closeTimeController => closeTimeTextEditingController;

  var priceTextEditingController = TextEditingController();
  TextEditingController get priceController => priceTextEditingController;

  bool clickButtonFlag = false;

  ParkingDetailRes parking = ParkingDetailRes();
  List<Images> images =[];
  String status ="";
  String idParking ="";
  double lat = 0;
  double long = 0;
  getInfo(String id) async {
    idParking ="";
    status ="";
    String url ='${UrlApi.serverPath}/parkings/$id';
    parking = await ParkingImpl().getDetailParking(url);
    parkingNameController.text = parking.result!.name!;
    addressController.text= parking.result!.address!;
    hotlineController.text = "0"+parking.result!.phoneNumber!.split("+84")[1];
    openTimeController.text = parking.result!.openTime!.split(":")[0]+":"+parking.result!.openTime!.split(":")[1];
    closeTimeController.text = parking.result!.closeTime!.split(":")[0]+":"+parking.result!.closeTime!.split(":")[1];
    //-----------------
    parkingName.value = parking.result!.name!;
    address.value= parking.result!.address!;
    hotline.value = "0"+parking.result!.phoneNumber!.split("+84")[1];
    openTime.value = parking.result!.openTime!.split(":")[0]+":"+parking.result!.openTime!.split(":")[1];
    closeTime.value = parking.result!.closeTime!.split(":")[0]+":"+parking.result!.closeTime!.split(":")[1];
    //------------------
    images =parking.result!.images!;
    status = parking.result!.status!;
    idParking =parking.result!.id!;
    lat = parking.result!.coordinates!.latitude!;
    long = parking.result!.coordinates!.longitude!;
    notifyListeners();
  }

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

  void changeFocus(BuildContext context, String field) {
    var newFocus = nodeParkingName;
    if (parkingName.value.isNotEmpty && field.contains("nameparking")) {
      newFocus = nodeHotline;
      FocusScope.of(context).requestFocus(newFocus);
      return;
    }
    if (hotline.value.isNotEmpty && field.contains("hotline")) {
      newFocus = nodeOpenTime;
      FocusScope.of(context).requestFocus(newFocus);
      return;
    }
    if (openTime.value.isNotEmpty && field.contains("opentime")) {
      newFocus = nodeCloseTime;
      FocusScope.of(context).requestFocus(newFocus);
      return;
    }
    if (closeTime.value.isNotEmpty && field.contains("closetime")) {
      FocusScope.of(context).unfocus();
      update(context);
    }
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
  
  convertTime() {
    String open0 = openTime.value.split(":")[0].length ==1 ? "0"+openTime.value.split(":")[0] : openTime.value.split(":")[0];
      String open1 = openTime.value.split(":")[1].length ==1 ? "0"+openTime.value.split(":")[1] : openTime.value.split(":")[1];
      String close0 = closeTime.value.split(":")[0].length ==1 ? "0"+closeTime.value.split(":")[0] : closeTime.value.split(":")[0];
      String close1 = closeTime.value.split(":")[1].length ==1 ? "0"+closeTime.value.split(":")[1] : closeTime.value.split(":")[1];
      openTime.value = open0+":"+open1;
      closeTime.value = close0+":"+close1;
      notifyListeners();
  }

  void update(BuildContext context) {
    clickButtonFlag = true;
    bool isParkingName = checkParkingName(parkingName.value);
    bool isAddress = checkAddress(address.value);
    bool isHotline = checkHotline(hotline.value);
    bool isOpenTime = checkOpenTime(openTime.value);
    bool isCloseTime = checkCloseTime(closeTime.value);
    if (isParkingName && isAddress && isHotline && isOpenTime && isCloseTime) {
      convertTime();
      final data = NewParkingReq(
        name: parkingName.value,
        address: address.value,
        closeTime: closeTime.value,
        openTime: openTime.value,
        phoneNumber: "+84"+hotline.value.substring(1),
        coordinate: Coordinate(latitude: lat, longitude: long)
      );
      String url ='${UrlApi.serverPath}/parkings/$idParking';
      ParkingImpl().putUpdateParking(url, data);
      notifyListeners();
    }  
  }

  void delete() {
    String url ='${UrlApi.serverPath}/parkings/$idParking';
    ParkingImpl().deleteParking(url);
    notifyListeners();
  }
}
