import 'dart:convert';
import 'package:http/http.dart' as http;

class Station {
  String urlResolved;
  String favicon;
  String name;

  Station({this.urlResolved, this.favicon, this.name});

  static Future<List> requestAPI() async {
    var result;
    final String urlAPI =
        "https://fr1.api.radio-browser.info/json/stations/bycountrycodeexact/id?hidebroken=true&order=clickcount&reverse=true&offset=0&limit=15";
    try {
      var response = await http.get(urlAPI);
      result = json.decode(response.body);
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }
}
