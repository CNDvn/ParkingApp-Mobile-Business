
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/view_model/providers/parking_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailParkingPage extends StatefulWidget {
  const DetailParkingPage({Key? key}) : super(key: key);

  @override
  State<DetailParkingPage> createState() => _DetailParkingPageState();
}

class _DetailParkingPageState extends State<DetailParkingPage> {
  final items = ['Seat 4','Seat 7','Seat 9'];
  String? value;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    )
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ParkingDetailProvider provider = Provider.of<ParkingDetailProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Title(
                color: AppColor.greyBackground,
                child: Text(
                  "Detail your parking",
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
                autofocus: false,
                controller: provider.parkingNameController,
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
                controller: provider.addressController,
                onEditingComplete: () {
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
                controller: provider.hotlineController,
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
                        decoration: InputDecoration(
                            labelText: "Open time",
                            errorText: provider.clickButtonFlag
                                ? provider.openTime.error
                                : null),
                        focusNode: provider.nodeOpenTime,
                        controller: provider.openTimeController,
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
                            provider.checkOpenTime(pickedTime.hour.toString() +
                                ":" +
                                pickedTime.minute.toString());
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Close time",
                            errorText: provider.clickButtonFlag
                                ? provider.closeTime.error
                                : null),
                        focusNode: provider.nodeCloseTime,
                        readOnly: true,
                        controller: provider.closeTimeController,
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
                            provider.checkCloseTime(pickedTime.hour.toString() +
                                ":" +
                                pickedTime.minute.toString());
                          }
                        },
                      ),
                    ),
                  ],
                )),

const MyDrownListSeat(),
const MyDrownListLocation(),
            // Padding(padding: EdgeInsets.only(top: size.height * 0.09)),
            // SizedBox(
            //   child: Text(
            //     provider.errorOpenTime + "\n" + provider.errorCloseTime,
            //     style: const TextStyle(color: Colors.red),
            //   ),
            // ),
            
            // Padding(padding: EdgeInsets.only(top: size.height * 0.1)),
            // SizedBox(
            //     height: size.height * 0.06,
            //     width: size.width * 0.5,
            //     child: ElevatedButton(
            //       child: const Text("Update Parking"),
            //       onPressed: () => {provider.submit()},
            //     ))
          ],
        ),
      ),
    ));
  }
}
class MyDrownListSeat extends StatefulWidget {
  const MyDrownListSeat({Key? key}) : super(key: key);
  @override
  State<MyDrownListSeat> createState() => _MyDrownListSeatState();
}

class MyDrownListLocation extends StatefulWidget {
  const MyDrownListLocation({Key? key}) : super(key: key);
  @override
  State<MyDrownListLocation> createState() => _MyDrownListLocationState();
}


class _MyDrownListSeatState extends State<MyDrownListSeat> {
  List<Seat> seats = [Seat("Seat 4", 4000), Seat("Seat 7", 5000), Seat("Seat 11", 8000)];
    Seat? dropdownValue;
    
    @override
      void initState() {
         dropdownValue = seats[0];
      }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
              child: Container(
                width: 150,
                // margin: EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 0),
                ),
                child: DropdownButton<Seat>(
                    value: dropdownValue,
                    onChanged: (Seat? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        log(newValue.seatID);
                      });
                    },
                    items: seats.map((Seat seat) {
                      return DropdownMenuItem<Seat>(
                        value: seat,
                        child: Text(seat.seatID),
                      );
                    }).toList(),
              ),
              ),
            ),
            Container(
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      child: Text(dropdownValue!.price.toString())         
                      ),
            ]));
   
  }
}

class _MyDrownListLocationState extends State<MyDrownListLocation> {
  List<Location> locations = [Location("LM-1", "empty"), Location("LM-2", "full"), Location("LM-3", "empty")];
    Location? dropdownValue;
    
    @override
      void initState() {
         dropdownValue = locations[0];
      }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
              child: Container(
                width: 150,
                // margin: EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 0),
                ),
                child: DropdownButton<Location>(
                    value: dropdownValue,
                    onChanged: (Location? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        log(newValue.locationID);
                      });
                    },
                    items: locations.map((Location location) {
                      return DropdownMenuItem<Location>(
                        value: location,
                        child: Text(location.locationID),
                      );
                    }).toList(),
              ),
              ),
            ),
            Container(
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      height: size.height * 0.12,
                      width: size.width * 0.3,
                      child: Text(dropdownValue!.status.toString())         
                      ),
            ]));
   
  }
}

class Seat {
  late String seatID;
  late double price;
  Seat(this.seatID, this.price);
}

class Location {
  late String locationID;
  late String status;
  Location(this.locationID, this.status);
}
