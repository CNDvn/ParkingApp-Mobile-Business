import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/configs/routes/routes.dart';
import 'package:parking_app_mobile_business/view_model/providers/main_providers/main_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MainProviders.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking App Business',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "OpenSans"),
        routes: Routes.routes,
      ),
    );
  }
}