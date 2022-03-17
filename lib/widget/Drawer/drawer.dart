import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/view_model/providers/logout_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/user_profile_provider.dart';
// import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/views/userProfile/user_profile.dart';
import 'package:provider/provider.dart';

class DrawerDefault extends StatelessWidget {
  const DrawerDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final SecureStorage secureStorage = SecureStorage();
    LogOutProvider provider = Provider.of<LogOutProvider>(context);
    UserProfileProvider userProfileprovider =
        Provider.of<UserProfileProvider>(context);
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
                  child: userProfileprovider.avatarSto != null
                      ? Image.network(userProfileprovider.avatarSto!)
                      : Image.asset(AssetPath.defaultAvatar),
                  backgroundColor: AppColor.whiteBackground,
                ),
                TextButton(
                  child: Text(
                      userProfileprovider.fullNameSto != null
                          ? userProfileprovider.fullNameSto!
                          : "Đức Hiếu",
                      style: AppTextStyles.h2Black),
                  onPressed: () async {
                    // final token = await secureStorage.readSecureData(
                    //     StorageEnum.accessToken.toShortString());
                    // await UsersRepImpl()
                    //     .getUsersMe(UrlApi.usersPath + "/me", token)
                    //     .then((value) async {
                    //   userProfileprovider.getProfile();
                    // });
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
              AssetPath.parkingList,
              width: sizeImage,
              height: sizeImage,
            ),
            title: const Text(
              'My Parking List',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/parkingManagement");
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text(
              'QR Code',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/QRCodeMyParking");
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code_scanner),
            title: const Text(
              'QR Scan',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/QRCodePage");
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
              provider.confirmSignOut(context);
            },
          )
        ],
      ),
    );
  }
}
