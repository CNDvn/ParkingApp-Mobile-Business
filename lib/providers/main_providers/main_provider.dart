import 'package:parking_app_mobile_business/providers/new_parking_provider.dart';
import 'package:parking_app_mobile_business/providers/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MainProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<SignInProvider>(
      create: (context) => SignInProvider(),
    ),
    ChangeNotifierProvider<NewParkingProvider>(
        create: (context) => NewParkingProvider())
  ];
}
