import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/data/model/restaurant.dart';
import 'package:new_app/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  Widget _buildRestaurantList(BuildContext context, Restaurant rest) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: rest.pictureId,
              child: ClipRRect(
                child: Image.network(
                  rest.pictureId,
                  fit: BoxFit.cover,
                  height: 150,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
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
                        rest.name,
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
                            rest.rating.toString(),
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
                        rest.city,
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
      ),
      onTap: (){
        Navigator.pushNamed(context,
            DetailPage.routeName,
            arguments: rest
        );
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> rest = parsedRestaurant(snapshot.data);
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 18, right: 18, bottom: 12),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: rest.length,
            itemBuilder: (context, index) {
              return _buildRestaurantList(context, rest[index]);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
              child: Container(
            padding: const EdgeInsets.fromLTRB(18, 48, 18, 10),
            child: Text(
              "You're Not You\nWhen You're Hungry",
              style: GoogleFonts.playfairDisplay(
                  fontSize: 36, fontWeight: FontWeight.w700, height: 1.25),
            ),
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            margin: const EdgeInsets.only(bottom: 32),
            child: Text(
              "We've picked some favorite restaurant around you!",
              style: GoogleFonts.raleway(
                  fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          _buildList(context)
        ],
      )),
    ));
  }
}
