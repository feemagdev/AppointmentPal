import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {

  final ValueChanged<String> onChanged;
  final  onTap;
  final onPressed;
  const SearchBar({
    Key key,
    this.onTap,
    this.onChanged, this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        onTap:onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search for professional",
          suffixIcon:IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: onPressed),
          border: InputBorder.none,

        ),
      ),
    );
  }
}
