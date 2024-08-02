import 'package:dio/dio.dart';
import 'package:flutter_user_list/data/models/response/app/response_model.dart';
import 'package:flutter_user_list/data/models/response/user/user_model.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';
import 'package:flutter_user_list/domain/repositories/user/user_repository.dart';
import 'package:flutter_user_list/core/services/dio_services.dart';
import 'package:flutter_user_list/core/utils/url_constant.dart';

class UserRepositoryImpl with UserRepository {
  final DioClientService dioClientService = DioClientService();
  @override
  Future<List<UserEntity>> getAllUser(int page) async {
    List<UserEntity> userList = [];
    try {
      final response =
          await dioClientService.get(UrlConstant.getUserByPage(page));

      final responseData = ResponseModel.fromJson(response.data);

      if (responseData.data.isNotEmpty) {
        for (var e in responseData.data) {
          userList.add(
            UserEntity(
                id: e.id,
                email: e.email,
                firstName: e.firstName,
                lastName: e.lastName,
                avatar: e.avatar),
          );
        }
      }
    } catch (_) {
      rethrow;
    }
    return userList;
  }
}
