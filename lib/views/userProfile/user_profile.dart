import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/themes/app_color.dart';
import 'package:parking_app_mobile_business/configs/themes/app_text_style.dart';
import 'package:parking_app_mobile_business/constants/assets_path.dart';
import 'package:parking_app_mobile_business/view_model/providers/main_providers/user_profile_provider.dart';
import 'package:parking_app_mobile_business/widget/Drawer/drawer.dart';
import 'package:parking_app_mobile_business/widget/button/button.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    UserProfileProvider provider = Provider.of<UserProfileProvider>(context);
    Size size = MediaQuery.of(context).size;
    double sizeHeightInput = size.height * 0.12;
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerDefault(),
      body: SingleChildScrollView(
          child: Container(
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.05),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    "User Profile",
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
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Full name',
                      errorText: provider.clickButtonFlag
                          ? provider.fullName.error
                          : null),
                  autofocus: false,
                  onEditingComplete: () {
                    provider.nodeEmail.requestFocus();
                  },
                  onChanged: (String value) {
                    provider.checkFullName(value);
                  }),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Email address',
                    errorText:
                        provider.clickButtonFlag ? provider.email.error : null),
                focusNode: provider.nodeEmail,
                onEditingComplete: () {
                  provider.nodePhone.requestFocus();
                },
                onChanged: (value) {
                  provider.checkEmail(value);
                },
              ),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Phone number',
                    errorText:
                        provider.clickButtonFlag ? provider.phone.error : null),
                focusNode: provider.nodePhone,
                onEditingComplete: () {
                  provider.nodePassword.requestFocus();
                },
                onChanged: (value) {
                  provider.checkPhone(value);
                },
              ),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: provider.clickButtonFlag
                        ? provider.password.error
                        : null),
                focusNode: provider.nodePassword,
                onChanged: (value) {
                  provider.checkPassword(value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, size.height * 0.07, 0, 0),
              child: ButtonDefault(
                width: size.width,
                content: 'Save',
                voidCallBack: () => {provider.submit()},
              ),
            )
          ],
        ),
      )),
    );
  }
}
