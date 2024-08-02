import 'package:flutter_user_list/data/models/response/user/user_model.dart';

abstract class UserRemoteDataSrc {
  Future<List<UserModel>> getAllUser(int page);
}
