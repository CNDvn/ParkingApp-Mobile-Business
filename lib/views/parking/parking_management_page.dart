import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_rep_impl.dart';
import 'package:parking_app_mobile_business/widgets/card_parking.dart';

class ParkingManagementPage extends StatefulWidget {
  const ParkingManagementPage({Key? key}) : super(key: key);

  @override
  State<ParkingManagementPage> createState() => _ParkingManagementPageState();
}

class _ParkingManagementPageState extends State<ParkingManagementPage> {
  var testApi = [];
  @override
  void initState() {
    ParkingImpl()
        .getParking(
            "https://parking-app-project.herokuapp.com/api/v1/parkings?sizePage=5&currentPage=1&sort=ASC")
        .then((value) {
      setState(() {
        testApi = value.result!.data;
      });
    });
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Title(
                  color: AppColor.greyBackground,
                  child: Text(
                    "Choose Your Parking",
                    style: AppTextStyles.h2Black,
                  )),
            ),
            Container(
              key: ValueKey<bool>(testApi == null),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              height: size.height * 0.8,
              child: ListView(
                
                children: [
                  for (var item in testApi)
                    CardParking(
                        size: size,
                        nameParking: item.name,
                        address: item.address,
                        emptySlot: "12",
                        fullSlot: "123",
                        openTime: item.openTime,
                        closeTime: item.closeTime,
                        voidCallbackFn: () => {log(item.name)})
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
