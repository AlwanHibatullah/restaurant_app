import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/ui/favorites_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';
import 'package:restaurant_app/widgets/restaurant_item_shimmer.dart';
import 'package:restaurant_app/widgets/state_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final NotificationHelper _helper = NotificationHelper();

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
                        arguments: restaurant[index]);
                  });
            });
      } else if (state.state == ResultState.NoData) {
        return StateWidget(
            imageFile: 'assets/images/no_data.svg', title: 'No Data');
      } else if (state.state == ResultState.Error) {
        return StateWidget(
            imageFile: 'assets/images/no_connection.svg', title: state.message);
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
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              child: Container(
                  margin: const EdgeInsets.all(18),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: secondaryColor,
                  ),
                  child: Icon(Icons.menu, color: Colors.white)),
              onTap: () {
                _key.currentState!.openDrawer();
              },
            ),
            InkWell(
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
          ],
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
    return Scaffold(
        key: _key,
        body: _buildPage(context),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: secondaryColor),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Text(
                          'Restaurant App',
                          style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home', style: GoogleFonts.raleway()),
                onTap: () {
                  _key.currentState!.openEndDrawer();
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorites', style: GoogleFonts.raleway()),
                onTap: () {
                  _key.currentState!.openEndDrawer();
                  Navigator.pushNamed(context, FavoritePage.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings', style: GoogleFonts.raleway()),
                onTap: () {
                  _key.currentState!.openEndDrawer();
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
              )
            ],
          ),
        ));
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildPage(context));
  }

  @override
  void initState() {
    super.initState();
    _helper.configureSelectNotificationSubject(context, DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIOS,
    );
  }
}
