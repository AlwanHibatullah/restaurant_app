import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class ListProvider with ChangeNotifier {
  final ApiService apiService;

  ListProvider({required this.apiService}) {
    list();
  }

  RestaurantsResult? _result;
  String _message = '';
  ResultState? _state;

  RestaurantsResult? get result => _result;
  String get message => _message;
  ResultState? get state => _state;

  void list() {
    _fetchList();
  }

  void search(String query) {
    _fetchList(query: query);
  }

  Future<dynamic> _fetchList({String query = ""}) async {
    var checkConnection = await (Connectivity().checkConnectivity());
    if (checkConnection == ConnectivityResult.mobile || checkConnection == ConnectivityResult.wifi){
      try {
        _state = ResultState.Loading;
        notifyListeners();

        final RestaurantsResult restaurants;

        if (query.isEmpty) {
          restaurants = await apiService.list();
        } else {
          restaurants = await apiService.search(query);
        }

        if (restaurants.restaurants.isEmpty) {
          _state = ResultState.NoData;
          notifyListeners();
          return _message = "No Data";
        } else {
          _state = ResultState.HasData;
          notifyListeners();
          return _result = restaurants;
        }
      } catch (e) {
        _state = ResultState.Error;
        notifyListeners();
        return _message = "Error : $e";
      }
    } else if (checkConnection == ConnectivityResult.none){
      _state = ResultState.Error;
      notifyListeners();
      return _message = "No Internet Connection";
    }
  }
}
