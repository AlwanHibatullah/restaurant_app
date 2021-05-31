import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailProvider with ChangeNotifier {
  final String restaurantId;

  DetailProvider({required this.restaurantId}) {
    _fetchDetail();
  }

  final apiService = ApiService();

  ResultState? _state;
  String _message = '';
  RestaurantsDetailResult? _detail;

  ResultState? get state => _state;
  String get message => _message;
  RestaurantsDetailResult? get detail => _detail;

  Future<dynamic> _fetchDetail() async {
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
