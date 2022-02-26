import 'package:parkingapp_mobile_business/providers/main_providers/enter_password_provider.dart';
import 'package:parkingapp_mobile_business/providers/main_providers/user_profile_provider.dart';
import 'package:parkingapp_mobile_business/providers/main_providers/sign_in_provider.dart';
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
  ];
}
