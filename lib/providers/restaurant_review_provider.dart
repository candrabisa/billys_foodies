import 'package:flutter/material.dart';

import '../../data/services/api_service.dart';
import '../../data/models/restaurant_review_model.dart';

class RestaurantReviewProvider with ChangeNotifier {
  late RestaurantReviewModel _reviewModel;

  RestaurantReviewModel get reviewModel => _reviewModel;

  Future<bool> sendReviewRestaurant({
    String? id,
    String? name,
    String? review,
  }) async {
    try {
      if (await ApiService()
          .postAddReview(id: id, name: name, review: review)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
