import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/exception/exception.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/sign_in_req.dart';
import 'package:parking_app_mobile_business/repository/impl/auth_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/view_model/providers/view_model/auth.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';
import 'package:parking_app_mobile_business/views/parking/parking_management_page.dart';

class ValidationItem {
  final String? value;
  final String? error;
  ValidationItem(this.value, this.error);
}

class SignInProvider with ChangeNotifier {
  ValidationItem _phone = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  bool isPasswordVariable = true;
  bool submitValid = false;

  final _phoneTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();

  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  ValidationItem get phone => _phone;
  ValidationItem get password => _password;

  TextEditingController get phoneController => _phoneTextEditController;
  TextEditingController get passwordController => _passwordTextEditController;

  String get textPhone => phoneController.text;
  String get textPassword => passwordController.text;

  FocusNode get phoneFocus => _phoneFocus;
  FocusNode get passwordFocus => _passwordFocus;

  void clearPhoneController() {
    phoneController.clear();
    notifyListeners();
  }

  void clearPasswordController() {
    passwordController.clear();
    notifyListeners();
  }

  void changePasswordVariable() {
    isPasswordVariable = !isPasswordVariable;
    notifyListeners();
  }

  void checkPhone(String value) {
    if (value.isEmpty) {
      _phone = ValidationItem(value, "Phone is empty");
    } else if (value.length < 10) {
      _phone = ValidationItem(value, "Phone must 10 character");
    } else {
      _phone = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void checkPassword(String value) {
    if (value.isEmpty) {
      _password = ValidationItem(value, "Password is empty");
    } else if (value.length < 8) {
      _password = ValidationItem(value, "Password must 8 character");
    } else {
      _password = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeFocus(BuildContext context, String field) {
    var newFocus = _phoneFocus;
    if (_phone.value != null && field.contains("phone")) {
      newFocus = _passwordFocus;
      FocusScope.of(context).requestFocus(newFocus);
      return;
    }
    if (_password.value != null && field.contains('password')) {
      FocusScope.of(context).unfocus();
      submitData(context);
    }
  }

  bool get isValid {
    if (_phone.value != null && _password.value != null) {
      return true;
    }
    return false;
  }

  void submitData(BuildContext context) {
    submitValid = _phone.error != null ||
        _password.error != null ||
        _phone.value == null ||
        password.value == null;

    if (submitValid) {
      checkPhone(_phone.value ?? "");
      checkPassword(_password.value ?? "");
      notifyListeners();
    } else if (!submitValid && isValid) {
      AuthRepImpl()
          .postSignIn(
              UrlApi.login,
              SignInReq(
                  username: phone.value!,
                  password: password.value!,
                  role: "business"))
          .then((value) async {
        final SecureStorage secureStorage = SecureStorage();
        await secureStorage.writeSecureData(StorageEnum.accessToken.toShortString(), value.result!.accessToken);
        await secureStorage.writeSecureData(
            StorageEnum.refreshToken.toShortString(), value.result!.refreshToken);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ParkingManagementPage();
        }));
      }).onError(
        (error, stackTrace) {
          log(error.toString());
          showToastFail("login failed");
          notifyListeners();
        },
      );
    }
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') return;
    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  final AuthBase auth = Auth();
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      User? user = await auth.signInWithGoogle();
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ParkingManagementPage();
        }));
      }
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }
}
