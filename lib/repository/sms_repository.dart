import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class SmsRepository {
  SmsRepository.defaultConstructor();

  Future<http.Response> sendSMS(String phone, String message) {
    final apiKey = "KEY0174C1137FF43D569B4B35C206F07E55_yjElmov6oRDocaURUIMhaL";
    return http.post(
      'https://api.telnyx.com/v2/messages',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(<String, String>{
        "from": "+18337110465",
        "to": phone,
        "text": message
      }),
    );
  }

  Future<bool> saveSmsDetails(Map map) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('sms').add(map);
    return true;
  }
}
