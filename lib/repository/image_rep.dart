import 'dart:io';

import 'package:parking_app_mobile_business/model/response/image_res.dart';

abstract class ImageRepo {
  Future<ImageRes> postImage(String url, File image, String token);
}