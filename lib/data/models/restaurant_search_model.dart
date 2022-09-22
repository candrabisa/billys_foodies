import 'package:billys_foodies/data/models/restaurant_result_model.dart';

class RestaurantSearchModel {
  final bool error;
  final int founded;
  final List<RestaurantElement> restaurants;

  RestaurantSearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchModel.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchModel(
          error: json['error'],
          founded: json['founded'],
          restaurants: List<RestaurantElement>.from(
              json['restaurants'].map((x) => RestaurantElement.fromJson(x))));

  Map<String, dynamic> toJson() => {
        'error': error,
        'founded': founded,
        'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
