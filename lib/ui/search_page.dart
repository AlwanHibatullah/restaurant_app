import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';
import 'package:restaurant_app/widgets/restaurant_item_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_page';

  final TextEditingController _controller = TextEditingController();

  Widget _buildListResult() {
    return Consumer<ListProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return ListView.builder(
            padding: EdgeInsets.only(bottom: 12),
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
            padding: EdgeInsets.only(bottom: 12),
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

  Widget _buildSearchField() {
    return Consumer<ListProvider>(
      builder: (context, provider, _) {
        return TextField(
          decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: () {
              _controller.clear();
              FocusScope.of(context).unfocus();
              provider.list();
            }, icon: Icon(Icons.clear)),
            hintText: 'Search...',
            hintStyle: GoogleFonts.raleway(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
          ),
          textInputAction: TextInputAction.done,
          controller: _controller,
          style: GoogleFonts.raleway(),
          onChanged: (value) {
            if (value.length < 1) return;
            provider.search(value);
          },
          onSubmitted: (value) {
            /*if (value.length < 1) return;
            provider.search(value);*/
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListProvider>(
      create: (_) => ListProvider(apiService: ApiService()),
      child: Scaffold(
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
                "Search...",
                style: GoogleFonts.playfairDisplay(
                    fontSize: 36, fontWeight: FontWeight.w700, height: 1.25),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: Text(
                "If you can't find it, search it!",
                style: GoogleFonts.raleway(
                    fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            _buildSearchField(),
            SizedBox(height: 16),
            _buildListResult()
          ],
        ),
      ),
    );
  }
}
