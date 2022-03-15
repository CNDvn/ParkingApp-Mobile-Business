import 'package:flutter/material.dart';

class CardParking extends StatelessWidget {
  const CardParking(
      {Key? key,
      required this.size,
      required this.nameParking,
      required this.address,
      required this.emptySlot,
      required this.fullSlot,
      required this.openTime,
      required this.closeTime,
      required this.voidCallbackFn})
      : super(key: key);

  final Size size;
  final String nameParking;
  final String address;
  final String emptySlot;
  final String fullSlot;
  final String openTime;
  final String closeTime;
  final VoidCallback voidCallbackFn;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameParking,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            height: 2.0),
                      ),
                      Text(
                        address,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            height: 2.0),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: voidCallbackFn,
                    child: const Text(
                      "Detail",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14.0),
                    ))
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      const Text(
                        "Slot:",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            height: 2.0),
                      ),
                      Text(
                        emptySlot,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            height: 2.0),
                      ),
                      const Text(
                        " Empty",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            height: 2.0),
                      ),
                      Text(
                        " - " + fullSlot,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            height: 2.0),
                      ),
                      const Text(
                        " Full",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            height: 2.0),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Open time: " + openTime,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          height: 2.0),
                    ),
                    Text(
                      "Close time: " + closeTime,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          height: 2.0),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
