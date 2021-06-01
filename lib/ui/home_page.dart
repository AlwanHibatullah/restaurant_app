import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';
import 'package:restaurant_app/widgets/restaurant_item_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  Widget _buildList(BuildContext context) {
    return Consumer<ListProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return ListView.builder(
            padding: EdgeInsets.only(left: 18, right: 18, bottom: 12),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => Shimmer.fromColors(
              child: RestaurantItemShimmer(),
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.white,
            ));
      } else if (state.state == ResultState.HasData) {
        final List<Restaurant> restaurant = state.result!.restaurants;
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 18, right: 18, bottom: 12),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: restaurant.length,
            itemBuilder: (context, index) {
              return InkWell(
                  child: RestaurantItem(restaurant: restaurant[index]),
                  onTap: () {
                    Navigator.pushNamed(context, DetailPage.routeName,
                        arguments: restaurant[index].id);
                  });
            });
      } else if (state.state == ResultState.NoData) {
        return Center(child: Text(state.message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.message));
      } else {
        return Center(child: Text(''));
      }
    });
  }

  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SafeArea(
            child: Align(
              child: InkWell(
                child: Container(
                    margin: const EdgeInsets.all(18),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: secondaryColor,
                    ),
                    child: Icon(Icons.search, color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, SearchPage.routeName);
                },
              ),
              alignment: Alignment.topRight,
            )),
        Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
          child: Text(
            "You're Not You\nWhen You're Hungry",
            style: GoogleFonts.playfairDisplay(
                fontSize: 36, fontWeight: FontWeight.w700, height: 1.25),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          margin: const EdgeInsets.only(bottom: 32),
          child: Text(
            "We've picked some favorite restaurant around you!",
            style:
                GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
        _buildList(context)
      ],
    ));
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(body: _buildPage(context));
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildPage(context));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListProvider>(
      create: (_) => ListProvider(apiService: ApiService()),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIOS,
      ),
    );
  }
}
