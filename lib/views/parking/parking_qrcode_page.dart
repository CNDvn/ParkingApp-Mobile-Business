import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeMyParking extends StatefulWidget {
  const QRCodeMyParking({Key? key}) : super(key: key);

  @override
  State<QRCodeMyParking> createState() => _QRCodeMyParkingState();
}

class _QRCodeMyParkingState extends State<QRCodeMyParking> {
  String dropdownvalue = "";
  final List<String> itemss = <String>[
    'Bãi Xe Nguyễn Duy',
    'Bãi Giữ Xe Chí Hưởng',
    'Bãi Giữ Xe Chí Khang',
    'Bãi Giữ Xe Cường Tây',
    'Bãi Giữ Xe Anh Tâm',
  ];
  @override
  void initState() {
    super.initState();
    dropdownvalue = itemss[0];
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
                            value: dropdownvalue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                            items: itemss.map((value) {
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
                      data: dropdownvalue,
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
