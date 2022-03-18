import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_app_mobile_business/configs/toast/toast.dart';
import 'package:parking_app_mobile_business/model/request/create_price_list_req.dart';
import 'package:parking_app_mobile_business/model/response/price_list_management_res.dart'
    as A;
import 'package:parking_app_mobile_business/repository/impl/create_price_list_rep_impl.dart';
import 'package:parking_app_mobile_business/repository/impl/type_car_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/parking_detail_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/view_model/service/storage_enum.dart';
import 'package:parking_app_mobile_business/views/parking/parking_management_page.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_create.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:provider/provider.dart';

import '../../model/response/list_type_car_res.dart';

class CreatePriceListPage extends StatefulWidget {
  CreatePriceListPage({Key? key, this.parkingID, this.isUpdate, this.item})
      : super(key: key);
  String? parkingID;
  bool? isUpdate;
  final A.Result? item;
  @override
  State<CreatePriceListPage> createState() => _CreatePriceListPageState();
}

class _CreatePriceListPageState extends State<CreatePriceListPage> {
  String dropdownValue = "4 SEATS";
  String nameTablePrice = "";
  List<PriceListCreate> listPriceCreate = [];
  int lengthItem = 0;
  List<Result> listTypeCar = [];
  TextEditingController priceListNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // if (widget.isUpdate!) {
    //   final SecureStorage secureStorage = SecureStorage();
    //   secureStorage
    //       .readSecureData(StorageEnum.accessToken.toShortString())
    //       .then((value) => {
    //             PriceListRepImpl().putPriceList(
    //                 UrlApi.postPriceList + "/" + widget.priceListID!,
    //                 value,
    //                 data)
    //           });
    // } else {

