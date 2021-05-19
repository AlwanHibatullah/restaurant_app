import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/data/model/restaurant.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  Widget _buildRestaurantList(BuildContext context, Restaurant rest) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/14',
              fit: BoxFit.cover,
              height: 150,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Melting Pot',
                      style: GoogleFonts.raleway(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Color(0xFFFF6738),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '4.5',
                          style: GoogleFonts.raleway(
                              fontSize: 15, fontWeight: FontWeight.w400),
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
                      'Medan',
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
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> rest = parsedRestaurant(snapshot.data);
        return ListView.builder(
            itemCount: rest.length, itemBuilder: (context, index) {
              return _buildRestaurantList(context, rest[index]);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Text(
                    "You're Not You\nWhen You're Hungry",
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 36, fontWeight: FontWeight.w700, height: 1.25),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We've picked some favorite restaurant around you!",
                  style: GoogleFonts.raleway(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
