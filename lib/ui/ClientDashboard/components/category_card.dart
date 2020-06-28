import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;

  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(13),
      clipBehavior: Clip.antiAlias,
      elevation: 10.0,
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              LayoutBuilder(
                // ignore: missing_return
                builder: (context, constraints) {
                  // ignore: missing_return
                  if(constraints.maxWidth > 600) {
                    return getWideLayout();
                  } else {
                    print('else id run');
                    return getNormalLayout();
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget getWideLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          SvgPicture.asset(svgSrc),
          SizedBox(height: 5,),
          Text(title,
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600)),
        ],
      ),
    );

  }

  Widget getNormalLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          SvgPicture.asset(svgSrc,width: 40,height: 40,),
          Text(title,
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
