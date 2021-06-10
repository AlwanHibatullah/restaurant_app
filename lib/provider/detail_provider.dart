import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailProvider with ChangeNotifier {
  final ApiService apiService;

  DetailProvider({required this.apiService});

  ResultState? _state;
  String _message = '';
  RestaurantsDetailResult? _detail;

  ResultState? get state => _state;
  String get message => _message;
  RestaurantsDetailResult? get detail => _detail;

  Future<dynamic> fetchDetail(String restaurantId) async {
    var checkConnection = await (Connectivity().checkConnectivity());
    if (checkConnection == ConnectivityResult.mobile ||
        checkConnection == ConnectivityResult.wifi) {
      try {
        _state = ResultState.Loading;
        notifyListeners();
        final restaurant = await apiService.detail(restaurantId);
        if (restaurant.restaurant == null) {
          _state = ResultState.NoData;
          notifyListeners();
          return _message = 'No Data';
        } else {
          _state = ResultState.HasData;
          notifyListeners();
          return _detail = restaurant;
        }
      } catch (e) {
        _state = ResultState.Error;
        notifyListeners();
        return _message = 'Error : $e';
      }
    } else if (checkConnection == ConnectivityResult.none) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "No Internet Connection";
    }
  }
}
