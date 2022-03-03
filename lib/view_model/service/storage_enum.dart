enum StorageEnum{
  accessToken,
  refreshToken,
}

extension ParseToString on StorageEnum {
  String toShortString(){
    return toString().split('.').last;
  }
}