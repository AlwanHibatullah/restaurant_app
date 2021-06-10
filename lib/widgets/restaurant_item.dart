import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/styles/styles.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id!),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: supportColor2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: restaurant.pictureId,
                        child: ClipRRect(
                          child: Image.network(
                            loadImageUrl(restaurant.pictureId),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                        child: InkWell(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: secondaryColor),
                            child: isBookmarked
                                ? Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.favorite_border_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                          ),
                          onTap: () => isBookmarked
                              ? provider.removeFavorite(restaurant.id!)
                              : provider.addFavorite(restaurant),
                        ),
                        top: 12,
                        right: 12,
                      )
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant.name,
                              style: GoogleFonts.raleway(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
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
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 15),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              restaurant.city,
                              style: GoogleFonts.raleway(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
