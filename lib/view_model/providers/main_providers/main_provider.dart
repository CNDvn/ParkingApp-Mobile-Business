import 'package:parking_app_mobile_business/view_model/providers/main_providers/enter_password_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/main_providers/sign_in_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/main_providers/user_profile_provider.dart';
import 'package:parking_app_mobile_business/view_model/providers/new_parking_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MainProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<SignInProvider>(
      create: (context) => SignInProvider(),
    ),
    ChangeNotifierProvider<UserProfileProvider>(
      create: (context) => UserProfileProvider(),
    ),
    ChangeNotifierProvider<EnterPasswordProvider>(
      create: (context) => EnterPasswordProvider(),
    ),
    ChangeNotifierProvider<NewParkingProvider>(
        create: (context) => NewParkingProvider())
  ];
}
