import 'package:flutter/material.dart';
import 'package:new_app/data/model/restaurant.dart';
import 'package:new_app/pages/detail_page.dart';
import 'package:new_app/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings?.arguments as Restaurant,
        )
      },
    );
  }
}