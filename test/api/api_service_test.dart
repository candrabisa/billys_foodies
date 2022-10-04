import 'package:billys_foodies/data/models/restaurant_result_model.dart';
import 'package:billys_foodies/data/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch Restaurant Testing', () {
    test('return restaurant list when http response is successful', () async {
      final mockClient = MockClient();

      when(mockClient
              .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error": false, "message": "success", "count": 20, "restaurants": []}',
              200));
      expect(await ApiService().getRestaurantList(mockClient),
          isA<RestaurantResultModel>());
    });

    test('return error message when http response is unsuccessful', () {
      final mockClient = MockClient();

      when(mockClient
              .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService().getRestaurantList(mockClient),
          throwsException);
    });
  });
}
