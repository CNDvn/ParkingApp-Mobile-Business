import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/model/response/price_list_management_res.dart';
import 'package:parking_app_mobile_business/views/priceList/create_price_list_page.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_page.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';

class PriceListManagementPage extends StatelessWidget {
  PriceListManagementPage({Key? key, required this.priceLists})
      : super(key: key);

  final List<Result> priceLists;
  
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
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
                    for(var item in priceLists)
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.05),
                        width: size.width,
                        padding: EdgeInsets.all(size.width * 0.05),
                        child: PriceListPage(
                          listPriceDetail: item.priceListDetails!,
                          status: item.status!,
                          namePriceList: item.name!,
                        ),
                      ),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
