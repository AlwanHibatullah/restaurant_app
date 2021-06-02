import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/widgets/favorite_button_widget.dart';

class DetailNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

/*



 */
