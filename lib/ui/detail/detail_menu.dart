import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/foods_menu_widget.dart';
import 'package:shimmer/shimmer.dart';

class DetailMenu extends StatelessWidget {
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
                  SizedBox(height: 4),
                  Container(
                      child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white,
                    child: TagView(
                      tagsName:
                          ['     ', '     ', '     '].map((e) => e).toList(),
                      backgroundColor: supportColor2,
                    ),
                  )),
                  SizedBox(height: 12),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 70,
                      height: 16,
                      decoration: BoxDecoration(color: secondaryColor),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                      child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white,
                    child: TagView(
                      tagsName:
                          ['     ', '     ', '     '].map((e) => e).toList(),
                      backgroundColor: supportColor2,
                    ),
                  ))
                ],
              );
            case ResultState.HasData:
              final Restaurant restaurant = provider.detail!.restaurant;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foods',
                    style: GoogleFonts.raleway(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    child: TagView(
                      tagsName:
                          restaurant.menus.foods.map((e) => e.name).toList(),
                      backgroundColor: supportColor2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Drinks',
                    style: GoogleFonts.raleway(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    child: TagView(
                      tagsName:
                          restaurant.menus.drinks.map((e) => e.name).toList(),
                      backgroundColor: supportColor2,
                    ),
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
