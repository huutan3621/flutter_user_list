import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_user_list/connectivity.dart';
import 'package:flutter_user_list/core/services/database_services.dart';
import 'package:flutter_user_list/data/models/response/user/user_model.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';
import 'package:flutter_user_list/core/utils/url_constant.dart';
import 'package:flutter_user_list/domain/usecases/user/user_usecase.dart';
import 'package:flutter_user_list/main.dart';

class HomeProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final UserUsecase usecase = getIt.get<UserUsecase>();

  late bool isGridView = false;
  late bool enableLoadMore = true;
  late int page = 1;
  late List<UserEntity> userList = [];

  final List<UserEntity> favorites = [];

  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();

  Future<void> init(BuildContext context) async {
    await getAllUser();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    if (isOffline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hello, Snackbar!'),
        ),
      );
    }
  }

  void connectionChanged(dynamic hasConnection) {
    isOffline = !hasConnection;
  }

  void changeView(bool viewValue) {
    isGridView = !viewValue;
    notifyListeners();
  }

  Future<void> getAllUser() async {
    try {
      final userData = await usecase.getAllUser(page);

      if (userData.isNotEmpty) {
        userList = userList + userData;
      } else {
        enableLoadMore = false;
      }

      final favoriteUsers = await _databaseService.getUsers();
      final favoriteUserIds = favoriteUsers.map((user) => user.id).toSet();

      // Update the isFavorite status of each user
      for (var user in userList) {
        user.isFavorite = favoriteUserIds.contains(user.id);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching users: $e');
    }
  }

  Future<void> onLoadMore() async {
    if (enableLoadMore) {
      page++;
      await getAllUser();
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    enableLoadMore = true;
    userList.clear();
    notifyListeners();
    await getAllUser();
  }

  Future<void> fetchFavorites() async {
    try {
      favorites.clear();
      final favoriteUsers = await _databaseService.getUsers();
      favorites.addAll(favoriteUsers);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching favorites: $e');
    }
  }

  Future<void> toggleFavorite(UserEntity user) async {
    try {
      user.isFavorite = !user.isFavorite;

      // Update the database
      if (user.isFavorite) {
        await _databaseService.addUser(user);
      } else {
        await _databaseService.removeUser(user.id);
      }

      // Update the userList to reflect the change
      final index = userList.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        userList[index] = user;
      }

      notifyListeners();

      await fetchFavorites();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }
}
