import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Services extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function onTap;

  const Services({Key key, this.svgSrc, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Material(
            type: MaterialType.circle,
            clipBehavior: Clip.antiAlias,
            color: Color.fromRGBO(234, 245, 245, 1),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.network(
                          svgSrc,
                          width: deviceHeight * 0.03,
                          height: deviceHeight * 0.03,
                          color: Color.fromRGBO(56, 178, 227, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 2,
        ),
        Text(
          title,

          style: TextStyle(
            color: Colors.white,
            fontSize: 13
          ),
        ),
      ],
    );
  }
}
