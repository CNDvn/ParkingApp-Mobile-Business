import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/sign_up_req.dart';
import 'package:parking_app_mobile_business/repository/impl/signup_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/sign_in_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/views/sign_up/enter_verification_code.dart';

class SignUpProvider with ChangeNotifier {
  ValidationItem _phone = ValidationItem("", "");
  ValidationItem _password = ValidationItem("", "");
  ValidationItem _firstName = ValidationItem("", "");
  ValidationItem _lastName = ValidationItem("", "");
  ValidationItem _email = ValidationItem("", "");
  ValidationItem _address = ValidationItem("", "");

  final _phoneTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();
  final _firstNameTextEditController = TextEditingController();
  final _lastNameTextEditController = TextEditingController();
  final _emailTextEditController = TextEditingController();
  final _addressTextEditController = TextEditingController();
  final _dobEditController = TextEditingController();

  TextEditingController get phoneController => _phoneTextEditController;
  TextEditingController get passwordController => _passwordTextEditController;
  TextEditingController get firstNameController => _firstNameTextEditController;
  TextEditingController get lastNameController => _lastNameTextEditController;
  TextEditingController get emailController => _emailTextEditController;
  TextEditingController get addressController => _addressTextEditController;
  TextEditingController get dobController => _dobEditController;

  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _addressFocus = FocusNode();

  FocusNode get phoneFocus => _phoneFocus;
  FocusNode get passwordFocus => _passwordFocus;
  FocusNode get firstNameFocus => _firstNameFocus;
  FocusNode get lastNameFocus => _lastNameFocus;
  FocusNode get emailFocus => _emailFocus;
  FocusNode get addressFocus => _addressFocus;

  bool submitValid = false;
  bool isPasswordVariable = true;

  //phone
  ValidationItem get phone => _phone;
  ValidationItem get password => _password;
  ValidationItem get firstName => _firstName;
  ValidationItem get lastName => _lastName;
  ValidationItem get email => _email;
  ValidationItem get address => _address;

  String get textPhone => phoneController.text;
  String get textPassword => passwordController.text;
  String get textFirstName => firstNameController.text;
  String get textLastName => lastNameController.text;
  String get textEmail => emailController.text;
  String get textAddress => addressController.text;

  void clearPhoneController() {
    phoneController.clear();
    notifyListeners();
  }

  void clearPasswordController() {
    passwordController.clear();
    notifyListeners();
  }

  void clearFirstNameController() {
    firstNameController.clear();
    notifyListeners();
  }

  void clearLastNameController() {
    lastNameController.clear();
    notifyListeners();
  }

  void clearEmailController() {
    emailController.clear();
    notifyListeners();
  }

  void clearAddressController() {
    addressController.clear();
    notifyListeners();
  }

  void changePasswordVariable() {
    isPasswordVariable = !isPasswordVariable;
    notifyListeners();
  }

  // validation check phone

  void checkValidation(String value, String key) {
    switch (key) {
      case "phone":
        if (value.isEmpty) {
          _phone = ValidationItem(value, "Phone is empty");
        } else if (value.length < 9) {
          _phone = ValidationItem(value, "Phone must 9 character ");
        } else {
          _phone = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "password":
        if (value.isEmpty) {
          _password = ValidationItem(value, "Password is empty");
        } else if (value.length < 8) {
          _password = ValidationItem(value, "Password must 8 character");
        } else {
          _password = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "firstName":
        if (value.isEmpty) {
          _firstName = ValidationItem(value, "firstName is empty");
        } else {
          _firstName = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "lastName":
        if (value.isEmpty) {
          _lastName = ValidationItem(value, "lastName is empty");
        } else {
          _lastName = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "email":
        if (value.isEmpty) {
          _email = ValidationItem(value, "email is empty");
        } else if (!RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$')
            .hasMatch(value)) {
          _email = ValidationItem(value, "email invalid ");
        } else {
          _email = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      case "address":
        if (value.isEmpty) {
          _address = ValidationItem(value, "address is empty");
        } else {
          _address = ValidationItem(value, null);
        }
        notifyListeners();
        break;
      default:
    }
  }

  void changeFocus(BuildContext context, String field) {
    var newFocus = _phoneFocus;
    if (_phone.value != null && field.contains("phone")) {
      newFocus = _passwordFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_password.value != null && field.contains('password')) {
      newFocus = _firstNameFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_firstName.value != null && field.contains("firstName")) {
      newFocus = _lastNameFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_lastName.value != null && field.contains("lastName")) {
      newFocus = _emailFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_email.value != null && field.contains("email")) {
      newFocus = _addressFocus;
      FocusScope.of(context).requestFocus(newFocus);
    }
    if (_address.value != null && field.contains("address")) {
      FocusScope.of(context).unfocus();
      submitData(context);
    }
  }

  void submitData(BuildContext context) {
    DateTime _date = DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    submitValid = _phone.error != null ||
        _password.error != null ||
        _firstName.error != null ||
        _lastName.error != null ||
        _address.error != null;
    // check lần đầu
    if (submitValid) {
      checkValidation(_phone.value ?? "", "phone");
      checkValidation(_password.value ?? "", "password");
      checkValidation(_firstName.value ?? "", "firstName");
      checkValidation(_lastName.value ?? "", "lastName");
      checkValidation(_email.value ?? "", "email");
      checkValidation(_address.value ?? "", "address");
    } else {
      final data = SignUpReq(
          firstName: _firstName.value!,
          lastName: _lastName.value!,
          dob: _dobEditController.text.isEmpty
              ? dateFormat.format(_date)
              : _dobEditController.text,
          username: _phone.value!,
          password: _password.value!,
          phoneNumber: "+84" + _phone.value!.substring(1),
          email: _email.value!,
          address: _address.value!,
          avatar: "abc");
      SignUpImpl().postSignUp(UrlApi.signupPath, data).then((value) => {
            showToastSuccess(value.result!),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EnterVerificationCode()),
            )
          });
    }
  }
}
