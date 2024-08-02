import 'package:flutter_user_list/domain/entities/user/user_entity.dart';

abstract class UserRemoteDataSrc {
  Future<List<UserEntity>> getAllUser();
}
