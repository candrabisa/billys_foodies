import 'dart:io';

import 'package:flutter/material.dart';

import '../data/models/restaurant_model.dart';
import '../data/services/api_service.dart';
import '../utils/result_state.dart';

class RestaurantDetailProvider with ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({
    required this.apiService,
    required this.id,
  }) {
    fetchDetailRestaurant(id);
  }

  late RestaurantModel _restaurantModel;
  RestaurantModel get restaurantModel => _restaurantModel;

  late ResultState _state;
  ResultState get resultState => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetailResult = await apiService.getRestaurantDetail(id);

      if (restaurantDetailResult.id == '') {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantModel = restaurantDetailResult;
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
