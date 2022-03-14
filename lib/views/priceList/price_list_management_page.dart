import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/views/priceList/create_price_list_page.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_page.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';

class PriceListManagementPage extends StatefulWidget {
  const PriceListManagementPage({Key? key}) : super(key: key);

  @override
  State<PriceListManagementPage> createState() =>
      _PriceListManagementPageState();
}

class _PriceListManagementPageState extends State<PriceListManagementPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<ListPriceDetail> list1 = [
      new ListPriceDetail("Car 4 seats", "20.000"),
      new ListPriceDetail("Car 7 seats", "25.000"),
    ];
    final List<ListPriceDetail> list2 = [
      new ListPriceDetail("Car 4 seats", "21.000"),
      new ListPriceDetail("Car 7 seats", "22.000"),
    ];
    return Scaffold(
        drawer: const DrawerDefault(),
        appBar: AppBar(
          title: const Text('Manage price list'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePriceListPage(),
                      ));
                },
                child: Container(
                  child: const Text(
                    "+",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ))
          ],
        ),
        body: ListView(scrollDirection: Axis.horizontal, children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            width: size.width,
            padding: EdgeInsets.all(size.width * 0.05),
            child: PriceListPage(
              listPriceDetail: list1,
              status: 'active',
              namePriceList: "Main Price List",
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            width: size.width,
            padding: EdgeInsets.all(size.width * 0.05),
            child: PriceListPage(
              listPriceDetail: list2,
              status: 'inActive',
              namePriceList: "Price List 8/3",
            ),
          )
        ]));
  }
}
