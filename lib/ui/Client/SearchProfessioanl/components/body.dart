import 'package:appointmentproject/ui/Client/ClientDashboard/components/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Body extends StatefulWidget {
  MapBody createState() => MapBody();
}

class MapBody extends State<Body> {
  GoogleMapController _controller;
  String searchAddress;

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            Positioned(
              top: 30,
              left: 15,
              right: 15,
              child: SearchBar(
                onPressed: () {
                    searchAndNavigate();
                },
                onChanged: (val) {
                  setState(() {
                    searchAddress = val;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  searchAndNavigate() {
    try{
    Geolocator().placemarkFromAddress(searchAddress).then((result) {
      print("value of result is "+ result[0].position.latitude.toString());
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }on PlatformException catch(err){
      print(err);
      print("platform run");
      showErrorFunction();
    }catch(err){
      print("catch run");
      showErrorFunction();
    }

  }

  void showErrorFunction(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("sorry professional is n"),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

}
