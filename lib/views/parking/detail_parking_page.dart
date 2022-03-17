import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/view_model/providers/parking_detail_provider.dart';
import 'package:parking_app_mobile_business/views/ListParkingSlot/list_parking_slot.dart';
import 'package:provider/provider.dart';

class DetailParkingPage extends StatefulWidget {
   DetailParkingPage({Key? key,required this.parkingID}) : super(key: key);
  String parkingID;
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
        TextButton(
            style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused))
                return Colors.red;
                if (states.contains(MaterialState.hovered))
                 return Colors.green;
             return null; // Defer to the widget's default.
             }),
          ),
          onPressed: () { 
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListParkingSlot(parkingID: widget.parkingID),));
          },
            child: Text('View List Slot'),
          ),
          TextButton(onPressed: (){
            Navigator.pushReplacementNamed(context, "/ManagerPriceList");
          }, child: Text("View List Prices")),
          TextButton(onPressed: (){
            Navigator.pushReplacementNamed(context, "/History");
          }, child: Text("View History"))
          ],
        ),
      ),
    ));
  }
}
