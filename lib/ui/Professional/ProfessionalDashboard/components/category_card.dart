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
    double deviceWidth = MediaQuery.of(context).size.width;
    double widthOfImage = 40;
    double heightOfImage = 40;
    double fontSize = 17;
    if (deviceWidth < 365 && deviceWidth > 330) {
      widthOfImage = 30;
      heightOfImage = 30;
      fontSize = 15;
    } else if (deviceWidth < 330) {
      widthOfImage = 30;
      heightOfImage = 30;
      fontSize = 10;
    }

    return Material(
      type: MaterialType.card,
      clipBehavior: Clip.antiAlias,
      color: Color.fromRGBO(248, 249, 251, 1),
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
                width: widthOfImage,
                height: heightOfImage,
              ),
              SizedBox(
                height: 10,
              ),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
