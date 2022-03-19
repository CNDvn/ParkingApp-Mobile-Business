import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/repository/impl/history_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';
import 'package:parking_app_mobile_business/views/history/history.dart';

import '../../model/response/history_res.dart';
import '../../view_model/service/service_storage.dart';

class CardParkingHistory extends StatefulWidget {
  const CardParkingHistory({
    Key? key,
    required this.size,
    required this.idParking,
    required this.nameParking,
    required this.address,
    required this.slotEmpty,
    required this.slotFull,
  }) : super(key: key);

  final Size size;
  final String idParking;
  final String nameParking;
  final String address;
  final int slotEmpty;
  final int slotFull;

  @override
  State<CardParkingHistory> createState() => _CardParkingHistoryState();
}

class _CardParkingHistoryState extends State<CardParkingHistory> {
  List<Result>? listHistory = [];
  @override
  void initState() {
    super.initState();
    final SecureStorage secureStorage = SecureStorage();
    secureStorage
        .readSecureData(StorageEnum.accessToken.toShortString())
        .then((token) => {
              HistoryRepImp()
                  .getHistory(
                      UrlApi.historyPath + "/${widget.idParking}", token)
                  .then((value) {
                setState(() {
                  listHistory = value.result;
                });
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return History(
              history: listHistory,
              nameParking: widget.nameParking,
            );
          }),
        );
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.all(4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: widget.size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nameParking,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              height: 2.0,
                              color: AppColor.blueText),
                        ),
                        Text(
                          "Address: " + widget.address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              height: 2.0),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Slot: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  height: 2.0),
                            ),
                            Text(
                              widget.slotEmpty.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  height: 2.0),
                            ),
                            const Text(
                              " Empty",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  height: 2.0),
                            ),
                            Text(
                              " - " + widget.slotFull.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  height: 2.0),
                            ),
                            const Text(
                              " Full",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  height: 2.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
