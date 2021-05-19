import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/14',
                    height: 320,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                ),
                Container(
                  margin: const EdgeInsets.all(18),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFFF6738),
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Melting Pot',
                    style: GoogleFonts.raleway(
                        fontSize: 32, fontWeight: FontWeight.w700),
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
                        'Medan',
                        style: GoogleFonts.raleway(fontSize: 14),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Description',
                    style: GoogleFonts.raleway(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
                    style: GoogleFonts.raleway(),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  backgroundColor: Color(0xFFFF6738)),
              child: Text(
                'Book Now!',
                style: GoogleFonts.raleway(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
