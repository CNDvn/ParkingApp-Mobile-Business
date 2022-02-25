import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/views/parking/new_parking_page.dart';
import 'package:parking_app_mobile_business/views/parking/parking_management_page.dart';
import 'package:parking_app_mobile_business/views/root.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // "/": (context) => const Root(),
    "/": (context) => const ParkingManagementPage(),
    // "/parkingManagement": (context) => const ParkingManagementPage(),
    // "/createParking": (context) => const NewParkingPage(),
  };
}
