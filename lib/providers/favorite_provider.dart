import 'package:flutter/material.dart';

import '../../data/models/restaurant_result_model.dart';
import '../../helpers/database_helper.dart';
import '../../utils/result_state.dart';

class FavoriteProvider with ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider({required this.databaseHelper}) {
    _getRestaurantFav();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantElement> _favorite = [];
  List<RestaurantElement> get favorite => _favorite;

  void _getRestaurantFav() async {
    _favorite = await databaseHelper.getRestaurantFav();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Favorite is Empty';
    }
    notifyListeners();
  }

  void addRestaurantFav(RestaurantElement restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getRestaurantFav();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getRestaurantFavById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeRestaurantFav(String id) async {
    try {
      await databaseHelper.removeRestaurantFav(id);
      _getRestaurantFav();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
