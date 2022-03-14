import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/views/history/history_detail.dart';
import 'package:parking_app_mobile_business/widgets/card/card_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.05),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/parkingManagement");
                },
              )),
            ]), // Booking Active
            const Text(
              "History Parking",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            CardHistory(
                imageUrl: 'https://i.ibb.co/680hDsW/72dddc373199.jpg',
                nPlates: '99A-641.92',
                brand: 'Vinfast',
                nameParking: 'Landmark 81',
                locationName: 'LM-11',
                voidCallBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryDetail(
                            nPlates: '99A-641.92',
                            imageUrl:
                                'https://i.ibb.co/680hDsW/72dddc373199.jpg',
                            nameParking: 'Landmark 81',
                            locationName: 'LM-11',
                            startTime: '10:28',
                            checkIn: '11:02',
                            checkOut: '15:23',
                            totalTime: '04:35',
                            amount: '125.000',
                            status: 'Paid')),
                  );
                }),
            CardHistory(
                imageUrl: 'https://i.ibb.co/QKY26kC/c53173e1522f.jpg',
                nPlates: '89A-673.84',
                brand: 'Vinfast',
                nameParking: 'Giga Mall Thủ Đức',
                locationName: 'GM-5',
                voidCallBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryDetail(
                            nPlates: '89A-673.84',
                            imageUrl:
                                'https://i.ibb.co/QKY26kC/c53173e1522f.jpg',
                            nameParking: 'Giga Mall Thủ Đức',
                            locationName: 'GM-5',
                            startTime: '11:38',
                            checkIn: '11:50',
                            checkOut: '23:00',
                            totalTime: '11:30',
                            amount: '225.000',
                            status: 'Paid')),
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
