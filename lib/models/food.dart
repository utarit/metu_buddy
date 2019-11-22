import 'package:http/http.dart' as http;
import 'dart:convert';

class Food {
  final List<dynamic> lunch;
  final List<dynamic> dinner;

  Food({this.lunch, this.dinner});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      lunch: json['ogle'],
      dinner: json['aksam'],
    );
  }

    static Future<Food> fetchFood() async {
    final response =
        await http.get('https://kafeterya.metu.edu.tr/service.php');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      dynamic body = json.decode(utf8.decode(response.bodyBytes)); 
      if(body == null){
        return Future.error("Body is null");
      } else {
        return Food.fromJson(body);
      }
    } else {
      // If that response was not OK, throw an error.
      return Future.error("Connection Error");
    }
  }
}