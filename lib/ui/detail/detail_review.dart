import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:shimmer/shimmer.dart';

class DetailReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Consumer<DetailProvider>(
        builder: (context, provider, _) {
          var state = provider.state;
          switch (state) {
            case ResultState.Loading:
            case ResultState.NoData:
            case ResultState.Error:
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 70,
                      height: 16,
                      decoration: BoxDecoration(color: secondaryColor),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 85,
                    child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 16,
                                    decoration:
                                        BoxDecoration(color: secondaryColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height: 16,
                                    decoration:
                                        BoxDecoration(color: secondaryColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 16,
                                    decoration:
                                        BoxDecoration(color: secondaryColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            case ResultState.HasData:
              final Restaurant restaurant = provider.detail!.restaurant;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer Reviews',
                    style: GoogleFonts.raleway(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 85,
                    child: ListView.builder(
                        itemCount: restaurant.customerReviews.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var review = restaurant.customerReviews[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    review.name,
                                    style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    review.review,
                                    style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    review.date,
                                    style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
