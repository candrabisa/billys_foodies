import 'dart:convert';

import 'package:billys_foodies/models/menu_model.dart';
import 'package:billys_foodies/models/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantService {
  Future<List<RestaurantModel>> getRestaurant(BuildContext context) async {
    var baseUrl = await DefaultAssetBundle.of(context)
        .loadString('assets/json/local_restaurant.json');

    List parsed = jsonDecode(baseUrl)['restaurants'];
    List<RestaurantModel> restaurantModel = [];

    for (var element in parsed) {
      restaurantModel.add(RestaurantModel.fromJson(element));
    }
    return restaurantModel;
  }

  Future<List<MenuModel>> getMenu(BuildContext context) async {
    var baseUrl = await DefaultAssetBundle.of(context)
        .loadString('assets/json/local_restaurant.json');

    List parsed = jsonDecode(baseUrl)['restaurants']['food'];
    List<MenuModel> menuModel = [];

    for (var element in parsed) {
      menuModel.add(MenuModel.fromJson(element));
    }
    return menuModel;
  }
}
