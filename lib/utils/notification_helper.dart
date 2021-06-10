import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload : ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<String> _downloadAndSaveFile(String fileName, String id) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = "${directory.path}/$fileName";
    var response = await http.get(Uri.parse(loadImageUrl(id)));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var _channelId = "1";
    var _channelName = "Channel_01";
    var _channelDesc = "Restaurant Channel";

    var bigPicturePath =
        await _downloadAndSaveFile('bigPicture', restaurant.pictureId);

    var bigPictureStyle = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: bigPictureStyle);

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        attachments: [IOSNotificationAttachment(bigPicturePath)]);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        "Check Out Our Picked Restaurant For You!",
        restaurant.name,
        platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = Restaurant.fromJson(json.decode(payload));
      var restaurant = data;
      Navigator.pushNamed(context, route, arguments: restaurant);
    });
  }
}
