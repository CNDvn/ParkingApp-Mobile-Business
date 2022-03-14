import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';
import 'package:parking_app_mobile_business/views/parking/detail_parking_page.dart';
import 'package:parking_app_mobile_business/views/parking/new_parking_page.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';
import 'package:parking_app_mobile_business/widgets/card_parking.dart';

class ParkingManagementPage extends StatefulWidget {
  const ParkingManagementPage({Key? key}) : super(key: key);

  @override
  State<ParkingManagementPage> createState() => _ParkingManagementPageState();
}

class _ParkingManagementPageState extends State<ParkingManagementPage> {
  var listParking = [];
  @override
  void initState() {
    ParkingImpl()
        .getParking(UrlApi.getListMyParking)
        .then((value) {
      setState(() {
        listParking = value.result!.data!;
      });
    });
  }

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
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only( top: 28),
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
                    Container(
                      child: Title(
                          color: AppColor.greyBackground,
                          child: Text(
                            "Choose Your Parking",
                            style: AppTextStyles.h2Black,
                          )),
                    ),
                    SizedBox(
                        child: IconButton(
                      icon: const Icon(
                        Icons.create,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NewParkingPage()));
                      },
                    )),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              height: size.height * 0.8,
              child: ListView(
                children: [
                  for (var item in listParking)
                    CardParking(
                        size: size,
                        nameParking: item.name,
                        address: item.address,
                        emptySlot: "12",
                        fullSlot: "123",
                        openTime: item.openTime,
                        closeTime: item.closeTime,
                        voidCallbackFn: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailParkingPage()))
                        })
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
