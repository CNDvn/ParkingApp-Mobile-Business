import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeMyPage extends StatefulWidget {
  const QRCodeMyPage({Key? key}) : super(key: key);

  @override
  State<QRCodeMyPage> createState() => _QRCodeMyPageState();
}

class _QRCodeMyPageState extends State<QRCodeMyPage> {
  // ignore: prefer_collection_literals
  Map<String, String> listParking = Map<String, String>();
  String name = "";
  String id = "";
  @override
  void initState() {
    super.initState();
    ParkingImpl().getParking(UrlApi.getListMyParking).then((value) {
      setState(() {
        for (var i = 0; i < value.result!.data!.length; i++) {
          // ignore: prefer_collection_literals
          Map<String, String> tmp = Map<String, String>();
          tmp[value.result!.data![i].name!] = value.result!.data![i].id!;
          listParking.addAll(tmp);
        }
        name = listParking.keys.first;
        id = listParking.values.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          margin: EdgeInsets.fromLTRB(
              0, size.height * 0.005, 0, size.height * 0.005),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                        child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, "/parkingManagement");
                      },
                    )),
                  ]),
                  SizedBox(
                    height: size.height * 0.2,
                    width: size.width * 0.9,
                    child: Image.asset(AssetPath.logoPath),
                  ),
                  Row(
                    children: [
                      Expanded(flex: 2, child: Container()),
                      const Expanded(
                        flex: 6,
                        child: Text(
                          "QR Code - Your Parking",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              height: 1.6),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const SizedBox(
                      child: Text("Your Parking: "),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    SizedBox(
                        height: size.height * 0.09,
                        child: DropdownButton(
                            value: name,
                            onChanged: (String? newValue) {
                              setState(() {
                                name = newValue!;
                                listParking.forEach((key, value) {
                                  if (name.contains(key)) {
                                    id = value;
                                  }
                                });
                              });
                            },
                            items: listParking.keys.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList())),
                  ]),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    child: QrImage(
                      data: id,
                      version: QrVersions.auto,
                      size: size.height * 0.4,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const SizedBox(
                    child: Text(
                        "Please use this QR-Code to check-in at the Parking Counter",
                        textAlign: TextAlign.center),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
