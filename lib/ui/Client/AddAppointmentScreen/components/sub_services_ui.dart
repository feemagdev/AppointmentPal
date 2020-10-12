import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubServicesUI extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function onTap;

  const SubServicesUI({Key key, this.svgSrc, this.title, this.onTap})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
   // String convertedTitle = this.title.replaceAll(" ", "\n");

    return Column(
      children: <Widget>[
        SizedBox(
          height: deviceWidth < 400 ? 50:75,
          child: Material(
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              color: Color.fromRGBO(234, 245, 245, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.network(
                            svgSrc,
                            width: deviceWidth < 400 ? 15:25,
                            height: deviceWidth < 400 ? 15:25,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: Color.fromRGBO(56, 178, 227, 1),
                                  fontSize: deviceWidth < 400 ? 10:20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),

      ],
    );
  }
}
