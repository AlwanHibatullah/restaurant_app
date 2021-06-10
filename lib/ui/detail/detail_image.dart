import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:shimmer/shimmer.dart';

class DetailImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (context, state, _) {
        switch (state.state) {
          case ResultState.Loading:
            return SafeArea(
                child: Shimmer.fromColors(
                    child: Container(
                        width: double.infinity,
                        height: 320,
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ))),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white));
          case ResultState.HasData:
            final Restaurant restaurant = state.detail!.restaurant;
            return Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                child: Image.network(
                  loadImageUrl(restaurant.pictureId),
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
              ),
            );
          case ResultState.NoData:
            return ClipRRect(
              child: Image.asset(
                'assets/images/no_data.png',
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
            );
          case ResultState.Error:
            return ClipRRect(
              child: Image.asset(
                'assets/images/error.png',
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
            );
          default:
            return Center(
              child: Text(''),
            );
        }
      },
    );
  }
}
