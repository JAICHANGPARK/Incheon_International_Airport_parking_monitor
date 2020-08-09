import 'dart:html';

import 'package:http/http.dart' as http;

Future fetchParkingData(String serviceKey) async {
  var response = await http.get("http://openapi.airport.kr/openapi/service/StatusOfParking/getTrackingParking"
      "?ServiceKey=$serviceKey");

  if (response.statusCode == HttpStatus.ok) {
    print(response.body);
  }
}
