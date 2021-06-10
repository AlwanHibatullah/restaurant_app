import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/favorite_item.dart';
import 'package:restaurant_app/widgets/state_widget.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: [
          SafeArea(
              child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: secondaryColor,
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 18, 18, 10),
            child: Text(
              "Favorites",
              style: GoogleFonts.playfairDisplay(
                  fontSize: 36, fontWeight: FontWeight.w700, height: 1.25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Text(
              "You have a good taste!",
              style: GoogleFonts.raleway(
                  fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Consumer<DatabaseProvider>(
            builder: (context, provider, _) {
              final List<Restaurant> restaurant = provider.favorites;
              if (provider.state == ResultState.HasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.favorites.length,
                  itemBuilder: (context, index) {
                    // return FavoriteItem(restaurant: provider.favorites[index]);
                    return Dismissible(
                      key: Key(restaurant[index].id!),
                      child: FavoriteItem(restaurant: restaurant[index]),
                      onDismissed: (direction) {
                        provider.removeFavorite(restaurant[index].id!);
                      },
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Delete Confirmation",
                                style: GoogleFonts.raleway(),
                              ),
                              content: Text(
                                  "Are you sure you want to delete this item?",
                                  style: GoogleFonts.raleway()),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text("Delete",
                                        style: GoogleFonts.raleway())),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("Cancel",
                                      style: GoogleFonts.raleway()),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Delete Favorite',
                                style: GoogleFonts.raleway(color: Colors.white))
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Delete Favorite',
                                style: GoogleFonts.raleway(color: Colors.white))
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return StateWidget(
                    imageFile: 'assets/images/no_data.svg', title: 'No Data');
              }
            },
          )
        ],
      ),
    );
  }
}
