class UrlApi {
  static const String serverPath =
      "https://parking-app-project.herokuapp.com/api/v1";
  static const String singInPath = '$serverPath/auths/login';
  static const String verifyOTPPath = '$serverPath/auths/verifyOTPSignUp';
  static const String signupPath = '$serverPath/auths/business';
  static const String getListMyParking = '$serverPath/parkings/OwnerParking?sizePage=500&currentPage=1&sort=ASC';
  static const String login = '$serverPath/auths/login';
  static const createParking = '$serverPath/parkings';
}
