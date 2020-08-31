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
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
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
              SvgPicture.asset(
                svgSrc,
                width: deviceHeight * 0.05,
                height: deviceHeight * 0.05,),
              SizedBox(height: 10,),
              Text(title,
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(
                      fontSize: deviceWidth < 400 ? 12:15,
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
