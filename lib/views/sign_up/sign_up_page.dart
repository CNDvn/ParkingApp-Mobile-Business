import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/view_model/providers/sign_up_provider.dart';
import 'package:parking_app_mobile_business/views/sign_in/background_login.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:parking_app_mobile_business/widget/input_date/input_date.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SignUpProvider signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: BackGround(
        widgetChild: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20.0),
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 40),
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.greyText,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: signUpProvider.textPhone.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearPhoneController(),
                              )
                            : null,
                        labelText: "Phone number",
                        fillColor: Colors.grey,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.phone.error
                            : null),
                    autofocus: false,
                    controller: signUpProvider.phoneController,
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "phone");
                    },
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "phone");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: signUpProvider.textPassword.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearPasswordController(),
                                ),
                                  IconButton(
                                      icon: signUpProvider.isPasswordVariable
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      onPressed: () => signUpProvider
                                          .changePasswordVariable()),
                                ],
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.password.error
                            : null,
                        labelText: "Password",
                        fillColor: Colors.grey),
                    autofocus: false,
                    obscureText: signUpProvider.isPasswordVariable,
                    controller: signUpProvider.passwordController,
                    focusNode: signUpProvider.passwordFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "password");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "password");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: signUpProvider.textFirstName.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearFirstNameController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.firstName.error
                            : null,
                        labelText: "First Name",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.firstNameController,
                    focusNode: signUpProvider.firstNameFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "firstName");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "firstName");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: signUpProvider.textLastName.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearLastNameController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.lastName.error
                            : null,
                        labelText: "Last Name",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.lastNameController,
                    focusNode: signUpProvider.lastNameFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "lastName");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "lastName");
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: signUpProvider.textEmail.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearEmailController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.email.error
                            : null,
                        labelText: "Email",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.emailController,
                    focusNode: signUpProvider.emailFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "email");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "email");
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: InputDate(provider: signUpProvider),
                ),
                SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.9,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: signUpProvider.textAddress.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signUpProvider.clearAddressController(),
                              )
                            : null,
                        errorText: signUpProvider.submitValid
                            ? signUpProvider.address.error
                            : null,
                        labelText: "Address",
                        fillColor: Colors.grey),
                    autofocus: false,
                    controller: signUpProvider.addressController,
                    focusNode: signUpProvider.addressFocus,
                    onEditingComplete: () {
                      signUpProvider.changeFocus(context, "address");
                    },
                    onChanged: (String value) {
                      signUpProvider.checkValidation(value, "address");
                    },
                  ),
                ),
                SizedBox(
                    width: size.width * 0.9,
                    child: ButtonDefault(
                        content: "Submit",
                        voidCallBack: () {
                          signUpProvider.submitData(context);
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
