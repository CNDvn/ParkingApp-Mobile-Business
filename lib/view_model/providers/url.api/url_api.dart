class UrlApi {
  static const String serverPath = "http://13.70.20.93:5000/api/v1";
  static const String singInPath = '$serverPath/auths/login';
  static const String verifyOTPPath = '$serverPath/auths/verifyOTPSignUp';
  static const String signupPath = '$serverPath/auths/business';
  static const String getListMyParking =
      '$serverPath/parkings/OwnerParking?sizePage=500&currentPage=1&sort=ASC';
  static const String login = '$serverPath/auths/login';
  static const createParking = '$serverPath/parkings';
  static const String logoutPath = '@serverPath/logout';
}
