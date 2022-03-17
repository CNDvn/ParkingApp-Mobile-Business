import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/exception/show_alert_dialog.dart';
import 'package:parking_app_mobile_business/repository/impl/logout_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/sign_in_provider.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/views/sign_in/signIn_page.dart';
import 'package:provider/provider.dart';

class LogOutProvider with ChangeNotifier {

  Future<void> _signOut(BuildContext context) async {
    try {
      final SecureStorage secureStorage = SecureStorage();
      String accessToken = await secureStorage.readSecureData("token");
      LogOutImpl().postLogout("", accessToken);
      secureStorage.deleteAll();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> confirmSignOut(BuildContext context) async {
    SignInProvider signInProvider = Provider.of<SignInProvider>(context, listen: false);
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure that you want to logout?',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      _signOut(context);
      signInProvider.clearPhoneController();
      signInProvider.clearPasswordController();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const SignInPage()),
          ModalRoute.withName('/'));
    }
  }
}