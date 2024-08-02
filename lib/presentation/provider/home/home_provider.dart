import 'package:flutter/material.dart';
import 'package:flutter_user_list/data/models/response/app/response_model.dart';
import 'package:flutter_user_list/data/models/response/user/user_model.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';
import 'package:flutter_user_list/services/dio_services.dart';
import 'package:flutter_user_list/utils/url_constant.dart';

class HomeProvider extends ChangeNotifier {
  //
  late bool isGridView = false;

  final DioClientService dioClientService = DioClientService();

  //function

  //change the view
  void changeView(bool viewValue) {
    isGridView = !viewValue;
    debugPrint(viewValue.toString());
    getAllUser();
    notifyListeners();
  }

  Future<List<UserEntity>> getAllUser() async {
    List<UserEntity> userList = [];
    final response = await dioClientService.get(UrlConstant.getUser);

    final responseData = ResponseModel.fromJson(response.data);

    return userList;
  }
}
