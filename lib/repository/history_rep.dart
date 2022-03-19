import 'package:parking_app_mobile_business/model/response/history_res.dart';

abstract class HistoryRepo {
  Future<HistoryRes> getHistory(String url, String accessToken);
}