import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/views/promotion/card_promotion.dart';

class Promotion extends StatelessWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/parkingManagement");
                  },
                )),
              ]),
            ),
            SizedBox(
              child: Title(
                  color: AppColor.greyBackground,
                  child: Text(
                    "Promotion List",
                    style: AppTextStyles.h2Black,
                  )),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              height: size.height * 0.8,
              child: ListView(
                children: [
                  CardPromotion(
                    size: size,
                    description: "Áp dụng cho thành viên mới",
                    code: "ATVD668",
                    percent: 10,
                  ),
                  SizedBox(height: size.height * 0.03),
                  CardPromotion(
                    size: size,
                    description: "Áp dụng cho thành viên có sinh nhật tháng 3",
                    code: "BB10XH",
                    percent: 20,
                  ),
                  SizedBox(height: size.height * 0.03),
                  CardPromotion(
                    size: size,
                    description: "Áp dụng cho SV FPT",
                    code: "BAOPROVIP",
                    percent: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
