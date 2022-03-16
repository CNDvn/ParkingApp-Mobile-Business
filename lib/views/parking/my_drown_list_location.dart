import 'package:flutter/material.dart';

class Location {
  late String locationID;
  late String status;
  Location(this.locationID, this.status);
}

class MyDrownListLocation extends StatefulWidget {
  const MyDrownListLocation({Key? key}) : super(key: key);
  @override
  State<MyDrownListLocation> createState() => _MyDrownListLocationState();
}

class _MyDrownListLocationState extends State<MyDrownListLocation> {
  List<Location> locations = [
    Location("LM-1", "empty"),
    Location("LM-2", "full"),
    Location("LM-3", "empty")
  ];
  Location? dropdownValue;

  @override
  void initState() {
    dropdownValue = locations[0];
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
                  child: DropdownButton<Location>(
                    value: dropdownValue,
                    onChanged: (Location? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
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
                  child: Text(dropdownValue!.status.toString())),
            ]));
  }
}
