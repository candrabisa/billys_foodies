import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/restaurant_search_model.dart';
import '../../data/models/restaurant_model.dart';
import '../../data/models/restaurant_result_model.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResultModel> getRestaurantList(http.Client client) async {
    var url = '$baseUrl/list';
    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return RestaurantResultModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load servers');
    }
  }

  Future<RestaurantModel> getRestaurantDetail(String id) async {
    var url = '$baseUrl/detail/$id';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(jsonDecode(response.body)['restaurant']);
    } else {
      throw Exception('Failed to load servers');
    }
  }

  Future<bool> postAddReview({
    String? id,
    String? name,
    String? review,
  }) async {
    var url = '$baseUrl/review';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'id': id, 'name': name, 'review': review});
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to review');
    }
  }

  Future<RestaurantSearchModel> getRestaurantSearch(String query) async {
    var url = '$baseUrl/search?q=$query';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return RestaurantSearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search result');
    }
  }
}
