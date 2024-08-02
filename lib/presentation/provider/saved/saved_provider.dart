import 'package:flutter/material.dart';
import 'package:flutter_user_list/core/services/database_services.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';

class SavedProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<UserEntity> _favorites = [];

  List<UserEntity> get favorites => _favorites;

  Future<void> fetchFavorites() async {
    try {
      _favorites = await _databaseService.getUsers();
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

      notifyListeners();

      await fetchFavorites();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }
}
