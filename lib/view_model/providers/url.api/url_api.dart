class UrlApi {
  static const String serverPath = "http://13.70.20.93:5000/api/v1";
  static const String singInPath = '$serverPath/auths/login';
  static const String verifyOTPPath = '$serverPath/auths/verifyOTPSignUp';
  static const String signupPath = '$serverPath/auths/business';
  static const String getListMyParking =
      '$serverPath/parkings/OwnerParking?sizePage=500&currentPage=1&sort=ASC';
  static const String login = '$serverPath/auths/login';
  static const createParking = '$serverPath/parkings';
  static const String logoutPath = '$serverPath/auths/logout';
  static const String walletPath = '$serverPath/wallets/me';
  static const String usersPath = '$serverPath/users';
  static const String imagesPath = '$serverPath/images';
  static const getParkingSlot = '$serverPath/parking-slots/parking/';
  static const getParkingSlotDetail = '$serverPath/parking-slots/';
  static const String getPriceList = '$serverPath/price-lists';
  static const String getAllTypeCar = '$serverPath/type-cars';
  static const String postPriceList = '$serverPath/price-lists';
}
