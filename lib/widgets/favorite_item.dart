import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';

class FavoriteItem extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteItem({
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: supportColor2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  child: Image.network(
                    loadImageUrl(restaurant.pictureId),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Text(
                                    restaurant.name,
                                    style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: GoogleFonts.raleway(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        height: 6,
                      ),
                      Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              Icon(Icons.location_on, size: 14),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                restaurant.city,
                                style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                    ],
                  ),
                ))
          ],
        ),
      ),
      onTap: () => Navigator.pushNamed(context, DetailPage.routeName,
          arguments: restaurant),
    );
  }
}
