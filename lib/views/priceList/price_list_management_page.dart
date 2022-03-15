import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/views/priceList/create_price_list_page.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_page.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';

class PriceListManagementPage extends StatefulWidget {
  const PriceListManagementPage({Key? key}) : super(key: key);

  @override
  State<PriceListManagementPage> createState() =>
      _PriceListManagementPageState();
}

class _PriceListManagementPageState extends State<PriceListManagementPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<ListPriceDetail> list1 = [
      ListPriceDetail("Car 4 seats", "20.000"),
      ListPriceDetail("Car 7 seats", "25.000"),
    ];
    final List<ListPriceDetail> list2 = [
      ListPriceDetail("Car 4 seats", "21.000"),
      ListPriceDetail("Car 7 seats", "22.000"),
    ];
    return Scaffold(
        key: scaffoldKey,
        drawer: const DrawerDefault(),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 28, right: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            child: IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                        )),
                        Title(
                            color: AppColor.greyBackground,
                            child: Text(
                              "Manage Price List",
                              style: AppTextStyles.h2Black,
                            )),
                        SizedBox(
                            child: IconButton(
                          icon: const Icon(
                            Icons.create,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatePriceListPage()));
                          },
                        )),
                      ]),
                ),
                SizedBox(
                  height: size.height * 0.85,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
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
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
