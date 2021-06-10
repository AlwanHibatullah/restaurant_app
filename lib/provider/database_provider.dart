import 'package:flutter/foundation.dart';

import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider with ChangeNotifier {
  final DatabaseHelper helper;
  DatabaseProvider({
    required this.helper,
  }) {
    _getFavorites();
  }

  ResultState? _state;
  ResultState? get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await helper.getFavorite();
    if (_favorites.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }

    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await helper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = "Error : $e";
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favorited = await helper.getFavoriteById(id);
    return favorited.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await helper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = "Error : $e";
      notifyListeners();
    }
  }
}
