import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/widgets/favorite_button_widget.dart';
import 'package:restaurant_app/widgets/foods_menu_widget.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  DetailPage({this.restaurant});

  List _menuList(List foods, List drinks) =>
      foods.map((e) => e.name).toList() + drinks.map((e) => e.name).toList();

  Widget _buildAndroid(BuildContext context){
    var menus = _menuList(restaurant.menus.foods, restaurant.menus.drinks);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: restaurant.pictureId,
                      child: ClipRRect(
                        child: Image.network(
                          // 'https://restaurant-api.dicoding.dev/images/medium/14',
                          restaurant.pictureId,
                          height: 320,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24)),
                      ),
                    ),
                    SafeArea(
                        child: InkWell(
                          child: Container(
                              margin: const EdgeInsets.all(18),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: secondaryColor,
                              ),
                              child: Icon(Icons.arrow_back, color: Colors.white)),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 24, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant.name,
                            style: GoogleFonts.raleway(
                                fontSize: 32, fontWeight: FontWeight.w700),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: supportColor1),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: supportColor3,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  restaurant.rating.toString(),
                                  style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                          ),
                          Text(
                            restaurant.city,
                            style: GoogleFonts.raleway(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Description',
                        style: GoogleFonts.raleway(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        restaurant.description,
                        style: GoogleFonts.raleway(),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Menu',
                        style: GoogleFonts.raleway(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Container(
                        child: TagView(
                          tagsName: menus,
                          backgroundColor: supportColor2,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: TextButton(
                  onPressed: () {
                    defaultTargetPlatform == TargetPlatform.iOS
                        ? showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Coming Soon'),
                            content: Text('This feature will coming soon'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Ok'),
                                onPressed: () {},
                              )
                            ],
                          );
                        })
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("This feature will coming soon"),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  child: Text(
                    'Book Now',
                    style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      backgroundColor: secondaryColor,
                      padding: EdgeInsets.all(8)),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: FavoriteButton(
                    size: 32,
                  )),
            ],
          ),
        ));
  }

  Widget _buildIOS(BuildContext context){
    var menus = _menuList(restaurant.menus.foods, restaurant.menus.drinks);
    return CupertinoPageScaffold(
      child: Material(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: restaurant.pictureId,
                          child: ClipRRect(
                            child: Image.network(
                              // 'https://restaurant-api.dicoding.dev/images/medium/14',
                              restaurant.pictureId,
                              height: 320,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24)),
                          ),
                        ),
                        SafeArea(
                            child: InkWell(
                              child: Container(
                                  margin: const EdgeInsets.all(18),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    color: secondaryColor,
                                  ),
                                  child: Icon(Icons.arrow_back, color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 18, right: 18, top: 24, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.name,
                                style: GoogleFonts.raleway(
                                    fontSize: 32, fontWeight: FontWeight.w700),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    color: supportColor1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                      color: supportColor3,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                              ),
                              Text(
                                restaurant.city,
                                style: GoogleFonts.raleway(fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Description',
                            style: GoogleFonts.raleway(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            restaurant.description,
                            style: GoogleFonts.raleway(),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Menu',
                            style: GoogleFonts.raleway(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Container(
                            child: TagView(
                              tagsName: menus,
                              backgroundColor: supportColor2,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextButton(
                      onPressed: () {
                        defaultTargetPlatform == TargetPlatform.iOS
                            ? showCupertinoDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('Coming Soon'),
                                content: Text('This feature will coming soon'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Ok'),
                                    onPressed: () {},
                                  )
                                ],
                              );
                            })
                            : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("This feature will coming soon"),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      child: Text(
                        'Book Now',
                        style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          backgroundColor: secondaryColor,
                          padding: EdgeInsets.all(8)),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: FavoriteButton(
                        size: 32,
                      )),
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIOS,
    );
  }
}
