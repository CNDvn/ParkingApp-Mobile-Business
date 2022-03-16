import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/model/response/parking_slot_res.dart';
import 'package:parking_app_mobile_business/repository/impl/parking_slot_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/detail_slot_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:provider/provider.dart';

class ListParkingSlot extends StatefulWidget {
  ListParkingSlot({Key? key, required this.parkingID}) : super(key: key);
  String parkingID;
  @override
  _ListParkingSlotState createState() => _ListParkingSlotState();
}

class _ListParkingSlotState extends State<ListParkingSlot> {
  late List<ParkingSlot> data = [];
  @override
  void initState() {
    super.initState();
    ParkingSlotImp()
        .getParkingSlots(UrlApi.getParkingSlot +
            widget.parkingID +
            "?sizePage=100&currentPage=1&sort=ASC")
        .then((value) => {
              setState(() {
                data = value.result!.data;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    DetailSlotProvider detailSlotProvider =
        Provider.of<DetailSlotProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "List Parking Slot",
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: GridView.count(
            crossAxisCount: 4,
            children: List<Widget>.generate(data.isNotEmpty ? data.length : 0,
                (index) {
              return Container(
                margin: const EdgeInsets.all(10.0),
                child: GridTile(
                  child: Card(
                      color: data[index].status == "empty"
                          ? Colors.green
                          : Colors.red,
                      child: InkWell(
                        onTap: () async {
                          await detailSlotProvider
                              .getDetailSlot(data[index].id!);
                          if (data[index].status != "empty") {
                            await showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0)),
                                ),
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: 250.0,
                                    color: Colors
                                        .transparent, //could change this to Color(0xFF737373),
                                    //so you don't have to change MaterialApp canvasColor
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight:
                                                    Radius.circular(10.0))),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    detailSlotProvider
                                                        .data
                                                        .result
                                                        .bookings![0]
                                                        .car!
                                                        .images![0]
                                                        .url!,
                                                    width: size.width * 0.5,
                                                    height: size.height * 0.2,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              detailSlotProvider
                                                                  .data
                                                                  .result
                                                                  .bookings![0]
                                                                  .car!
                                                                  .customer!
                                                                  .user!
                                                                  .avatar!)),
                                                  Text(detailSlotProvider
                                                      .data
                                                      .result
                                                      .bookings![0]
                                                      .car!
                                                      .customer!
                                                      .user!
                                                      .fullName!)
                                                ],
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(detailSlotProvider
                                                        .data
                                                        .result
                                                        .bookings![0]
                                                        .car!
                                                        .brand!),
                                                    Text(detailSlotProvider
                                                        .data
                                                        .result
                                                        .bookings![0]
                                                        .car!
                                                        .nPlates!)
                                                  ]),
                                            ],
                                          ),
                                        )),
                                  );
                                });
                          }
                        },
                        child: Center(
                          child: Text(data[index].locationName!),
                        ),
                      )),
                ),
              );
            }),
          ),
        ));
  }
}
