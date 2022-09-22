import 'dart:io';

import 'package:flutter/material.dart';
import '../../data/models/restaurant_search_model.dart';
import '../../data/services/api_service.dart';

enum ResultState { loading, noData, hasData, error, noConn }

class RestaurantSearchProvider with ChangeNotifier {
  final ApiService apiService;
  // final String value;

  RestaurantSearchProvider({
    required this.apiService,
    // this.value = '',
  }) {
    fetchSearchRestaurant(query);
  }

  RestaurantSearchModel? _searchModel;
  ResultState? _state;
  String _query = '';
  String _message = '';

  RestaurantSearchModel? get searchModel => _searchModel;
  ResultState? get resultState => _state;
  String get query => _query;
  String get message => _message;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;
        notifyListeners();
        final getRestaurant = await apiService.getRestaurantSearch(query);

        if (getRestaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Data is Empty';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _searchModel = getRestaurant;
        }
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
