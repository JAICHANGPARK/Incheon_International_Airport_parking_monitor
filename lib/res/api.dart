

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:incheon_airport_parking/model/parking.dart';
import 'package:xml/xml.dart';

Future<List<Parking>> fetchParkingData(String serviceKey) async {
  var response = await http.get("http://openapi.airport.kr/openapi/service/StatusOfParking/getTrackingParking"
      "?ServiceKey=$serviceKey");

  if (response.statusCode == HttpStatus.ok) {
//    print(response.body);
    final document = XmlDocument.parse(utf8.decode(response.bodyBytes));
    print(document.toString());
    List<Parking> _parkingList = [];
    var _item =document.findAllElements("item");
  _item.forEach((element) {
      _parkingList.add(Parking(  element.findElements("datetm").first.text, element.findElements("floor").first.text, element.findElements("parking").first.text,
          element.findElements("parkingarea").first.text));
    });
    return _parkingList;
  }else{
    return null;
  }
}
