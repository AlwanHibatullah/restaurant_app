import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagView extends StatelessWidget {
  final List<dynamic> tagsName;
  final Color backgroundColor;

  TagView({required this.tagsName, required this.backgroundColor});

  List<Widget> _buildTagItem() {
    List<Widget> _tags = <Widget>[];
    for (int i = 0; i < tagsName.length; i++) {
      _tags.add(_buildTags(tagsName[i]));
    }
    return _tags;
  }

  Widget _buildTags(String tagTitle) {
    return InkWell(
      child: Chip(
        backgroundColor: backgroundColor,
        label: Text(
            tagTitle, style: GoogleFonts.raleway(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildTagView(BuildContext context){
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0
        ),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 5.0,
            direction: Axis.horizontal,
            children: _buildTagItem(),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTagView(context);
  }
}
