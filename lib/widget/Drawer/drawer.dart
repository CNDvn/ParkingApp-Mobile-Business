import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/views/userProfile/user_profile.dart';


class DrawerDefault extends StatelessWidget {
  const DrawerDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeImage = size.width * 0.08;
    return Drawer(
      backgroundColor: AppColor.whiteBackground,
      child: ListView(
        children: [
          SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: IconButton(
                          icon: Image.asset(AssetPath.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                  ],
                ),
                CircleAvatar(
                  radius: size.width * 0.1,
                  //backgroundImage: 
                  //const NetworkImage(AssetPath.profilePhoto)
                  child: Image.asset(AssetPath.profilePhoto),
                  backgroundColor: AppColor.whiteBackground,
                ),
                TextButton(
                  child: Text("Meo` 4`",
                      style: AppTextStyles.h2Black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfile()),
                    );
                  },
                )
              ],
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.creditCardPayment,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'Payment methods',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              log("choose payment");
            },
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.history,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'Parking History',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              log("Get history");
            },
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.promotions,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              "Promotion code",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              log("get promotion code");
            },
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.customerService,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'Support',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              log("View support");
            },
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.setting,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'Setting',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              log("View Setting");
            },
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: Image.asset(
              AssetPath.logout,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              log("logout");
            },
          )
        ],
      ),
    );
  }
}