import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/view_model/providers/main_providers/enter_password_provider.dart';
import 'package:parking_app_mobile_business/views/sign_in/background_login.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:provider/provider.dart';

class EnterPassword extends StatelessWidget {
  const EnterPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnterPasswordProvider provider =
        Provider.of<EnterPasswordProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: BackGround(
        widgetChild: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text(
                    "Enter your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.greyText,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.9,
                  child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: provider.clickButtonFlag
                              ? provider.password.error
                              : null),
                      autofocus: true,
                      onEditingComplete: () {
                        provider.nodeConfirmPassword.requestFocus();
                      },
                      onChanged: (String value) {
                        provider.checkPassword(value);
                      }),
                ),
                SizedBox(
                  height: size.height * 0.18,
                  width: size.width * 0.9,
                  child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          errorText: provider.clickButtonFlag
                              ? provider.confirmPassword.error
                              : null),
                      focusNode: provider.nodeConfirmPassword,
                      onEditingComplete: () {
                        provider.nodeConfirmPassword.unfocus();
                        provider.submit(context);
                      },
                      onChanged: (String value) {
                        provider.checkConfirmPassword(value);
                      }),
                ),
                SizedBox(
                    width: size.width * 0.9,
                    child: ButtonDefault(
                        content: "Create Account",
                        voidCallBack: () {
                          provider.submit(context);
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
