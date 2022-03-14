import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    0, size.height * 0.05, 0, size.height * 0.05),
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Container()),
                            Expanded(
                              flex: 6,
                              child: Text(
                                "M Y  W A L L E T",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.blueText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                    height: 1.6),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100 / 2),
                              child: Image.asset(
                                AssetPath.profilePhoto,
                                height: 100.0,
                                width: 100.0,
                              ))),
                      Container(
                        margin: const EdgeInsets.all(40),
                        child: Text(
                          "Current Balance: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.blackText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: SizedBox(
                          height: size.height * 0.08,
                          width: size.width * 0.9,
                          child: Text(
                            "999999999999" + " VND",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.blueText,
                                fontSize: 40,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.only(top: size.height * 0.1),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: SizedBox(
                                height: size.height * 0.1,
                                width: size.width * 0.5,
                                child: Column(
                                  children: [
                                    Text(
                                      "Expired Time: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blackText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "24/11 ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blueText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.only(top: size.height * 0.1),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: SizedBox(
                                height: size.height * 0.1,
                                width: size.width * 0.5,
                                child: Column(
                                  children: [
                                    Text(
                                      "Created Time: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blackText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "24/11 ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blueText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]))));
  }
}
