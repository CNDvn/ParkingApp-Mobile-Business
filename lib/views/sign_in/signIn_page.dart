import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/view_model/providers/sign_in_provider.dart';
import 'package:parking_app_mobile_business/views/sign_in/background_login.dart';
import 'package:parking_app_mobile_business/views/sign_up/sign_up_page.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:parking_app_mobile_business/widget/button/button_social.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SignInProvider signInProvider = Provider.of<SignInProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGround(
        widgetChild: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.9,
                ),
                SizedBox(
                  height: size.height * 0.12,
                  width: size.width * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: signInProvider.textPhone.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    signInProvider.clearPhoneController(),
                              )
                            : null,
                        labelText: "Phone number",
                        errorText: signInProvider.submitValid
                            ? signInProvider.phone.error
                            : null),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    controller: signInProvider.phoneController,
                    onChanged: (String value) {
                      signInProvider.checkPhone(value);
                    },
                    focusNode: signInProvider.phoneFocus,
                    onEditingComplete: () {
                      signInProvider.changeFocus(context, 'phone');
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.12,
                  width: size.width * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: signInProvider.textPassword.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => signInProvider
                                        .clearPasswordController(),
                                  ),
                                  IconButton(
                                      icon: signInProvider.isPasswordVariable
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      onPressed: () => signInProvider
                                          .changePasswordVariable()),
                                ],
                              )
                            : null,
                        labelText: "Password",
                        errorText: signInProvider.submitValid
                            ? signInProvider.password.error
                            : null),
                    obscureText: signInProvider.isPasswordVariable,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    controller: signInProvider.passwordController,
                    onChanged: (String value) {
                      signInProvider.checkPassword(value);
                    },
                    focusNode: signInProvider.passwordFocus,
                    onEditingComplete: () {
                      signInProvider.changeFocus(context, 'password');
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[Text("Forgot Password?")],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.9,
                  child: ButtonDefault(
                    content: "Login",
                    voidCallBack: () {
                      signInProvider.submitData(context);
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                  width: size.width * 0.9,
                ),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.9,
                  child: ButtonSocial(
                      content: "Login With Google",
                      voidCallBack: () =>
                          signInProvider.signInWithGoogle(context),
                      assetName: AssetPath.logoGoogle),
                ),
                SizedBox(
                  height: size.height * 0.12,
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Or '),
                      GestureDetector(
                          child: Text(
                            "Signup",
                            style: AppTextStyles.h4black,
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const SignUpPage();
                            }));
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
