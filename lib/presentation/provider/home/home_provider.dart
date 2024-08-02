import 'package:flutter/material.dart';
import 'package:flutter_user_list/data/models/response/app/response_model.dart';
import 'package:flutter_user_list/data/models/response/user/user_model.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';
import 'package:flutter_user_list/core/services/dio_services.dart';
import 'package:flutter_user_list/core/utils/url_constant.dart';
import 'package:flutter_user_list/domain/usecases/user/user_usecase.dart';
import 'package:flutter_user_list/main.dart';

class HomeProvider extends ChangeNotifier {
  //

  final usecase = getIt.get<UserUsecase>();

  late bool isGridView = false;
  late bool enableLoadMore = true;
  late int page = 1;
  late List<UserEntity> userList = [];

  //function

  //init
  Future<void> init() async {
    await getAllUser();
  }

  //change the view
  void changeView(bool viewValue) {
    isGridView = !viewValue;
    notifyListeners();
  }

  Future<void> getAllUser() async {
    final userData = await usecase.getAllUser(page);
    if (userData.isNotEmpty) {
      userList = userList + userData;
    } else {
      enableLoadMore = false;
    }
    notifyListeners();
  }

  Future<void> onLoadMore() async {
    if (enableLoadMore == true) {
      page++;
      await getAllUser();
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    await getAllUser();
  }
}
