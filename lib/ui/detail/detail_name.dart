import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:shimmer/shimmer.dart';

class DetailName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<DetailProvider>(builder: (context, provider, _) {
            var state = provider.state;
            switch (state) {
              case ResultState.Loading:
              case ResultState.NoData:
              case ResultState.Error:
                return Shimmer.fromColors(
                    child: Container(
                      width: double.infinity,
                      height: 32,
                      decoration: BoxDecoration(color: secondaryColor),
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white);
              case ResultState.HasData:
                final Restaurant restaurant = provider.detail!.restaurant;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Text(
                          restaurant.name,
                          style: GoogleFonts.raleway(
                              fontSize: 32, fontWeight: FontWeight.w700),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: supportColor1),
                        child: Wrap(
                          alignment: WrapAlignment.center,
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
                      ),
                    )
                  ],
                );
              default:
                return Container();
            }
          }),
          SizedBox(height: 8),
          Consumer<DetailProvider>(builder: (context, provider, _) {
            var state = provider.state;
            switch (state) {
              case ResultState.Loading:
              case ResultState.NoData:
              case ResultState.Error:
                return Shimmer.fromColors(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 14,
                      decoration: BoxDecoration(color: secondaryColor),
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white);
              case ResultState.HasData:
                final Restaurant restaurant = provider.detail!.restaurant;
                return Row(
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
                );
              default:
                return Container();
            }
          }),
        ],
      ),
    );
  }
}
