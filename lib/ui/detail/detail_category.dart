import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/foods_menu_widget.dart';
import 'package:shimmer/shimmer.dart';

class DetailCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Consumer<DetailProvider>(
        builder: (context, provider, _) {
          var state = provider.state;
          switch (state) {
            case ResultState.Loading:
            case ResultState.NoData:
            case ResultState.Error:
              return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.white,
                child: TagView(
                  tagsName: ['________', '________'].map((e) => e).toList(),
                  backgroundColor: supportColor2,
                ),
              );
            case ResultState.HasData:
              final Restaurant restaurant = provider.detail!.restaurant;
              return TagView(
                tagsName: restaurant.categories.map((e) => e.name).toList(),
                backgroundColor: supportColor2,
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
