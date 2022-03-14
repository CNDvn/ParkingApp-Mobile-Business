import 'package:parking_app_mobile_business/views/priceList/create_price_list_page.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_management_page.dart';
import 'package:parking_app_mobile_business/views/sign_in/signIn_page.dart';
import 'package:parking_app_mobile_business/views/sign_up/enter_password.dart';
import 'package:parking_app_mobile_business/views/sign_up/enter_verification_code.dart';
import 'package:parking_app_mobile_business/views/sign_up/sign_up_page.dart';
import 'package:parking_app_mobile_business/views/userProfile/user_profile.dart';
import 'package:parking_app_mobile_business/views/parking/new_parking_page.dart';
import 'package:parking_app_mobile_business/views/parking/parking_management_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // "/": (context) => const Root(),
    "/": (context) => const SignInPage(),
    "/CreatePriceList": (context) => const CreatePriceListPage(),
    "/ManagerPriceList": (context) => const PriceListManagementPage(),
    "/UserProfile": (context) => const UserProfile(),
    "/EnterPassword": (context) => const EnterPassword(),
    "/signUp": (context) => const SignUpPage(),
    "/EnterVerificationCode": (context) => EnterVerificationCode(),
    "/parkingManagement": (context) => const ParkingManagementPage(),
    "/createParking": (context) => const NewParkingPage(),
    "/PriceListManagementPage": (context) => const PriceListManagementPage(),
  };
}
