import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubesfix/client/api_config.dart';
import 'package:tubesfix/entity/Barber.dart';

class BarberClient {
  static String get _baseUrl => '${ApiConfig.baseUrl}/barber';

  static Future<List<Barber>> fetchBarbers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Barber.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load barbers');
    }
  }

  static Future<String> fetchBarberNameById(int barberId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$barberId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['nama_barber'] ?? jsonResponse['nama'] ?? 'Unknown Barber';
    } else {
      throw Exception('Failed to fetch barber name');
    }
  }
}
