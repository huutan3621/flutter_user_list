class UrlConstant {
  //static url
  static const String getUser = "/api/users?page=1";
  //url can update value
  static String getUserByPage(int page) => "/api/users?page=$page";
}
