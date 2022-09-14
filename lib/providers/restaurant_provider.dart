import 'package:billys_foodies/models/restaurant_model.dart';
import 'package:billys_foodies/services/restaurant_service.dart';
import 'package:flutter/material.dart';

class RestaurantProvider with ChangeNotifier {
  List<RestaurantModel> _listRestaurant = [];
  List<RestaurantModel> get restaurantList => _listRestaurant;

  set restaurantList(List<RestaurantModel> restaurantList) {
    _listRestaurant = restaurantList;
    notifyListeners();
  }

  Future<void> getRestaurant(BuildContext context) async {
    try {
      List<RestaurantModel> restaurant =
          await RestaurantService().getRestaurant(context);
      _listRestaurant = restaurant;
    } catch (e) {
      Exception(e);
    }
  }
}
