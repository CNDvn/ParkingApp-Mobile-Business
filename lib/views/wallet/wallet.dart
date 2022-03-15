import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        drawer: const DrawerDefault(),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    0, size.height * 0.05, 0, size.height * 0.05),
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                child: IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                            )),
                            Title(
                                color: AppColor.greyBackground,
                                child: Text(
                                  "My Wallet",
                                  style: AppTextStyles.h2Black,
                                )),
                          ]),
                      SizedBox(
                        height: size.height * 0.05,
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
                        child: SizedBox(
                          height: size.height * 0.08,
                          width: size.width * 0.9,
                          child: Text(
                            "25.600.789 VND",
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
                                      "24/03 ",
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
