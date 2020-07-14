import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function onTap;

  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAlias,
      color:  Color.fromRGBO(234, 245, 245, 1),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(svgSrc,),
              SizedBox(height: 10,),
              Text(title,
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color:Color.fromRGBO(56, 178, 227, 1),
                  )),
            ],
          ),
        ),
      ),
    );
  }

}
