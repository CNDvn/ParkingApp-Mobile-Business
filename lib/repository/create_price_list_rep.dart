import 'package:parking_app_mobile_business/model/request/create_price_list_req.dart';
import 'package:parking_app_mobile_business/model/response/create_price_list_res.dart';

abstract class PriceListRepo {
  Future<PriceListRes> postPriceList(String url, String token,PriceListReq data);
}