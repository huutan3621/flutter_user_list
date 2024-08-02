import 'package:dio/dio.dart';
import 'package:flutter_user_list/data/datasources/remote/user_remote_data_src.dart';
import 'package:flutter_user_list/data/models/response/app/response_model.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';
import 'package:flutter_user_list/services/dio_services.dart';
import 'package:flutter_user_list/utils/url_constant.dart';

class UserRepositoryImpl extends UserRemoteDataSrc {
  final DioClientService dioClientService;
  UserRepositoryImpl(this.dioClientService);

  @override
  Future<List<UserEntity>> getAllUser() async {
    List<UserEntity> userList = [];
    try {
      final response = await dioClientService.get(UrlConstant.getUser);

      final responseData = ResponseModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
    return userList;
  }
}
