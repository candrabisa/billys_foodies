import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const recommendResto = 'RECOMMEND_RESTO';

  Future<bool> get isRecommendResto async {
    final prefs = await sharedPreferences;
    return prefs.getBool(recommendResto) ?? false;
  }

  void setRecommendResto(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(recommendResto, value);
  }
}
