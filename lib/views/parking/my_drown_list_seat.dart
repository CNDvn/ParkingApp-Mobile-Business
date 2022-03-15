import 'package:flutter/material.dart';

class Seat {
  late String seatID;
  late double price;
  Seat(this.seatID, this.price);
}

class MyDrownListSeat extends StatefulWidget {
  const MyDrownListSeat({Key? key}) : super(key: key);
  @override
  State<MyDrownListSeat> createState() => _MyDrownListSeatState();
}

class _MyDrownListSeatState extends State<MyDrownListSeat> {
  List<Seat> seats = [
    Seat("Seat 4", 4000),
    Seat("Seat 7", 5000),
    Seat("Seat 11", 8000)
  ];
  Seat? dropdownValue;

  @override
  void initState() {
    dropdownValue = seats[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 0),
                  ),
                  child: DropdownButton<Seat>(
                    value: dropdownValue,
                    onChanged: (Seat? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
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
                  child: Text(dropdownValue!.price.toString())),
            ]));
  }
}
