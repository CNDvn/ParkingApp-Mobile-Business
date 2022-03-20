import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/model/entity/wallet.dart';
import 'package:parking_app_mobile_business/repository/impl/wallet_rep_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';
import "package:intl/intl.dart";
import '../../view_model/service/storage_enum.dart';

class Wallet extends StatefulWidget {
  Wallet({Key? key, this.wallet}) : super(key: key);
  Wallets? wallet;
  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    super.initState();
    final SecureStorage secureStorage = SecureStorage();
    secureStorage
        .readSecureData(StorageEnum.accessToken.toShortString())
        .then((accessToken) => {
              WalletRepImpl()
                  .getMyWallet(UrlApi.walletPath, accessToken)
                  .then((value) {
                setState(() {
                  widget.wallet = value.result;
                });
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        drawer: const DrawerDefault(),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    0, size.height * 0.05, 0, size.height * 0.05),
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            Title(
                                color: AppColor.greyBackground,
                                child: Text(
                                  "My Wallet",
                                  style: AppTextStyles.h2Black,
                                )),
                          ]),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100 / 2),
                              child: Image.asset(
                                AssetPath.profilePhoto,
                                height: 100.0,
                                width: 100.0,
                              ))),
                      Container(
                        margin: const EdgeInsets.all(40),
                        child: Text(
                          "Current Balance: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.blackText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          height: size.height * 0.08,
                          width: size.width * 0.9,
                          child: Text(
                            widget.wallet != null
                                ? NumberFormat.currency(locale: 'vi_VN').format(
                                    double.parse(widget.wallet!.currentBalance))
                                : "0",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.blueText,
                                fontSize: 40,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.only(top: size.height * 0.1),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: SizedBox(
                                height: size.height * 0.1,
                                width: size.width * 0.5,
                                child: Column(
                                  children: [
                                    Text(
                                      "Created Time: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blackText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.wallet != null
                                          ? DateFormat('dd-MM-yyyy – kk:mm')
                                              .format(
                                                  widget.wallet!.createdTime)
                                          : "0",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blueText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.only(top: size.height * 0.1),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: SizedBox(
                                height: size.height * 0.1,
                                width: size.width * 0.5,
                                child: Column(
                                  children: [
                                    Text(
                                      "Expired Time: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blackText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.wallet != null
                                          ? DateFormat('dd-MM-yyyy – kk:mm')
                                              .format(
                                                  widget.wallet!.expiredTime)
                                          : "0",
                                      // widget.wallet != null
                                      //     ? widget.wallet!.createdTime
                                      //     : "0",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: AppColor.blueText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]))));
  }
}
