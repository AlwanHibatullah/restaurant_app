import 'package:flutter/foundation.dart';

import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class SettingsProvider with ChangeNotifier {
  final PreferencesHelper preferencesHelper;

  SettingsProvider({
    required this.preferencesHelper,
  }) {
    _getDailyNotificationPrefs();
  }

  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  void _getDailyNotificationPrefs() async {
    _isDailyNotificationActive =
        await preferencesHelper.isDailyNotificationActive;
    notifyListeners();
  }

  void enableDailyNotification(bool value) {
    preferencesHelper.setDailyNotification(value);
    _getDailyNotificationPrefs();
  }
}
