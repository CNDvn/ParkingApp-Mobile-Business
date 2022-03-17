import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';

class HistoryDetail extends StatelessWidget {
  final String nPlates;
  final String imageUrl;
  final String nameParking;
  final String locationName;
  final String startTime;
  final String checkIn;
  final String checkOut;
  final String totalTime;
  final String amount;
  final String status;
  const HistoryDetail({
    Key? key,
    required this.nPlates,
    required this.imageUrl,
    required this.nameParking,
    required this.locationName,
    required this.startTime,
    required this.checkIn,
    required this.checkOut,
    required this.totalTime,
    required this.amount,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.05),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Text(
              nPlates,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 28, height: 1.6),
            ),
            SizedBox(
              height: size.height * 0.3,
              width: size.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                height: size.height * 0.35,
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Parking Name:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          nameParking,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.blackText,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Parking Location:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          locationName,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.greenToast,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Start Time:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          startTime,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.blackText,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Check In: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                              children: <TextSpan>[
                                TextSpan(
                                  text: checkIn,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.blackText,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Check Out: ",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                              children: <TextSpan>[
                                TextSpan(
                                  text: checkOut,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.blackText,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ],
                    ),
                    Divider(color: AppColor.greyText),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Timing",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              height: 1.6),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.access_alarm,
                              color: AppColor.lightButton,
                              size: 24.0,
                            ),
                            Text(
                              totalTime,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  height: 1.6,
                                  color: AppColor.lightButton),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          "$amount VND",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.redToast,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status:",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.greyText),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.greenToast,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
