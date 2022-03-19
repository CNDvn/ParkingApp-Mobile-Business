import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/views/history/card_parking_history.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';

class ListParkingHistory extends StatefulWidget {
  const ListParkingHistory({Key? key}) : super(key: key);

  @override
  State<ListParkingHistory> createState() => _ListParkingHistoryState();
}

class _ListParkingHistoryState extends State<ListParkingHistory> {
  var listParking = [];
  @override
  // ignore: must_call_super
  void initState() {
    ParkingImpl().getParking(UrlApi.getListMyParking).then((value) {
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
              padding: const EdgeInsets.only(top: 28),
              child: Row(children: [
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
                SizedBox(
                  child: Title(
                      color: AppColor.greyBackground,
                      child: Text(
                        "Parking History",
                        style: AppTextStyles.h2Black,
                      )),
                ),
              ]),
            ),
            const Text(
              "Select the parking lot you want to see the history",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              height: size.height * 0.75,
              child: ListView(
                children: [
                  for (var item in listParking)
                    CardParkingHistory(
                      size: size,
                      idParking: item.id,
                      nameParking: item.name,
                      address: item.address,
                      slotEmpty: item.slotEmpty,
                      slotFull: item.slotFull,
                    )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
