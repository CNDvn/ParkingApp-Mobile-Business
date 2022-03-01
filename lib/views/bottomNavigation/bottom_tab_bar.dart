import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/views/userProfile/user_profile.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // double windowHeight = MediaQuery.of(context).size.height;
    // double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: scaffoldKey,
        drawer: const DrawerDefault(),
        body: Stack(children: [
          // PageStorage(
          //   child: currentScreen,
          //   bucket: bucket,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 28, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                  )),
                  SizedBox(
                    child: ClipOval(
                      child: Material(
                        color: AppColor.blueBackground,
                        child: InkWell(
                          splashColor: AppColor.whiteBackground,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const UserProfile();
                            }));
                          },
                          child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(AssetPath.profilePhoto)),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ]));
    // floatingActionButton: ActionButtonMid(
    //   currentTab: currentTab,
    // ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    // bottomNavigationBar: BottomAppBar(
    //   shape: const CircularNotchedRectangle(),
    //   notchMargin: windowWidth * 0.0155,
    //   child: SizedBox(
    //     height: windowHeight * 0.09,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             IconButtonStyle(
    //                 voidCallback: () {
    //                   setState(() {
    //                     currentScreen = screens[0];
    //                     currentTab = 0;
    //                   });
    //                 },
    //                 icon: Icons.home_outlined,
    //                 currentTab: currentTab,
    //                 tab: 0),
    //             IconButtonStyle(
    //                 voidCallback: () {
    //                   setState(() {
    //                     currentScreen = screens[1];
    //                     currentTab = 1;
    //                   });
    //                 },
    //                 icon: Icons.payment,
    //                 currentTab: currentTab,
    //                 tab: 1),
    //           ],
    //         ),
    // Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     IconButtonStyle(
    //         voidCallback: () {
    //           setState(() {
    //             currentScreen = screens[2];
    //             currentTab = 2;
    //           });
    //         },
    //         icon: Icons.history,
    //         currentTab: currentTab,
    //         tab: 2),
    //     IconButtonStyle(
    //         voidCallback: () {
    //           setState(() {
    //             currentScreen = screens[3];
    //             currentTab = 3;
    //           });
    //         },
    //         icon: Icons.settings,
    //         currentTab: currentTab,
    //         tab: 3),
    //   ],
    // )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}