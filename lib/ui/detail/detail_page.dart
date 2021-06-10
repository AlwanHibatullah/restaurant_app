import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/ui/detail/detail_category.dart';
import 'package:restaurant_app/ui/detail/detail_description.dart';
import 'package:restaurant_app/ui/detail/detail_image.dart';
import 'package:restaurant_app/ui/detail/detail_menu.dart';
import 'package:restaurant_app/ui/detail/detail_name.dart';
import 'package:restaurant_app/ui/detail/detail_navbar.dart';
import 'package:restaurant_app/ui/detail/detail_review.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const DetailPage({required this.restaurant});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
      bottomNavigationBar: DetailNavbar(
        restaurant: widget.restaurant,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<DetailProvider>(context, listen: false)
          .fetchDetail(widget.restaurant.id!);
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildScaffold(context));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }
}
