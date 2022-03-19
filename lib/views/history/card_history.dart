import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';

class CardHistory extends StatelessWidget {
  final String imageUrl;
  final String nPlates;
  final String brand;
  final String locationName;
  final String startTime;
  final String checkinTime;
  final String endTime;
  final String amount;
  final String status;
  const CardHistory({
    Key? key,
    required this.imageUrl,
    required this.nPlates,
    required this.brand,
    required this.locationName,
    required this.startTime,
    required this.checkinTime,
    required this.endTime,
    required this.amount,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatDetail = NumberFormat("#,##0,000.000");
    final dateFormat = DateFormat("dd-MM-yyyy - KK:mm:ss");

    String daysBetween(DateTime startDate, DateTime endDate) {
      int seconds = endDate.difference(startDate).inSeconds;
      if (seconds < 60) {
        return '$seconds second';
      } else if (seconds >= 60 && seconds < 3600) {
        return '${endDate.difference(startDate).inMinutes.abs()} minute';
      } else if (seconds >= 3600 && seconds < 86400) {
        return '${endDate.difference(startDate).inHours} hour';
      } else {
        return '${endDate.difference(startDate).inDays} day';
      }
    }

    final date1 = DateTime.parse(startTime);
    final date2 = endTime != null ? DateTime.parse(endTime) : DateTime.now();

    final difference = daysBetween(date1, date2);

    Size size = MediaQuery.of(context).size;
    return Card(
      child: Column(children: [
        ListTile(
          title: Container(
            padding: EdgeInsets.fromLTRB(
                0, size.height * 0.01, 0, size.height * 0.0001),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  imageUrl,
                  width: 200,
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      nPlates,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1.6),
                    ),
                    Text(
                      brand,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.6),
                    )
                  ],
                )
              ],
            ),
          ),
          subtitle: Container(
            padding: EdgeInsets.fromLTRB(
                0, size.height * 0.01, 0, size.height * 0.01),
            child: Column(children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, size.height * 0.01, 0, size.height * 0.02),
                child: const Divider(
                  height: 2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location:",
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
                  ),
                  Text(
                    locationName,
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
                    "Start Time:",
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
                  ),
                  Text(
                    dateFormat.format(DateTime.parse(startTime)),
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
                    "Check In:",
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
                  ),
                  Text(
                    checkinTime != null
                        ? dateFormat.format(DateTime.parse(checkinTime))
                        : "",
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
                    "Check Out:",
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
                  ),
                  Text(
                    endTime != null
                        ? dateFormat.format(DateTime.parse(endTime))
                        : "",
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
                    "Total Timing",
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
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
                        difference,
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
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
                  ),
                  Text(
                    amount != null
                        ? formatDetail.format(double.parse(amount)).toString() +
                            " đ"
                        : "",
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
                    style: TextStyle(fontSize: 16, color: AppColor.greyText),
                  ),
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        color: status == "booked"
                            ? AppColor.redToast
                            : AppColor.greenToast,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
