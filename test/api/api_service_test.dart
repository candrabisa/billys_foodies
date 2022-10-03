import 'dart:convert';

import 'package:billys_foodies/data/models/restaurant_result_model.dart';
import 'package:billys_foodies/data/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

Future<RestaurantResultModel> fetchAllResto(MockClient mockClient) async {
    String baseUrl = 'https://restaurant-api.dicoding.dev';
    var url = '$baseUrl/list';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return RestaurantResultModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load servers');
    }
  }

void main() {
  group("getRestaurant", () {
    test("return restaurant list when http response is successful", () async {
      final mockClient = MockClient((request) async {
        final response = {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": [],
        };
        return http.Response(jsonEncode(response), 200);
      });
      expect(await fetchAllResto(mockClient),
          isA<RestaurantResultModel>());
    });

    test("return error message when http response is unsuccessful", () async {
      final mockClient = MockClient((request) async {
        final response = {
          "statusCode": 404,
          "error": "Not Found",
          "message": "Not Found"
        };
        return http.Response(jsonEncode(response), 404);
      });
      expect(await fetchAllResto(mockClient),
          isA<RestaurantResultModel>());
    });
  });
}
