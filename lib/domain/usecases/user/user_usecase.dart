import 'package:flutter_user_list/domain/repositories/user/user_repository.dart';

class UserUsecase {
  final UserRepository _userRepository;

  const UserUsecase(this._userRepository);

  Future getAllUser(int page) async {
    return await _userRepository.getAllUser(page);
  }
}
