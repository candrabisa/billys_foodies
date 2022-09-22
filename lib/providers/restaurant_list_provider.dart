import 'dart:io';

import 'package:flutter/material.dart';

import '../data/services/api_service.dart';
import '../data/models/restaurant_result_model.dart';

enum ResultState { loading, noData, hasData, error, noConn }

class RestaurantListProvider with ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({
    required this.apiService,
  }) {
    fetchAllRestaurant();
  }

  late RestaurantResultModel _restaurantResultModel;
  late ResultState _state;
  String _message = '';

  RestaurantResultModel get resultModel => _restaurantResultModel;
  ResultState get resultState => _state;
  String get message => _message;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      final restaurantResult = await apiService.getRestaurantList();
      notifyListeners();

      if (restaurantResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data is Empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResultModel = restaurantResult;
      }
    } on SocketException {
      _state = ResultState.noConn;
      notifyListeners();
      return _message = 'No Connection Internet';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
