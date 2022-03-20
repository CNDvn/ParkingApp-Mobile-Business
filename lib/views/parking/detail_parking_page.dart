import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/model/entity/image.dart';
import 'package:parking_app_mobile_business/repository/impl/price_list_management_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/parking_detail_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/views/ListParkingSlot/list_parking_slot.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_management_page.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:parking_app_mobile_business/widget/carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
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
      style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    )
  );
  @override
  void initState() {    
    super.initState(); 
    ParkingDetailProvider provider = Provider.of<ParkingDetailProvider>(context,listen: false);
    provider.getInfo(widget.parkingID);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ParkingDetailProvider provider = Provider.of<ParkingDetailProvider>(context);
    bool status() {
      DateTime date = DateTime.now();
      var op = DateTime.now();
      var cl = DateTime.now();
      if (provider.openTimeController.text.isNotEmpty && provider.closeTimeController.text.isNotEmpty){
        op = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(provider.openTimeController.text.split(":")[0]),
        int.parse(provider.openTimeController.text.split(":")[1]),
      );
      cl = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(provider.closeTimeController.text.split(":")[0]),
        int.parse(provider.closeTimeController.text.split(":")[1]),
      );
      }
      if (date.isAfter(op) && date.isBefore(cl)) {
        return true;
      }
      return false;
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: size.height*0.05,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
                child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/parkingManagement", (route) => false);
              },
            )),
          ]),
          Title(
              color: AppColor.greyBackground,
              child: Text(
                "Detail Your Parking",
                style: AppTextStyles.h2Black,
              )),
          SizedBox(
            height: size.height*0.03,
          ),
          SizedBox(
            width: size.width*0.9,
            child: CarouselSliderImage(
              urlImages:
                  provider.images.isNotEmpty ? provider.images : [Images(url: 'https://i.ibb.co/0ZYrz1k/6bf25a7075ec.jpg')],
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
            width: size.width * 0.9,
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Parking name",
                  errorText: provider.clickButtonFlag
                      ? provider.parkingName.error
                      : null),
              controller: provider.parkingNameController,
              focusNode: provider.nodeParkingName,
              onEditingComplete: () {
                provider.changeFocus(context, "nameparking");
              },
              onChanged: (String value) {
                provider.checkParkingName(value);
              },
            ),
          ),            
          SizedBox(
            height: size.height * 0.15,
            width: size.width * 0.9,
            child: Row(children: [
              SizedBox(width: size.width*0.2,child: const Text("Address: ",style: TextStyle(fontSize: 14))),
              SizedBox(
                width: size.width*0.7,
                child: Text(provider.addressTextEditingController.text, 
                maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.blackText,
                                      fontWeight: FontWeight.bold)),
              )])
          ),
          SizedBox(
            height: size.height * 0.1,
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
                provider.changeFocus(context, "hotline");
              },
              onChanged: (String value) {
                provider.checkHotline(value);
              },
            ),
          ),
          SizedBox(
            height: size.height*0.05,
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Status: ",style: TextStyle(fontSize: 14)),
                Text(provider.status,style: 
            provider.status.contains("active") ? const TextStyle(color: Colors.green,fontSize: 15) : const TextStyle(color: Colors.red,fontSize: 15) 
            ,),
            SizedBox(
              width: size.width*0.1,
            ),
            if (provider.status.contains("active"))
              SizedBox(
                width: size.width*0.5,
          child: ButtonDefault(content: "Delete", voidCallBack: (){
            setState(() {
              provider.delete();
            });
          }),
        ),
              ],
            )
          ),
          SizedBox(
            height: size.height*0.05,
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Current Status: ",style: TextStyle(fontSize: 14)),                
                Text(status() ? "Open" : " Close",style: 
            status() ? const TextStyle(color: Colors.green,fontSize: 15) : const TextStyle(color: Colors.red,fontSize: 15) 
            ,),
              ],
            )
          ),
          SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.3,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Open time",
                          errorText: provider.clickButtonFlag
                              ? provider.openTime.error
                              : null),
                      focusNode: provider.nodeOpenTime,
                      onEditingComplete: () {
                        provider.changeFocus(context, "opentime");
                      },
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
                          String h= pickedTime.hour.toString().length == 1 ? "0"+pickedTime.hour.toString() : pickedTime.hour.toString();                              
                          String m = pickedTime.minute.toString().length == 1 ? "0"+pickedTime.minute.toString(): pickedTime.minute.toString();                          
                          provider.closeTimeController.text = h+":"+m;
                          provider.checkOpenTime(pickedTime.hour.toString() +
                              ":" +
                              pickedTime.minute.toString());
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
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
                      onEditingComplete: (){
                        provider.changeFocus(context, "closetime");
                      },
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
                          String h= pickedTime.hour.toString().length == 1 ? "0"+pickedTime.hour.toString() : pickedTime.hour.toString();                              
                          String m = pickedTime.minute.toString().length == 1 ? "0"+pickedTime.minute.toString(): pickedTime.minute.toString();                          
                          provider.closeTimeController.text = h+":"+m;
                          provider.checkCloseTime(pickedTime.hour.toString() +
                              ":" +
                              pickedTime.minute.toString());
                        }
                      },
                    ),
                  ),
                ],
              )),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
            style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused))
                // ignore: curly_braces_in_flow_control_structures
                return Colors.red;
                if (states.contains(MaterialState.hovered))
                 // ignore: curly_braces_in_flow_control_structures
                 return Colors.green;
             return null; // Defer to the widget's default.
             }),
          ),
          onPressed: () { 
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListParkingSlot(parkingID: widget.parkingID),));
          },
            child:const Text('View List Slot'),
          ),
            TextButton(
            style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused))
                // ignore: curly_braces_in_flow_control_structures
                return Colors.red;
                if (states.contains(MaterialState.hovered))
                 // ignore: curly_braces_in_flow_control_structures
                 return Colors.green;
             return null; // Defer to the widget's default.
             }),
          ),
          onPressed: () { 
            PriceListManagementImpl()
            .getAllPriceListByParking(UrlApi.getPriceList, widget.parkingID)
            .then((value){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PriceListManagementPage(priceLists: value.result!,parkingID:widget.parkingID ),
              ));
            });
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ListParkingSlot(parkingID: widget.parkingID),));
          },
            child:const Text('View Price List'),
          ),
          ],
        ),
        SizedBox(
          child: ButtonDefault(content: "Update", voidCallBack: (){
            setState(() {
              provider.update(context);
            });
          }),
        ),
        SizedBox(
            height: size.height*0.05,
          ),
        ],
      ),
    ));
  }
}
