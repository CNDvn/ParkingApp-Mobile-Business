import 'package:flutter/material.dart';
import 'package:parkingapp_mobile_business/constants/assets_path.dart';

class Root extends StatelessWidget {
  const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(child: Image.asset(AssetPath.logoPath), height: 200, width: 200,)
    );
  }
}