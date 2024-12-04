import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubesfix/entity/Barber.dart';

class BarberClient {
  static const String _baseUrl = 'http://192.168.0.102/laravel_tubes/public/api/barber'; 

  static Future<List<Barber>> fetchBarbers() async {
    final response = await http.get(Uri.parse('$_baseUrl/barbers'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Barber.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load barbers');
    }
  }
}
