import 'package:flutter/cupertino.dart';
import 'package:parkingapp_mobile_business/views/sign_in/signIn_page.dart';
import 'package:parkingapp_mobile_business/views/sign_up/enter_password.dart';
import 'package:parkingapp_mobile_business/views/sign_up/enter_phone_number.dart';
import 'package:parkingapp_mobile_business/views/sign_up/enter_verification_code.dart';
import 'package:parkingapp_mobile_business/views/userProfile/user_profile.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    // "/": (context) => const Root(),
    "/": (context) => const SignInPage(),
    "/UserProfile": (context) => const UserProfile(),
    "/EnterPassword": (context) => const EnterPassword(),
    "/EnterPhoneNumber": (context) => const EnterPhoneNumber(),
    "/EnterVerificationCode": (context) => const EnterVerificationCode(),
  };
}
