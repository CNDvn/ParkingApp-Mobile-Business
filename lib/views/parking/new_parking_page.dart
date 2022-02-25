import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/providers/new_parking_provider.dart';
import 'package:provider/provider.dart';

class NewParkingPage extends StatelessWidget {
  const NewParkingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NewParkingProvider provider = Provider.of<NewParkingProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Title(
                color: AppColor.greyBackground,
                child: Text(
                  "Create your parking",
                  style: AppTextStyles.h2Black,
                )),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
            SizedBox(
              height: size.height * 0.12,
              width: size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Parking name",
                    errorText: provider.clickButtonFlag
                        ? provider.parkingName.error
                        : null),
                autofocus: true,
                onEditingComplete: () {
                  provider.nodeAddress.requestFocus();
                },
                onChanged: (String value) {
                  provider.checkParkingName(value);
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.12,
              width: size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Address",
                    errorText: provider.clickButtonFlag
                        ? provider.address.error
                        : null),
                focusNode: provider.nodeAddress,
                onEditingComplete: () {
                  provider.nodeHotline.requestFocus();
                },
                onChanged: (String value) {
                  provider.checkAddress(value);
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.12,
              width: size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Hotline",
                    errorText: provider.clickButtonFlag
                        ? provider.hotline.error
                        : null),
                keyboardType: TextInputType.phone,
                focusNode: provider.nodeHotline,
                onEditingComplete: () {
                  provider.nodeOpenTime.requestFocus();
                },
                onChanged: (String value) {
                  provider.checkHotline(value);
                },
              ),
            ),
            SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      child: TextField(
                        controller: TextEditingController()
                          ..text = provider.openTime.value,
                        decoration: InputDecoration(
                            labelText: "Open time",
                            errorText: provider.clickButtonFlag
                                ? provider.openTime.error
                                : null),
                        focusNode: provider.nodeOpenTime,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              if (child != null) {
                                return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child);
                              }
                              return const Text("App crash")
                            },
                          );
                          if (pickedTime != null) {
                            provider.checkOpenTime(pickedTime.hour.toString() +
                                ":" +
                                pickedTime.minute.toString());
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      child: TextField(
                        controller: TextEditingController()
                          ..text = provider.closeTime.value,
                        decoration: InputDecoration(
                            labelText: "Close time",
                            errorText: provider.clickButtonFlag
                                ? provider.closeTime.error
                                : null),
                        focusNode: provider.nodeCloseTime,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              if (child != null) {
                                return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child);
                              }
                              return const Text("App crash")
                            },
                          );

                          if (pickedTime != null) {
                            provider.checkCloseTime(pickedTime.hour.toString() +
                                ":" +
                                pickedTime.minute.toString());
                          }
                        },
                      ),
                    ),
                  ],
                )),
            Padding(padding: EdgeInsets.only(top: size.height * 0.02)),
            SizedBox(
              child: Text(
                provider.errorOpenTime + "\n" + provider.errorCloseTime,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: size.height * 0.1)),
            SizedBox(
                height: size.height * 0.08,
                width: size.width * 0.5,
                child: ElevatedButton(
                  child: const Text("Create Parking"),
                  onPressed: () => {provider.submit()},
                ))
          ],
        ),
      ),
    ));
  }
}
