import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_management_page.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';

class CreatePriceListPage extends StatefulWidget {
  const CreatePriceListPage({Key? key}) : super(key: key);

  @override
  State<CreatePriceListPage> createState() => _CreatePriceListPageState();
}

class _CreatePriceListPageState extends State<CreatePriceListPage> {
  String dropdownValue = 'Type Car';
  List<List<String>> chooseItems = [[]];
  int lengthItem = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> items = <String>[
      'Type Car',
      'Car 4 seats',
      'Car 7 seats',
      'Car 9 seats',
      'Car 16 seats'
    ];
    return Scaffold(
        drawer: const DrawerDefault(),
        appBar: AppBar(
          title: const Text('Create Price List'),
        ),
        body: Column(
          children: [
            for (int i = 0; i < chooseItems.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                    child: DropdownButton<String>(
                      value:
                          chooseItems[i].isEmpty ? items[0] : chooseItems[i][0],
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 1,
                        color: const Color.fromARGB(255, 68, 68, 68),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          bool exist = false;
                          chooseItems.forEach((element) {
                            if (element.contains(newValue!)) {
                              exist = true;
                              return;
                            }
                          });
                          if (items[0] == newValue) {
                          } else if (exist) {
                            showToastFail(
                                "This type car exist in this price list");
                          } else if (chooseItems[i].isEmpty) {
                            chooseItems[i].add(newValue!);
                          } else {
                            chooseItems[i][0] = (newValue!);
                          }
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                    width: size.width * 0.5,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: (chooseItems[i].length != 2 || chooseItems[i][1].isEmpty) ? 'Amount':''),
                      onChanged: (newValue) {
                        setState(() {
                          if (chooseItems[i][0].isNotEmpty) {
                            if (chooseItems[i].length == 1) {
                              chooseItems[i].add(newValue);
                            } else {
                              chooseItems[i][1] = newValue;
                            }
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            SizedBox(
              height: size.height * 0.05,
            ),
            if (chooseItems.length != items.length - 1)
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  width: 30,
                ),
                ButtonDefault(
                  content: '+',
                  width: size.width * 0.15,
                  voidCallBack: () {
                    setState(() {
                      chooseItems.add([]);
                    });
                  },
                ),
              ]),
            SizedBox(
              height: size.height * 0.05,
            ),
            ButtonDefault(
              content: 'Add',
              voidCallBack: () {
                log("Add price list");
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PriceListManagementPage()));
              },
            ),
          ],
        ));
  }
}
