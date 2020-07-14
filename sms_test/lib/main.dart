import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    sendSms();
    return Container();
  }

  var username = "923361621400";
  var password = "faheem0336";
  var sender = "Apal";
  var mobile = "923361621400";
  var message = "reminder for your appointment at 3:50 pm \n from Apal";
  var date = "11-07-2020";
  var time = "14:54:00";

  Future sendSms() async{
    String request =
        "https://sendpk.com/api/sms.php?"
        "username="+username+"&"
        "password="+password+"&"
        "sender="+sender+"&"
        "mobile="+mobile+"&"
        "message="+message+"&"
        "date="+date+"&"
        "time="+time;
    http.Response response =await  http.get(
      Uri.encodeFull(request),
      headers: {
        "Accept":"Application/json"
      }
    );
    print(json.decode(response.body));
  }

}
