import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';

class ListPriceDetail {
  late String typeCar;
  late String amount;
  ListPriceDetail(String typeCar, String amount) {
    this.typeCar = typeCar;
    this.amount = amount;
  }
}

class PriceListPage extends StatelessWidget {
  const PriceListPage(
      {Key? key,
      required this.listPriceDetail,
      required this.status,
      required this.namePriceList})
      : super(key: key);

  final List<ListPriceDetail> listPriceDetail;
  final String status;
  final String namePriceList;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(15),
      height: size.height,
      child: Column(
        children: [
          Title(
              color: AppColor.blueText,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      namePriceList,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: status == 'active' ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          status,
                          style: const TextStyle(color: Colors.white),
                        ))
                  ])),
          SizedBox(
            height: size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Type car", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                "Amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Container(
            height: size.height * 0.4,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (ListPriceDetail item in listPriceDetail)
                    Wrap(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(item.typeCar,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          Text(
                            item.amount + "/hour",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      )
                    ]),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonDefault(
                content: status == 'active' ? 'Delete' : 'Apply',
                voidCallBack: () {
                  log(status == 'active' ? 'Delete' : 'Apply');
                },
                width: size.width * 0.3,
                height: size.height * 0.07,
              ),
              ButtonDefault(
                content: "Edit",
                voidCallBack: () {
                  log("Edit");
                },
                width: size.width * 0.3,
                height: size.height * 0.07,
              )
            ],
          ),
        ],
      ),
    );
  }
}
