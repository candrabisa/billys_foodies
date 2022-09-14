import 'package:json_annotation/json_annotation.dart';

part 'food_model.g.dart';

@JsonSerializable()
class FoodModel {
  String name;

  FoodModel({
    required this.name,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodModelToJson(this);
}