import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';

class SchedulingProvider with ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Notification Activated!');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      print('Scheduling Notification Canceled!');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
