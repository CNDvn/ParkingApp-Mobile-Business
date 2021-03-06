import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/repository/impl/check_in_impl.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

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
        child: Column(
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
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
                                  if (key.contains(name)) {
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
                    child: Text(
                      "Scan QR Code",
                      style: AppTextStyles.h4black,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: Text(
                      "Align the QR code within the frame to scan.",
                      style: AppTextStyles.h4black,
                    ),
                  ),
                  SizedBox(
                      height: size.height * 0.6,
                      width: size.width * 0.8,
                      child: _buildQrView(context)),
                ]),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              child: ButtonDefault(
                  content: "Reset Camera",
                  voidCallBack: () async {
                    await controller?.resumeCamera();
                    // Navigator.pushReplacementNamed(context, "/BookingDetails");
                  }),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width * 0.5
        : MediaQuery.of(context).size.width * 0.5;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        log(result!.code.toString());
        if (id.isNotEmpty && result!.code!.isNotEmpty) {
          controller.pauseCamera();
          String url =
              '${UrlApi.serverPath}/bookings/checkIn/parking/$id/car/${result!.code.toString()}';
          Future.delayed(const Duration(seconds: 2), () {
            CheckInRepImpl().postCheckin(url);
          });
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
