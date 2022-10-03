import 'package:flutter/material.dart';
import 'package:billys_foodies/helpers/preferences_helper.dart';

class PreferencesProvider with ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getRecommendResto();
  }

  bool _isRecommendRestoActive = false;
  bool get isRecommendRestoActive => _isRecommendRestoActive;

  void _getRecommendResto() async {
    _isRecommendRestoActive = await preferencesHelper.isRecommendResto;
    notifyListeners();
  }

  void enableRecommendResto(bool value) {
    preferencesHelper.setRecommendResto(value);
    _getRecommendResto();
  }
}
