
import 'package:parking_app_mobile_business/model/response/price_list_management_res.dart';

abstract class PriceListManagementRepo{
  Future<PriceListManagementRes> getAllPriceListByParking(String url, String idParking);
}