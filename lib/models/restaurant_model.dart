import 'package:json_annotation/json_annotation.dart';
import 'package:billys_foodies/models/menu_model.dart';

part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final MenuModel menus;
  
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}