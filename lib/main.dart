// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parking_app_mobile_business/configs/routes/routes.dart';
import 'package:parking_app_mobile_business/view_model/providers/main_providers/main_provider.dart';
import 'package:parking_app_mobile_business/view_model/service/service_storage.dart';
import 'package:parking_app_mobile_business/views/notification/notification_service.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("message ID: " + message.messageId);
}
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    FirebaseMessaging messaging;
  final SecureStorage secureStorage = SecureStorage();
  _registerOnFireBase() {
    messaging.subscribeToTopic("all");
    messaging.getToken().then((value) async {
      await secureStorage.writeSecureData("deviceToken", value);
    });
  }
  // This widget is the root of your application.  
  @override
  void initState() {
    // TODO: implement initState
    
     messaging = FirebaseMessaging.instance;
    _registerOnFireBase();
    getMessage();
    super.initState();
  }
  
void getMessage() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('Channel_id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification.android;
      if (message.notification != null) {
        await NotificationService().flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            platformChannelSpecifics,
            payload: 'item x');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {});
  }

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
