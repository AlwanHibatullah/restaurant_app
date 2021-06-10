import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/styles/styles.dart';

class DetailNavbar extends StatelessWidget {
  final Restaurant restaurant;

  DetailNavbar({
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        duration: Duration(seconds: 3),
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
              child: Consumer<DatabaseProvider>(
                builder: (context, provider, _) {
                  return FutureBuilder<bool>(
                    future: provider.isFavorited(restaurant.id!),
                    builder: (context, snapshot) {
                      var isBookmarked = snapshot.data ?? false;
                      return IconButton(
                          onPressed: () => isBookmarked
                              ? provider.removeFavorite(restaurant.id!)
                              : provider.addFavorite(restaurant),
                          icon: Icon(
                            isBookmarked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: secondaryColor,
                            size: 32,
                          ));
                    },
                  );
                },
              )),
        ],
      ),
    );
  }
}
