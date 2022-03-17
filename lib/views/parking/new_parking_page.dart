import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/view_model/providers/new_parking_provider.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:provider/provider.dart';

class NewParkingPage extends StatefulWidget {
  const NewParkingPage({Key? key}) : super(key: key);

  @override
  State<NewParkingPage> createState() => _NewParkingPageState();
}

class _NewParkingPageState extends State<NewParkingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NewParkingProvider provider = Provider.of<NewParkingProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
            ]),
            Title(
                color: AppColor.greyBackground,
                child: Text(
                  "Create your parking",
                  style: AppTextStyles.h2Black,
                )),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
            SizedBox(
              height: size.height * 0.12,
              width: size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Parking name",
                    errorText: provider.clickButtonFlag
                        ? provider.parkingName.error
                        : null),
                autofocus: true,
                onEditingComplete: () {
                  provider.nodeAddress.requestFocus();
                },
                onChanged: (String value) {
                  provider.checkParkingName(value);
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.12,
              width: size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Address",
                    errorText: provider.clickButtonFlag
                        ? provider.address.error
                        : null),
                focusNode: provider.nodeAddress,
                onEditingComplete: () { 
                  provider.getJsonData();
                  provider.nodeHotline.requestFocus();                               
                },
                onChanged: (String value) {
                  provider.checkAddress(value);
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.12,
              width: size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Hotline",
                    errorText: provider.clickButtonFlag
                        ? provider.hotline.error
                        : null),
                keyboardType: TextInputType.phone,
                focusNode: provider.nodeHotline,
                onEditingComplete: () {
                  provider.nodeOpenTime.requestFocus();
                },
                onChanged: (String value) {
                  provider.checkHotline(value);
                },
              ),
            ),
            SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      child: TextField(
                        controller: TextEditingController()
                          ..text = provider.openTime.value,
                        decoration: InputDecoration(
                            labelText: "Open time",
                            errorText: provider.clickButtonFlag
                                ? provider.openTime.error
                                : null),
                        focusNode: provider.nodeOpenTime,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              if (child != null) {
                                return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child);
                              }
                              return const Text("App crash")
                            },
                          );
                          if (pickedTime != null) {
                            String hour = "";
                            String minutes ="";
                            if (pickedTime.hour.toString().length ==1) {
                              hour = "0${pickedTime.hour.toString()}";
                            } else {
                              hour = pickedTime.hour.toString();
                            }
                            if (pickedTime.minute.toString().length ==1) {
                              minutes = "0${pickedTime.minute.toString()}";
                            } else {
                              minutes = pickedTime.minute.toString();
                            }
                            provider.checkOpenTime(hour +
                                ":" +
                                minutes);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      child: TextField(
                        controller: TextEditingController()
                          ..text = provider.closeTime.value,
                        decoration: InputDecoration(
                            labelText: "Close time",
                            errorText: provider.clickButtonFlag
                                ? provider.closeTime.error
                                : null),
                        focusNode: provider.nodeCloseTime,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              if (child != null) {
                                return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child);
                              }
                              return const Text("App crash")
                            },
                          );

                          if (pickedTime != null) {
                            String hour = "";
                            String minutes ="";
                            if (pickedTime.hour.toString().length ==1) {
                              hour = "0${pickedTime.hour.toString()}";
                            } else {
                              hour = pickedTime.hour.toString();
                            }
                            if (pickedTime.minute.toString().length ==1) {
                              minutes = "0${pickedTime.minute.toString()}";
                            } else {
                              minutes = pickedTime.minute.toString();
                            }
                            provider.checkCloseTime(hour +
                                ":" +
                                minutes);
                          }
                        },
                      ),
                    ),
                  ],
                )),
            // Padding(padding: EdgeInsets.only(top: size.height * 0.02)),
            SizedBox(
              child: Text(
                provider.errorOpenTime + "\n" + provider.errorCloseTime,
                style: const TextStyle(color: Colors.red),
              ),
            ),            
            Container(
              height: size.height*0.15,
              margin: EdgeInsets.only(top: size.height*0.02,bottom: size.height*0.02),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.blackText)
              ),
              child: FlutterMap(
                mapController: provider.mapController,
                options: MapOptions(
                onTap: (v, p) async {
                  List<Address> tmp = [];
                  tmp = await Geocoder.local.findAddressesFromCoordinates(
                      Coordinates(p.latitude, p.longitude));
                  setState(() {
                    provider.point = p;
                    provider.location = tmp;
                    Future.delayed(const Duration(milliseconds: 50),(){
                      provider.mapController.move(provider.point, 16.5);
                    });
                    });  
                },
                center: provider.point,
                zoom: 16.5,
              ),
                layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a','b','c']
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: size.height*0.001,
                      height: size.height*0.001,
                      point: provider.point,
                      builder: (ctx) => const SizedBox(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ]
                  )
              ], ),
            ),
            SizedBox(
              child: ButtonDefault(content: "Create Parking",voidCallBack: () => {provider.submit(context)}),
            )
          ],
        ),
      ),
    ));
  }
}
