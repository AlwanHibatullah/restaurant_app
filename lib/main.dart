import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/ui/favorites_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _helper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _helper.initNotification(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ListProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => DetailProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
            create: (_) => SettingsProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(helper: DatabaseHelper()))
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: secondaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: supportColor3),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          SearchPage.routeName: (context) => SearchPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
          SettingsPage.routeName: (context) => SettingsPage(),
        },
      ),
    );
  }
}
