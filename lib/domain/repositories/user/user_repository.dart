import 'package:flutter_user_list/data/models/response/user/user_model.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';

mixin UserRepository {
  //get all user
  Future<List<UserEntity>> getAllUser(int page);
}
