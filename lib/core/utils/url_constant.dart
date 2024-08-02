class UrlConstant {
  static const String getUser = "/api/users?page=1";
  static String getUserByPage(int page) => "/api/users?page=$page";
}
