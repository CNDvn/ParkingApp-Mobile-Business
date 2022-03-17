import 'package:flutter/material.dart';
import 'package:parking_app_mobile_business/repository/impl/price_list_management_impl.dart';
import 'package:parking_app_mobile_business/view_model/providers/url.api/url_api.dart';
import 'package:parking_app_mobile_business/views/priceList/price_list_management_page.dart';

class PriceListManagementProvider with ChangeNotifier {
  void getAllPriceList(String idParking, BuildContext context) {
    PriceListManagementImpl()
        .getAllPriceListByParking(UrlApi.getPriceList, idParking)
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PriceListManagementPage(priceLists: value.result!),
          ));
    });
  }
}
