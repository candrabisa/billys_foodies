// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:billys_foodies/const/style.dart';
import 'package:flutter/material.dart';

import 'package:billys_foodies/models/food_model.dart';

class ListMenuWidget extends StatelessWidget {
  final FoodModel foodModel;
  final String images;

  const ListMenuWidget({
    Key? key,
    required this.foodModel,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1, color: kInactiveColor),
      ),
      child: Column(
        children: [
          Image.asset(
            images,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          Text(foodModel.name),
        ],
      ),
    );
  }
}
