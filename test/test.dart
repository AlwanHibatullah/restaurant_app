import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import 'test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Test API call', () {
    final client = MockClient();

    String id = 'rqdv5juczeskfw1e867';

    test('Get Restaurant List', () async {
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async {
        final String result =
            await rootBundle.loadString('assets/json/restaurant.json');
        return http.Response(result, 200);
      });

      expect(await ApiService().list(), isA<RestaurantsResult>());
    });

    test('Get Restaurant Detail', () async {
      when(client
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) async {
        final String result =
            await rootBundle.loadString('assets/json/restaurant_detail.json');
        return http.Response(result, 200);
      });

      expect(await ApiService().detail(id), isA<RestaurantsDetailResult>());
    });
  });
}
