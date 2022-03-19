import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/views/history/card_history.dart';

import '../../model/response/history_res.dart';

class History extends StatefulWidget {
  List<Result>? history = [];
  String? nameParking;
  History({Key? key, this.history, this.nameParking}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.05),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
            ]),
            Title(
                color: AppColor.greyBackground,
                child: Text(
                  widget.nameParking!,
                  style: AppTextStyles.h2Black,
                )),
            SizedBox(
              height: size.height * 0.005,
            ),
            widget.history?.length == 0
                ? Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      Text(
                        "No Transaction History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            height: 1.6,
                            color: AppColor.redToast),
                      ),
                    ],
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    height: size.height * 0.7,
                    child: ListView(
                      children: [
                        for (var item in widget.history!.reversed)
                          CardHistory(
                            imageUrl: item.car.images[0].url,
                            nPlates: item.car.nPlates,
                            brand: item.car.brand,
                            locationName: item.parkingSlot.locationName,
                            startTime: item.startTime,
                            checkinTime: item.checkinTime,
                            endTime: item.payment.endTime,
                            amount: item.payment.amount,
                            status: item.status,
                          ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    ));
  }
}
