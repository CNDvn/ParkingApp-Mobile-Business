import 'package:flutter/material.dart';

class CardHistory extends StatelessWidget {
  final String imageUrl;
  final String nPlates;
  final String brand;
  final String nameParking;
  final String locationName;
  final VoidCallback voidCallBack;
  const CardHistory(
      {Key? key,
      required this.imageUrl,
      required this.nPlates,
      required this.brand,
      required this.nameParking,
      required this.locationName,
      required this.voidCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Column(children: [
        ListTile(
          title: Container(
            padding: EdgeInsets.fromLTRB(
                0, size.height * 0.01, 0, size.height * 0.0001),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  imageUrl,
                  width: 200,
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      nPlates,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1.6),
                    ),
                    Text(
                      brand,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.6),
                    )
                  ],
                )
              ],
            ),
          ),
          subtitle: Container(
            padding: EdgeInsets.fromLTRB(
                0, size.height * 0.01, 0, size.height * 0.01),
            child: Column(children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0, size.height * 0.01, 0, size.height * 0.02),
                child: const Divider(
                  height: 2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameParking,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            height: 1.6),
                      ),
                      Text(
                        locationName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.6),
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: voidCallBack,
                      child: const Text(
                        "Detail",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14.0),
                      ))
                ],
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