    // }
    if (widget.isUpdate!) {
      List<PriceListCreate> priceListCreateUpdate = [];
      for (var item in widget.item!.priceListDetails!) {
        TextEditingController controller = TextEditingController();
        controller.value = TextEditingValue(text: item.price!.split(".")[0]);
        priceListCreateUpdate.add(PriceListCreate(
            idTypeCar: item.typeCar!.id,
            nameTypeCar: item.typeCar!.name,
            amount: item.price!.split(".")[0],
            controller: controller));
      }
      priceListNameController.value =
          TextEditingValue(text: widget.item!.nameParking!);
      TypeCarImpl().getAllTypeCars(UrlApi.getAllTypeCar).then((value) => {
            setState(() {
              listTypeCar = value.result!;
              dropdownValue = widget.item!.priceListDetails![0].typeCar!.name!;
              listPriceCreate = priceListCreateUpdate;
            })
          });
    } else {
      TypeCarImpl().getAllTypeCars(UrlApi.getAllTypeCar).then((value) => {
            setState(() {
              listTypeCar = value.result!;
              dropdownValue = value.result![0].name!;
              listPriceCreate.add(PriceListCreate(
                  idTypeCar: value.result![0].id!,
                  nameTypeCar: value.result![0].name!,
                  amount: "0"));
            })
          });
    }
  }

  void handleSubmit() {
    final SecureStorage secureStorage = SecureStorage();
    List<PriceListDetail> listPriceDetail = [];
    for (var item in listPriceCreate) {
      listPriceDetail.add(PriceListDetail(
          price: double.parse(item.amount!.replaceAll("VND", "").trim()),
          typeCarId: item.idTypeCar!));
    }
    PriceListReq data =
        PriceListReq(name: nameTablePrice, priceListDetails: listPriceDetail);
    if (widget.isUpdate!) {
      secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString())
          .then((accessToken) => {
                PriceListRepImpl()
                    .putPriceList(UrlApi.postPriceList + "/" + widget.item!.id!,
                        accessToken, data)
                    .then((data) => {
                          showToastSuccess(data.result!),
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ParkingManagementPage();
                          }))
                        })
              });
    } else {
      secureStorage
          .readSecureData(StorageEnum.accessToken.toShortString())
          .then((accessToken) => {
                PriceListRepImpl()
                    .postPriceList(
                        UrlApi.postPriceList + "/" + widget.parkingID!,
                        accessToken,
                        data)
                    .then((data) => {
                          showToastSuccess(data.result!),
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ParkingManagementPage();
                          }))
                        })
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ParkingDetailProvider provider =
        Provider.of<ParkingDetailProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.05),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
            Text(
              widget.isUpdate! ? "Update Price List" : "Create Price List",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 28, height: 1.6),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: TextField(
                    controller: priceListNameController,
                    onChanged: (String value) {
                      log(value);
                      setState(() {
                        nameTablePrice = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Price List Name",
                    ))),
            Column(
              children: [
                if (listTypeCar.isNotEmpty)
                  for (var i = 0; i < listPriceCreate.length; i++)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // if (listTypeCar.isNotEmpty)
                          //   for (var i = 0; i < listPriceCreate.length; i++)
                          DropdownButton<String>(
                            value: listPriceCreate[i].nameTypeCar,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              final index = listTypeCar.indexWhere(
                                  (element) => element.name == newValue!);
                              final itemClone = PriceListCreate().copyWith(
                                  idTypeCar: listTypeCar[index].id,
                                  nameTypeCar: listTypeCar[index].name,
                                  amount: listPriceCreate[i].amount);
                              final indexDuplicate = listPriceCreate.indexWhere(
                                  (element) =>
                                      element.idTypeCar == itemClone.idTypeCar);
                              if (indexDuplicate != -1) {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text("Error"),
                                          content: const Text(
                                              'Sorry Duplicate TypeCar'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ));
                              } else {
                                setState(() {
                                  // dropdownValue = newValue!;
                                  listPriceCreate[i] = itemClone;
                                });
                              }
                            },
                            items: listTypeCar
                                .map<DropdownMenuItem<String>>((Result value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(value.name!),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                              height: size.height * 0.09,
                              width: size.width * 0.5,
                              child: TextField(
                                  controller: listPriceCreate[i].controller,
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    log(value);
                                    final itemClone = PriceListCreate()
                                        .copyWith(
                                            idTypeCar:
                                                listPriceCreate[i].idTypeCar,
                                            nameTypeCar:
                                                listPriceCreate[i].nameTypeCar,
                                            amount: value);
                                    setState(() {
                                      // dropdownValue = newValue!;
                                      listPriceCreate[i] = itemClone;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Amount",
                                  )))
                        ]),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: ButtonDefault(
                          content: '+',
                          width: size.width * 0.15,
                          voidCallBack: () {
                            if (listTypeCar.length <= listPriceCreate.length) {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text("Error"),
                                        content: Text('Sorry You Only Create ' +
                                            listTypeCar.length.toString() +
                                            " Price"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ));
                            } else {
                              setState(() {
                                listPriceCreate.add(PriceListCreate(
                                    idTypeCar: listTypeCar[0].id,
                                    nameTypeCar: listTypeCar[0].name,
                                    amount: "0"));
                              });
                            }
                          },
                        ),
                      ),
                      ButtonDefault(
                        content: '-',
                        width: size.width * 0.15,
                        voidCallBack: () {
                          if (listPriceCreate.length <= 1) {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          'Sorry You must create default price '),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                          } else {
                            setState(() {
                              listPriceCreate.removeLast();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    if (listPriceCreate.isNotEmpty) {
                      for (var i = 0; i < listPriceCreate.length - 1; i++) {
                        for (var j = i + 1;
                            j <= listPriceCreate.length - 1;
                            j++) {
                          if (listPriceCreate[i].idTypeCar ==
                                  listPriceCreate[j].idTypeCar &&
                              listPriceCreate.length > 1) {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Error"),
                                      content:
                                          const Text('Sorry Duplicate TypeCar'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                            return;
                          }
                        }
                      }
                      log("save");
                      for (var i = 0; i < listPriceCreate.length; i++) {
                        if (listPriceCreate[i].amount == 0) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Error"),
                                    content:
                                        const Text('Sorry Amount No Empty'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                          return;
                        }
                      }
                      if (nameTablePrice.isEmpty) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Error"),
                                  content:
                                      const Text('Sorry Name Table No Empty'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                        return;
                      }
                      handleSubmit();
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
