import 'package:flutter/material.dart';
import 'package:parkingapp_mobile_business/configs/themes/app_color.dart';
import 'package:parkingapp_mobile_business/views/sign_in/background_login.dart';
import 'package:parkingapp_mobile_business/views/sign_up/enter_verification_code.dart';
import 'package:parkingapp_mobile_business/widget/button/button.dart';

class EnterPhoneNumber extends StatelessWidget {
  const EnterPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.whiteBackground,
      body: BackGround(
        widgetChild: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 40),
                  child: Text(
                    "Enter your phone number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.greyText,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.16,
                  width: size.width * 0.9,
                  child: const TextField(
                    decoration: InputDecoration(
                        labelText: "Phone number", fillColor: Colors.grey),
                    autofocus: false,
                  ),
                ),
                SizedBox(
                    width: size.width * 0.9,
                    child: ButtonDefault(
                        content: "Next",
                        voidCallBack: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EnterVerificationCode()),
                          );
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
