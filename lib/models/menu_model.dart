import 'package:json_annotation/json_annotation.dart';
import 'package:billys_foodies/models/food_model.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class MenuModel {
  MenuModel({
    required this.foods,
    required this.drinks,
  });

  final List<FoodModel> foods;
  final List<FoodModel> drinks;

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);
}