import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:parkingapp_mobile_business/views/root.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => const Root(),
  };
}