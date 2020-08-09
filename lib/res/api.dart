

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

Future fetchParkingData(String serviceKey) async {
  var response = await http.get("http://openapi.airport.kr/openapi/service/StatusOfParking/getTrackingParking"
      "?ServiceKey=$serviceKey");

  if (response.statusCode == HttpStatus.ok) {
//    print(response.body);
    final document = XmlDocument.parse(utf8.decode(response.bodyBytes));
    print(document.toString());
  }
}
