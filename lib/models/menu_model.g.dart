// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
      foods: (json['foods'] as List<dynamic>)
          .map((e) => FoodModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((e) => FoodModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
      'foods': instance.foods,
      'drinks': instance.drinks,
    };
