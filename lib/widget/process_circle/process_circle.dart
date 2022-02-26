import 'package:flutter/material.dart';
import 'package:parkingapp_mobile_business/configs/themes/app_color.dart';
import 'package:parkingapp_mobile_business/constants/assets_path.dart';

class ProcessCircle extends StatelessWidget {
  const ProcessCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.whiteBackground,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    // child: Lottie.asset(AssetPath.processWaiting),
                    ),
              ]),
        ),
      ),
    );
  }
}
