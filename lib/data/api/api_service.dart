import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

String loadImageUrl(String id) => "https://restaurant-api.dicoding.dev/images/medium/$id";

class ApiService {
  static final String baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantsResult> list() async {
    final url = Uri.parse(baseUrl+"list");
    final response = await http.get(url);
    if (response.statusCode == 200){
      return RestaurantsResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<RestaurantsDetailResult> detail(String id) async {
    final url = Uri.parse(baseUrl+"detail/$id");
    final response = await http.get(url);
    if (response.statusCode == 200){
      return RestaurantsDetailResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<RestaurantsResult> search(String query) async {
    final url = Uri.parse(baseUrl+"search?q=$query");
    final response = await http.get(url);
    if (response.statusCode == 200){
      return RestaurantsResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
}