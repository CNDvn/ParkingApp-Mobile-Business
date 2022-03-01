// import 'package:flutter/material.dart';
// import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
// import 'package:parking_app_mobile_business/views/parking/parking_management_page.dart';

// import 'package:provider/provider.dart';

// int currentTab = 0;

// Widget currentScreen = ParkingManagementPage();

// final List<Widget> screens = [ParkingManagementPage()];

// final PageStorageBucket bucket = PageStorageBucket();

// class IconButtonStyle extends StatelessWidget {
//   const IconButtonStyle(
//       {Key? key,
//       required this.voidCallback,
//       required this.icon,
//       required this.currentTab,
//       required this.tab})
//       : super(key: key);
//   final VoidCallback voidCallback;
//   final IconData icon;
//   final int currentTab;
//   final int tab;
//   @override
//   Widget build(BuildContext context) {
//     double windowWidth = MediaQuery.of(context).size.width;
//     return MaterialButton(
//       minWidth: windowWidth / 5,
//       onPressed: voidCallback,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: currentTab == tab
//                 ? AppColor.lightButton
//                 : AppColor.greyBackground,
//             size: 30,
//           ),
//         ],
//       ),
//     );
//   }
// }

// final List<IconData> iconMid = [
//   Icons.near_me_sharp,
//   Icons.qr_code_2,
//   Icons.query_builder,
//   Icons.build_rounded
// ];

// class ActionButtonMid extends StatelessWidget {
//   const ActionButtonMid({Key? key, required this.currentTab}) : super(key: key);
//   final int currentTab;

//   @override
//   Widget build(BuildContext context) {
//     MapProvider mapProvider = Provider.of<MapProvider>(context);
//     return FloatingActionButton(
//         backgroundColor: AppColor.lightButton,
//         child: Icon(
//           iconMid[currentTab],
//           size: 36,
//         ),
//         onPressed: () {
//           if (currentTab == 0) {
//             mapProvider.updatePosition();
//             return;
//           }          
//         });
//   }
// }