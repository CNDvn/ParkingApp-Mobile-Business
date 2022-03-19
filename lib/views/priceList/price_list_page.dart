import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/model/response/price_list_management_res.dart';
import 'package:parking_app_mobile_business/views/priceList/create_price_list_page.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';

class PriceListPage extends StatelessWidget {
  PriceListPage({Key? key, this.item}) : super(key: key);
  final Result? item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(144, 180, 206, 0.5),
                offset: Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 0)
          ],
          border: Border.all(color: Colors.blue),
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
                      item!.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: item!.status == 'active'
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          item!.status!,
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
            height: size.height * 0.37,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (var item in item!.priceListDetails!)
                    Wrap(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(item.typeCar!.name!,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          Text(
                            (item.price).toString().split('.')[0] + "/hour",
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
                content: item!.status == 'active' ? 'Delete' : 'Apply',
                voidCallBack: () {
                  log(item!.status == 'active' ? 'Delete' : 'Apply');
                },
                width: size.width * 0.3,
                height: size.height * 0.07,
              ),
              ButtonDefault(
                content: "Edit",
                voidCallBack: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePriceListPage(
                              isUpdate: true, item: item)));
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
