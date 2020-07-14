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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(234, 245, 245, .23),
        borderRadius: BorderRadius.circular(29.5),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 20,
                offset: Offset(0, 0))
          ]
      ),
      child: TextField(
        onTap:onTap,
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Search for professional",
          hintStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 255, .80)
          ),
          suffixIcon:IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg",color: Colors.white,),
              onPressed: onPressed),
          border: InputBorder.none,

        ),
      ),
    );
  }
}
