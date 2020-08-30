import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProfessionalShowcase extends StatelessWidget {
  final String professionalImage;
  final String professionalName;
  final int appointmentCharges;
  final String subService;
  final int experience;
  final String address;
  final double distance;
  final Function onTap;

  const ProfessionalShowcase({Key key,
    this.professionalImage,
    this.professionalName,
    this.appointmentCharges,
    this.subService,
    this.experience,
    this.address,
    this.distance,
    this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Material(
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        color: Color.fromRGBO(234, 245, 245, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: deviceWidth < 400
                      ? deviceWidth * 0.2
                      : deviceWidth * 0.2,
                  width: deviceWidth < 400
                      ? deviceWidth * 0.2
                      : deviceWidth * 0.2,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      professionalImage,
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        professionalName,
                        style: TextStyle(
                          color: Color.fromRGBO(56, 178, 227, 1),
                          fontSize: deviceWidth < 400 ? 12 : 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SmoothStarRating(
                        allowHalfRating: true,
                        rating: 4.5,
                        isReadOnly: true,
                        size: deviceWidth * 0.04,
                        starCount: 5,
                        spacing: 2.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        subService,
                        style: TextStyle(
                            fontSize: deviceWidth < 400 ? 10 : 15,
                            color: Color.fromRGBO(56, 178, 227, 1)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 20.0, top: 8.0,),
                  child: Text(
                    experience.toString() + " years experience in " +
                        subService,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: deviceWidth < 400 ? 10 : 15,
                        color: Color.fromRGBO(56, 178, 227, 1)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 20.0, top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: deviceWidth < 400 ? 10 : 15,
                        color: Color.fromRGBO(56, 178, 227, 1),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                            fontSize: deviceWidth < 400 ? 10 : 15,
                            color: Color.fromRGBO(56, 178, 227, 1)),
                      ),
                    ],
                  ),
                  Text(
                    distance == null ? "" : distance.toString() + " km ",
                    style: TextStyle(
                        fontSize: deviceWidth < 400 ? 10 : 15,
                        color: Colors.red),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0,bottom: 8.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("appointment charges : "+appointmentCharges.toString() + " usd",
                  style: TextStyle(
              fontSize: deviceWidth < 400 ? 10 : 15,
                  color: Colors.green),),
                ],
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                  text: "Book appointment",
                  color: Color.fromRGBO(56, 178, 227, 1),
                  textColor: Colors.white,
                  width: deviceWidth < 400
                      ? deviceWidth * 0.4
                      : deviceWidth * 0.4,
                  height: deviceWidth < 400
                      ? deviceHeight * 0.05
                      : deviceHeight * 0.05,
                  press: onTap,
                ),
                SizedBox(
                  width: 5,
                ),
                RoundedButton(
                  text: "View profile",
                  color: Colors.white,
                  textColor: Color.fromRGBO(56, 178, 227, 1),
                  width: deviceWidth < 400
                      ? deviceWidth * 0.4
                      : deviceWidth * 0.4,
                  height: deviceWidth < 400
                      ? deviceHeight * 0.05
                      : deviceHeight * 0.05,
                ),
              ],
            ),
          ],
        ));
  }




}
