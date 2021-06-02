import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/ui/detail/detail_category.dart';
import 'package:restaurant_app/ui/detail/detail_description.dart';
import 'package:restaurant_app/ui/detail/detail_image.dart';
import 'package:restaurant_app/ui/detail/detail_menu.dart';
import 'package:restaurant_app/ui/detail/detail_name.dart';
import 'package:restaurant_app/ui/detail/detail_navbar.dart';
import 'package:restaurant_app/ui/detail/detail_review.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final String restaurantId;

  DetailPage({required this.restaurantId});

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                DetailImage(),
                SafeArea(
                    child: InkWell(
                  child: Container(
                      margin: const EdgeInsets.all(18),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: secondaryColor,
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
              ],
            ),
            DetailName(),
            DetailCategory(),
            DetailDescription(),
            DetailMenu(),
            DetailReview()
          ],
        ),
      ),
      bottomNavigationBar: DetailNavbar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(restaurantId: restaurantId),
      child: _buildScaffold(context),
    );
  }
}

/* class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final String restaurantId;

  DetailPage({required this.restaurantId});

  Widget _buildDetail() {
    return Consumer<DetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return SafeArea(child: Center(child: CircularProgressIndicator()));
        } else if (state.state == ResultState.HasData) {
          final Restaurant restaurant = state.detail!.restaurant;
          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Stack(
                children: [
                  Hero(
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
                  ),
                  SafeArea(
                      child: InkWell(
                    child: Container(
                        margin: const EdgeInsets.all(18),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: secondaryColor,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ))
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 24, bottom: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
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
                      ),
                      SizedBox(height: 8),
                      Row(
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
                      ),
                      SizedBox(height: 12),
                      TagView(
                          tagsName: restaurant.categories.map((e) => e.name).toList(),
                          backgroundColor: supportColor2
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Description',
                        style: GoogleFonts.raleway(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        restaurant.description,
                        style: GoogleFonts.raleway(),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Foods',
                        style: GoogleFonts.raleway(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Container(
                        child: TagView(
                          tagsName: restaurant.menus.foods
                              .map((e) => e.name)
                              .toList(),
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
                          tagsName: restaurant.menus.drinks
                              .map((e) => e.name)
                              .toList(),
                          backgroundColor: supportColor2,
                        ),
                      ),
                      SizedBox(height: 16),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      review.name,
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      review.review,
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      review.date,
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ]),
              )
            ]),
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }

  Widget _buildNavBar(BuildContext context) {
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
                        duration: Duration(seconds: 1),
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
              child: FavoriteButton(
                size: 32,
              )),
        ],
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      body: _buildDetail(),
      bottomNavigationBar: _buildNavBar(context),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildScaffold(context));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(restaurantId: restaurantId),
        child: PlatformWidget(
          androidBuilder: _buildScaffold,
          iosBuilder: _buildIOS,
        ));
  }
}
 */
