import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StateWidget extends StatelessWidget {
  final String? imageFile;
  final String? title;

  StateWidget({
    required this.imageFile,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imageFile!,
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            title!,
            style:
                GoogleFonts.raleway(fontWeight: FontWeight.w400, fontSize: 18),
          )
        ],
      ),
    );
  }
}
