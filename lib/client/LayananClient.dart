import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubesfix/entity/Layanan.dart';

class LayananClient {
  static const String _baseUrl = 'http://192.168.64.1/laravel_tubes/public/api/layanan';
  static List<Layanan> layanan = []; 

  static Future<List<Layanan>> fetchLayanan() async {
    final response = await http.get(Uri.parse('$_baseUrl'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      layanan = jsonResponse.map((data) => Layanan.fromJson(data)).toList();
      return layanan;
    } else {
      throw Exception('Failed to load layanan');
    }
  }
}



